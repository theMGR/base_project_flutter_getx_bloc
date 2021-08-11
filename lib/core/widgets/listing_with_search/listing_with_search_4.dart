import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/core/exceptions/app_exceptions.dart';
import 'package:project/core/utils/network_utils.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/core/utils/validation_utils.dart';
import 'package:project/res/constants/constant_color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum ListingWithSearchItemType { TYPE_CARD, TYPE_CONTAINER }

abstract class ListingWithSearchListener<Item> {
  void onListProcessing({String? searchText, String? filterColumn, bool? paging, int? limit, String? minDate, String? maxDate, int? pageNumber});

  Widget onCreateListItem({BuildContext? context, Item? item, int? index, List<Item>? items});

  String? getSavedDate(Item item);
}

enum SearchType { SEARCH_DIALOG, SEARCH_LIST_BOTTOM }

class ListingWithSearch4<Item> extends StatefulWidget {
  final double borderRadiusSearchBar;
  final double borderRadiusSearchFilterItem;
  final double borderRadiusItem;
  final EdgeInsetsGeometry itemMargin;
  final Color itemBorderColor;
  final EdgeInsetsGeometry itemPadding;
  final int filterIndex;
  final ListingWithSearchListener listener;
  final List filterTexts;
  final List filterColumns;
  final bool isSearchEnabled;
  final String searchText;
  final bool paging;
  final int pageSize;
  final ListingWithSearchItemType listingWithSearchItemType;
  final Color listItemBackgroundColor;
  final SearchType searchType;
  final bool isPaginationBasedOnPageNumber;
  final bool enablePullUp;
  final bool enablePullDown;

  ListingWithSearch4(
      {Key? key,
      required this.listener,
      this.filterTexts = const [],
      this.filterColumns = const [],
      this.isSearchEnabled = false,
      this.searchText = "",
      this.paging = true,
      this.pageSize = 5,
      this.listingWithSearchItemType = ListingWithSearchItemType.TYPE_CARD,
      this.listItemBackgroundColor = Colors.white,
      this.searchType = SearchType.SEARCH_LIST_BOTTOM,
      this.isPaginationBasedOnPageNumber = false,
      this.borderRadiusSearchBar = 0,
      this.borderRadiusItem = 0,
      this.borderRadiusSearchFilterItem = 30,
      this.itemMargin = const EdgeInsets.only(left: 5, right: 5, top: 5),
      this.itemBorderColor = Colors.white,
      this.itemPadding = const EdgeInsets.all(10),
      this.filterIndex = -1,
      this.enablePullUp = true,
      this.enablePullDown = true})
      : super(key: key);

  @override
  ListingWithSearchState4 createState() => ListingWithSearchState4<Item>(
      searchText: searchText,
      listener: listener,
      filterTexts: filterTexts,
      filterColumns: filterColumns,
      isSearchEnabled: isSearchEnabled,
      paging: paging,
      pageSize: pageSize,
      listingWithSearchItemType: listingWithSearchItemType,
      searchType: searchType,
      isPaginationBasedOnPageNumber: isPaginationBasedOnPageNumber,
      listItemBackgroundColor: listItemBackgroundColor,
      itemMargin: itemMargin,
      borderRadiusItem: borderRadiusItem,
      borderRadiusSearchBar: borderRadiusSearchBar,
      borderRadiusSearchFilterItem: borderRadiusSearchFilterItem,
      itemBorderColor: itemBorderColor,
      itemPadding: itemPadding,
      filterIndex: filterIndex,
      enablePullUp: enablePullUp,
      enablePullDown: enablePullDown);
}

class ListingWithSearchState4<Item> extends State<ListingWithSearch4> {
  final double borderRadiusSearchBar;
  final double borderRadiusSearchFilterItem;
  final double borderRadiusItem;
  final EdgeInsetsGeometry itemMargin;
  final Color itemBorderColor;
  final EdgeInsetsGeometry itemPadding;
  int filterIndex;
  final ListingWithSearchListener listener;
  final SearchType searchType;
  final bool isPaginationBasedOnPageNumber;
  final bool enablePullUp;
  final bool enablePullDown;
  final List filterTexts;
  final List filterColumns;
  bool isSearchEnabled;
  String searchText;
  final bool paging;
  final int pageSize;
  final ListingWithSearchItemType listingWithSearchItemType;
  final Color listItemBackgroundColor;
  Timer? _debounce;

  /*minDate, maxDate*/
  String? minDate = "";
  String? maxDate = "";

  /*page number*/
  int _pageNumber = 1;
  int _pageNumberLastSaved = 1;

  String _filterColumn = "";
  TextEditingController _searchTextEditingController = TextEditingController();

  /*refresh configuration*/
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refreshKey = GlobalKey();

  /*list data*/
  List<Item> data = [];

  /*initial containers*/
  //Widget _initialContent = Container();
  Widget _retryContent = Container();

  //Widget _mainContent = Container();
  Widget _listContent = Container();

  bool _onException = false;

  /*search process*/
  String _searchHint = "Enter Search keyword..";
  bool _deleteTextIconVisible = false;

  bool _enablePullUp = false;
  bool _enablePullDown = false;

  ListingWithSearchState4(
      {required this.listener,
      required this.searchText,
      required this.filterTexts,
      required this.filterColumns,
      required this.isSearchEnabled,
      required this.paging,
      required this.pageSize,
      required this.listingWithSearchItemType,
      required this.listItemBackgroundColor,
      required this.searchType,
      required this.isPaginationBasedOnPageNumber,
      required this.borderRadiusSearchBar,
      required this.borderRadiusItem,
      required this.borderRadiusSearchFilterItem,
      required this.itemMargin,
      required this.itemBorderColor,
      required this.itemPadding,
      required this.filterIndex,
      required this.enablePullUp,
      required this.enablePullDown});

  @override
  void initState() {
    _listContent = _initialContent();

    _pageNumber = 1;
    _pageNumberLastSaved = _pageNumber;
    listener.onListProcessing(
        searchText: searchText,
        filterColumn: ValidationUtils.isEmpty(_filterColumn) || ValidationUtils.isEmpty(searchText) ? "" : _filterColumn,
        limit: pageSize,
        paging: paging,
        minDate: minDate,
        maxDate: maxDate,
        pageNumber: _pageNumber);

    super.initState();
  }

  Widget _initialContent() {
    if (searchText.isNotEmpty) {
      _searchTextEditingController.text = searchText;
      _deleteTextIconVisible = true;
    } else {
      _searchTextEditingController.text = "";
      _deleteTextIconVisible = false;
    }

    if (filterColumns.isNotEmpty &&
        filterTexts.isNotEmpty &&
        filterColumns.length == filterTexts.length &&
        filterIndex >= 0 &&
        filterIndex < filterColumns.length) {
      _searchHint = "Search by ${filterTexts[filterIndex]}";
      _filterColumn = filterColumns[filterIndex];
    } else {
      _searchHint = "Enter Search keyword..";
      filterIndex = -1;
      _filterColumn = "";
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.hourglassEnd,
            size: 60,
          ),
          SizedBox(height: 10),
          Text('Please wait')
        ],
      ),
    );
  }

  void setItems({List<Item> items = const []}) {
    _onException = false;
    _retryContent = Container();

    if (items.length > 0) {
      Print.Reference("DATA LENGTH ${items.length}");
      data.addAll(items);
    } else {
      if (isPaginationBasedOnPageNumber) {
        _pageNumber--;

        if (_pageNumber <= 0) {
          _pageNumber = 1;
        }
        _pageNumberLastSaved = _pageNumber;
      }
    }

    if (data.length == 0) {
      isSearchEnabled = isSearchEnabled && filterIndex >= 0 ? true : false;
      Print.Reference("current index $filterIndex _isSearchEnabled $isSearchEnabled");
    } else if (data.length > 0) {
      isSearchEnabled = isSearchEnabled;
    }

    setState(() {
      _enablePullUp = true;
      _enablePullDown = true;
      if (items.isEmpty && data.isEmpty) {
        isSearchEnabled = isSearchEnabled && filterIndex >= 0 ? true : false;
        _listContent = _buildRetryContent(text: "Sorry, No records found!", isRetryButtonEnabled: false, isRetryToBottomView: false);
      } else {
        _listContent = _buildListView();
      }
    });
  }

  void onRefreshListView() {
    setState(() {
      _listContent = _buildListView();
    });
  }

  void onRefresh({bool isResetSearchText = false, bool isResetFilterColumn = false}) {
    if (isResetSearchText) {
      searchText = "";
      filterIndex = filterIndex;
      _filterColumn = "";
    }
    if (isResetFilterColumn) {
      filterIndex = filterIndex;
      _filterColumn = "";
    }

    _onRefresh();
  }

  void onAppExceptions(AppExceptions appExceptions) {
    if (data.length == 0) {
      isSearchEnabled = filterIndex >= 0 && isSearchEnabled ? true : false;
    } else if (data.length > 0) {
      isSearchEnabled = isSearchEnabled;
    }

    if (isPaginationBasedOnPageNumber) {
      _pageNumber--;

      if (_pageNumber <= 0) {
        _pageNumber = 1;
      }
      _pageNumberLastSaved = _pageNumber;
    }

    setState(() {
      _retryContent = _buildRetryContent(
          text: appExceptions.getErrorType() == NETWORK_ERROR_TYPE.NO_INTERNET_CONNECTION ? "No Internet Connection!" : "Something went wrong!",
          isRetryButtonEnabled: true,
          isRetryToBottomView: data.length > 0 ? true : false);

      _onException = true;
      _enablePullUp = false;
      _enablePullDown = true;
      if (data.length > 0) {
        _listContent = _buildListView();
      } else {
        _listContent = _retryContent;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _refreshConfiguration(),
    ));
  }

  Widget _refreshConfiguration() {
    Widget refreshConfig = Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        isSearchEnabled ? _searchContainer() : Container(),
        Expanded(
          child: RefreshConfiguration(
            headerBuilder: () => WaterDropMaterialHeader(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            footerBuilder: () => ClassicFooter(),
            headerTriggerDistance: 30.0,
            maxOverScrollExtent: 100,
            maxUnderScrollExtent: 0,
            enableScrollWhenRefreshCompleted: true,
            enableLoadingWhenFailed: true,
            hideFooterWhenNotFull: false,
            enableBallisticLoad: true,
            footerTriggerDistance: 30,
            child: SmartRefresher(
                key: _refreshKey,
                controller: _refreshController,
                enablePullUp: enablePullUp ? _enablePullUp : false,
                enablePullDown: enablePullDown ? _enablePullDown : false,
                physics: BouncingScrollPhysics(),
                footer: ClassicFooter(
                  loadStyle: LoadStyle.ShowWhenLoading,
                ),
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: _listContent),
          ),
        ),
      ],
    );

    return refreshConfig;
  }

  Widget _buildListView() {
    Widget listView = ListView.builder(
        key: _contentKey,
        itemBuilder: (context, index) {
          return Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cardOrContainer(child: listener.onCreateListItem(context: context, item: data[index], index: index, items: data)),
                  _onException == true && index == data.length - 1 ? _retryContent : Container()
                ],
              ));
        },
        itemCount: data.length);

    if (data.length > 0) {
      return listView;
    } else {
      return _buildRetryContent(text: "Sorry, No records found!", isRetryButtonEnabled: false, isRetryToBottomView: false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _searchTextEditingController.dispose();
    _debounce?.cancel();
    _refreshController.dispose();
  }

  void _onRefresh() async {
    Print.Reference("Refresh");
    Print.Reference("before refresh filterIndex $filterIndex");
    //filterIndex = filterIndex;
    Print.Reference("after refresh filterIndex $filterIndex");

    /*clear old data*/
    data.clear();
    minDate = "";

    _refreshKey.currentState?.setState(() {
      _listContent = _initialContent();
    });

    _pageNumber = 1;
    _pageNumberLastSaved = _pageNumber;
    listener.onListProcessing(
        searchText: searchText,
        filterColumn: ValidationUtils.isEmpty(_filterColumn) || ValidationUtils.isEmpty(searchText) ? "" : _filterColumn,
        limit: pageSize,
        paging: paging,
        minDate: minDate,
        maxDate: maxDate,
        pageNumber: _pageNumber);

    await Future.delayed(Duration(seconds: 1));

    _refreshKey.currentState?.setState(() {
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    Print.Reference("_onLoading");
    Print.Reference("data length: ${data.length}");
    Print.Reference(data.length - 2);

    minDate = ValidationUtils.isEmpty(listener.getSavedDate(data.last)) ? "" : listener.getSavedDate(data.last);

    if (isPaginationBasedOnPageNumber) {
      _pageNumber++;
      _pageNumberLastSaved = _pageNumber;
      minDate = "";
    } else {
      _pageNumber = 1;
      _pageNumberLastSaved = _pageNumber;
    }
    listener.onListProcessing(
        searchText: searchText,
        filterColumn: ValidationUtils.isEmpty(_filterColumn) || ValidationUtils.isEmpty(searchText) ? "" : _filterColumn,
        limit: pageSize,
        paging: paging,
        minDate: minDate,
        maxDate: maxDate,
        pageNumber: _pageNumber);

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _refreshController.loadComplete();
    });
  }

  void _onRetryClicked() async {
    if (data.length == 0) {
      setState(() {
        _listContent = _initialContent();
      });
    }

    if (isPaginationBasedOnPageNumber) {
      _pageNumber = _pageNumberLastSaved;
      minDate = "";
    }

    listener.onListProcessing(
        searchText: searchText,
        filterColumn: ValidationUtils.isEmpty(_filterColumn) || ValidationUtils.isEmpty(searchText) ? "" : _filterColumn,
        limit: pageSize,
        paging: paging,
        minDate: minDate,
        maxDate: maxDate,
        pageNumber: _pageNumber);

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _refreshController.loadComplete();
    });
  }

  Widget _buildRetryContent({required String text, bool isRetryButtonEnabled = true, bool isRetryToBottomView = true}) {
    Widget retryContainer = isRetryButtonEnabled
        ? TextButton(
            onPressed: () => {_onRetryClicked()},
            child: Text(isRetryToBottomView == true ? 'Tap to Retry' : 'Retry'),
            style: TextButton.styleFrom(
              primary: Colors.teal,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ))
        : Container();

    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: isRetryToBottomView == true
          ? Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(text),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.sadCry, size: 24),
                  retryContainer,
                ],
              )
            ])
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.sadCry, size: 60),
                SizedBox(
                  height: 20,
                ),
                Text(text),
                SizedBox(
                  height: 20,
                ),
                retryContainer
              ],
            ),
    );
  }

  Widget _cardOrContainer({required Widget child}) {
    if (listingWithSearchItemType == ListingWithSearchItemType.TYPE_CARD) {
      return Card(
        margin: itemMargin,
        child: Container(padding: itemPadding, child: child),
        color: listItemBackgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: itemBorderColor, width: 1),
          borderRadius: BorderRadius.circular(borderRadiusItem),
        ),
      );
    } else {
      return Container(
          padding: itemPadding,
          margin: itemMargin,
          child: child,
          decoration: BoxDecoration(
              color: listItemBackgroundColor, border: Border.all(width: 1, color: itemBorderColor), borderRadius: BorderRadius.circular(borderRadiusItem)));
    }
  }

  Widget _searchContainer() {
    return StatefulBuilder(builder: (context, setState2) {
      Widget searchFilterDialog = filterColumns.isNotEmpty && filterTexts.isNotEmpty && filterColumns.length == filterTexts.length && filterColumns.length > 1
          ? IconButton(
              icon: Icon(FontAwesomeIcons.filter),
              onPressed: () {
                _showSearchFilterDialog();
              })
          : Container();

      Widget searchFilterHorizontal =
          filterColumns.isNotEmpty && filterTexts.isNotEmpty && filterColumns.length == filterTexts.length && filterColumns.length > 1
              ? _showSearchFilter(setState2)
              : Container();

      return Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadiusSearchBar), border: Border.all(width: 1, color: Colors.grey)),
            child: Row(
              children: [
                searchType == SearchType.SEARCH_DIALOG
                    ? IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          if (!ValidationUtils.isEmpty(_searchTextEditingController.text)) {
                            //_onSearch();
                          }
                        },
                      )
                    : Container(),
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    controller: _searchTextEditingController,
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(5), hintText: _searchHint, border: InputBorder.none),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState2(() {
                          _deleteTextIconVisible = false;
                        });
                      } else {
                        setState2(() {
                          _deleteTextIconVisible = true;
                        });
                      }

                      if (_debounce?.isActive ?? false) _debounce?.cancel();
                      _debounce = Timer(const Duration(milliseconds: 500), () {
                        _onSearch();
                      });
                    },
                  ),
                ),
                _deleteTextIconVisible
                    ? IconButton(
                        icon: Icon(FontAwesomeIcons.backspace),
                        onPressed: () {
                          _searchTextEditingController.text = "";
                          setState2(() {
                            _deleteTextIconVisible = false;
                            if (filterColumns.isNotEmpty &&
                                filterTexts.isNotEmpty &&
                                filterColumns.length == filterTexts.length &&
                                filterIndex >= 0 &&
                                filterIndex < filterColumns.length) {
                              _searchHint = "Search by ${filterTexts[filterIndex]}";
                              _filterColumn = filterColumns[filterIndex];
                              Print.Reference("on click delete icon $_filterColumn");
                              filterIndex = filterIndex;
                            }
                          });
                          _onSearch();
                        })
                    : Container(),
                searchType == SearchType.SEARCH_LIST_BOTTOM
                    ? IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          if (!ValidationUtils.isEmpty(_searchTextEditingController.text)) {
                            _onSearch();
                          }
                        },
                      )
                    : Container(),
                searchType == SearchType.SEARCH_DIALOG ? searchFilterDialog : Container()
              ],
            ),
          ),
          searchType == SearchType.SEARCH_LIST_BOTTOM ? searchFilterHorizontal : Container()
        ],
      );
    });
  }

  void _onSearch() {
    if (filterColumns.isNotEmpty &&
        filterTexts.isNotEmpty &&
        filterColumns.length == filterTexts.length &&
        filterIndex >= 0 &&
        filterIndex < filterColumns.length) {
      _filterColumn = filterColumns[filterIndex];
    }
    searchText = _searchTextEditingController.text;

    Print.Reference("search text: " + _searchTextEditingController.text);

    data.clear();
    setState(() {
      FocusScope.of(context).requestFocus(FocusNode());
      _listContent = _initialContent();
    });

    minDate = "";
    if (isPaginationBasedOnPageNumber) {
      _pageNumber = 1;
      _pageNumberLastSaved = _pageNumber;
    }
    listener.onListProcessing(
        searchText: searchText,
        filterColumn: ValidationUtils.isEmpty(_filterColumn) || ValidationUtils.isEmpty(searchText) ? "" : _filterColumn,
        limit: pageSize,
        paging: paging,
        minDate: minDate,
        maxDate: maxDate,
        pageNumber: _pageNumber);
  }

  /*show search filter*/
  Widget _showSearchFilter(Function setState2) {
    return Container(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        //shrinkWrap: true,
        itemCount: filterTexts.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(4),
            child: InkWell(
              onTap: () {
                filterIndex = index;
                Print.Reference('current index: $filterIndex , ${filterTexts[filterIndex]}');

                setState2(() {
                  _deleteTextIconVisible = false;
                  _filterColumn = filterColumns[filterIndex];
                  _searchTextEditingController.text = "";
                  _searchHint = "Search by ${filterTexts[filterIndex]}";
                  _onSearch();
                });
              },
              child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: index == filterIndex ? ColorConstant.blue_2 : ColorConstant.grey_1,
                      borderRadius: BorderRadius.all(Radius.circular(borderRadiusSearchFilterItem))),
                  child: Text(
                    filterTexts[index],
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          );
        },
      ),
    );
  }

  void _showSearchFilterDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState2) {
              return AlertDialog(
                title: Text('Filter By'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: Text('CANCEL'),
                  ),
                  TextButton(
                    onPressed: () {
                      _filterColumn = filterColumns[filterIndex];
                      setState2(() {
                        _deleteTextIconVisible = false;
                        _searchTextEditingController.text = "";
                        _searchHint = "Search by ${filterTexts[filterIndex]}";
                      });
                      Navigator.pop(context, filterColumns[filterIndex]);
                    },
                    child: Text('OK'),
                  ),
                ],
                content: Container(
                  width: double.minPositive,
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filterTexts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                        value: index,
                        groupValue: filterIndex,
                        title: Text(filterTexts[index]),
                        onChanged: (int? val) {
                          if (val != null) {
                            setState2(() {
                              filterIndex = val;
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        });
  }
}
