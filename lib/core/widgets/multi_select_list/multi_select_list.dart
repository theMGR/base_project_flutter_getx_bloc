import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/core/utils/d_mapper.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/core/utils/validation_utils.dart';

enum ListingWithSearchItemType { TYPE_CARD, TYPE_CONTAINER }

abstract class MultiSelectListListener {
  Widget? onCreateListItem(BuildContext context, DMapper mapper);

  void getSelectedItems(List<DMapper> selectedItems);
}

class MultiSelectList<Item> extends StatefulWidget {
  final MultiSelectListListener listener;
  final bool isSearchEnabled;
  final String searchText;
  final ListingWithSearchItemType listingWithSearchItemType;
  final Color listItemBackgroundColor;
  final int gridCount;
  double gridChildAspectRatio = 0;

  final List<int> selectedIds;
  final List<String> selectedIdsAsString;
  final List<DMapper<Item>> originalData;
  final bool isMultiSelectable;
  final bool isCheckBoxEnabled;

  MultiSelectList({
    Key? key,
    required this.listener,
    this.isSearchEnabled = false,
    this.searchText = "",
    this.listingWithSearchItemType = ListingWithSearchItemType.TYPE_CARD,
    this.listItemBackgroundColor = Colors.white,
    this.gridCount = 1,
    double gridChildAspectRatio = 0,
    this.selectedIds = const [],
    this.selectedIdsAsString = const [],
    this.originalData = const [],
    this.isMultiSelectable = true,
    this.isCheckBoxEnabled = true,
  }) : super(key: key) {
    if (gridChildAspectRatio <= 0) {
      if (gridCount == 1) {
        this.gridChildAspectRatio = 6;
      } else {
        this.gridChildAspectRatio = .56;
      }
    }
  }

  @override
  MultiSelectListState createState() => MultiSelectListState<Item>(
    listener: listener,
    isSearchEnabled: isSearchEnabled,
    searchText: searchText,
    listingWithSearchItemType: listingWithSearchItemType,
    listItemBackgroundColor: listItemBackgroundColor,
    gridCount: gridCount,
    gridChildAspectRatio: gridChildAspectRatio,
    selectedIds: selectedIds,
    selectedIdsAsString: selectedIdsAsString,
    originalData: originalData,
    isMultiSelectable: isMultiSelectable,
    isCheckBoxEnabled: isCheckBoxEnabled,
      );
}

class MultiSelectListState<Item> extends State<MultiSelectList> {
  final MultiSelectListListener listener;
  bool isSearchEnabled;
  final String searchText;
  final ListingWithSearchItemType listingWithSearchItemType;
  final Color listItemBackgroundColor;
  final int gridCount;
  final double gridChildAspectRatio;
  final List<int> selectedIds;
  final List<String> selectedIdsAsString;
  List<DMapper<Item>> originalData;
  final bool isMultiSelectable;
  final bool isCheckBoxEnabled;
  List<DMapper<Item>> _filteredData = [];

  Timer? _debounce;

  //

  TextEditingController _searchTextEditingController = TextEditingController();

  //
  GlobalKey _contentKey = GlobalKey();

  //



  //
  Widget _mainContent = Container();

  //
  String _searchHint = "Enter Search keyword..";
  bool _deleteTextIconVisible = false;

  MultiSelectListState(
      {required this.listener,
      required this.isSearchEnabled,
      required this.searchText,
      required this.listingWithSearchItemType,
      required this.listItemBackgroundColor,
      required this.gridCount,
      required this.gridChildAspectRatio,
  required this.selectedIds,
  required this.selectedIdsAsString,
  required this.originalData,
  required this.isMultiSelectable,
  required this.isCheckBoxEnabled,
      }) {
    _filteredData = [];
    _filteredData.addAll(originalData);


    if (originalData.isNotEmpty && selectedIds.isNotEmpty) {
      for (DMapper dMapper in originalData) {
        int id = dMapper.id >= 0 ? dMapper.id : -1;

        for (int selectedId in selectedIds) {
          if (id == selectedId) {
            dMapper.selected = true;
          }
        }
      }
    }

    if (originalData.isNotEmpty && selectedIdsAsString.isNotEmpty) {
      for (DMapper dMapper in originalData) {
        String id = dMapper.id >= 0 ? dMapper.id.toString() : "";

        for (String selectedId in selectedIdsAsString) {
          if (id.trim().length > 0 && id.compareTo(selectedId) == 0) {
            dMapper.selected = true;
          }
        }
      }
    }
  }

  @override
  void initState() {
    _mainContent = _buildListContent(data: _filteredData);

    if (searchText.isNotEmpty) {
      _searchTextEditingController.text = searchText;
      _deleteTextIconVisible = true;
      isSearchEnabled = true;
      _onSearch(_searchTextEditingController.text);
    }

    super.initState();
  }

  void setItems({List<DMapper<Item>> items = const []}) {
    Print.Reference("DATA LENGTH ${items.length}");
    if ( items.length > 0) {
      originalData = [];
      originalData.addAll(items);

      _filteredData = [];
      _filteredData.addAll(originalData);
    } else {
      isSearchEnabled = false;
    }

    setState(() {
      _mainContent = _buildListContent(data: _filteredData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: _mainContent,
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _searchTextEditingController.dispose();
    _debounce?.cancel();
  }

  Widget _buildListContent({List<DMapper<Item>> data = const []}) {
    if (data.length > 0) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          isSearchEnabled ? _searchContainer() : Container(),
          Expanded(
            child: GridView.builder(
                key: _contentKey,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridCount, childAspectRatio: gridChildAspectRatio, crossAxisSpacing: 2, mainAxisSpacing: 2),
                itemBuilder: (context, index) {
                  return _cardOrContainer(
                      child: Container(
                          width: double.infinity,
                          //alignment: Alignment.center,
                          /*child: Column(
                            //mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [_createListItem(context, index, data)],
                          )*/

                          child: _createListItem(context, index, data)));
                },
                itemCount: data.length),
          ),
          isCheckBoxEnabled
              ? InkWell(
                  onTap: () {
                    List<DMapper<Item>> filteredMapper = [];
                    for (DMapper<Item> dMapper in _filteredData) {
                      if (dMapper.selected) {
                        filteredMapper.add(dMapper);
                      }
                    }
                    listener.getSelectedItems(filteredMapper);
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(5),
                    child: Text(
                      'Submit'.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                )
              : Container()
        ],
      );
    } else {
      return Center(child: Text('No records found'));
    }
  }

  Widget _createListItem(BuildContext context, int index, List<DMapper<Item>> list) {
    DMapper<Item> data = list[index];

    if (gridCount == 1) {
      return Container(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            setState(() {
              data.selected = !data.selected;

              Print.Reference("${data.selected}");

              if (!isMultiSelectable) {
                for (int i = 0; i < list.length; i++) {
                  if (i != index) {
                    list[i].selected = false;
                  }
                }
              }

              _mainContent = _buildListContent(data: _filteredData);
            });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                      child: listener.onCreateListItem(context, list[index]) != null
                          ? listener.onCreateListItem(context, list[index])
                          : Text(data.text, maxLines: 2, overflow: TextOverflow.ellipsis),
                    )),
                SizedBox(width: 5),
                isCheckBoxEnabled ? Icon(data.selected ? Icons.check_box : Icons.check_box_outline_blank) : Container()
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        child: InkWell(
          onTap: () {
            setState(() {
              data.selected = !data.selected;

              Print.Reference("${data.selected}");

              if (!isMultiSelectable) {
                for (int i = 0; i < list.length; i++) {
                  if (i != index) {
                    list[i].selected = false;
                  }
                }
              }

              _mainContent = _buildListContent(data: _filteredData);
            });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Stack(
              children: [
                Container(
                  child: listener.onCreateListItem(context, list[index]) != null
                      ? listener.onCreateListItem(context, list[index])
                      : Text(data.text, maxLines: 2, overflow: TextOverflow.ellipsis),
                ),
                Positioned.fill(
                    child: Align(
                        alignment: Alignment.topRight,
                        child: isCheckBoxEnabled ? Icon(data.selected ? Icons.check_box : Icons.check_box_outline_blank) : Container()))
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _cardOrContainer({required Widget child}) {
    if (listingWithSearchItemType == ListingWithSearchItemType.TYPE_CARD) {
      return Card(child: child, color: listItemBackgroundColor);
    } else {
      return Container(child: child, color: listItemBackgroundColor);
    }
  }

  Widget _searchContainer() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: Colors.grey)),
      child: Row(
        children: [
          Icon(FontAwesomeIcons.search),
          Expanded(
              child: Container(
            child: TextField(
              maxLines: 1,
              controller: _searchTextEditingController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                hintText: _searchHint,
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    _deleteTextIconVisible = false;
                  });
                } else {
                  setState(() {
                    _deleteTextIconVisible = true;
                  });
                }

                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  _onSearch(_searchTextEditingController.text);
                });
              },
            ),
          )),
          _deleteTextIconVisible
              ? IconButton(
                  icon: Icon(FontAwesomeIcons.backspace),
                  onPressed: () {
                    _searchTextEditingController.text = "";
                    setState(() {
                      _deleteTextIconVisible = false;
                    });
                    _onSearch(_searchTextEditingController.text);
                  })
              : Container(),
        ],
      ),
    );
  }

  void _onSearch(String search) {
    Print.Reference("search text: " + search);
    if (!ValidationUtils.isEmpty(search)) {
      _filteredData = [];
      for (DMapper<Item> dMapper in originalData) {
        Print.Reference('in search mapper -> text ${dMapper.text} -- selected ${dMapper.selected}');
        if (dMapper.text.toLowerCase().contains(search.toLowerCase())) {
          _filteredData.add(dMapper);
        }
        if (dMapper.selected && !dMapper.text.toLowerCase().contains(search.toLowerCase())) {
          _filteredData.add(dMapper);
        }
      }
    } else {
      _filteredData = [];
      _filteredData.addAll(originalData);
    }

    setState(() {
      _mainContent = _buildListContent(data: _filteredData);
    });
  }
}
