import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project/core/utils/dates_utils.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/data/remote/model/module_lead/lead_create_edit_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_list_dto.dart';
import 'package:project/ui/config/listing_view.dart';
import 'package:project/ui/config/route_config.dart';
import 'package:project/ui/config/ui_config.dart';

import 'lead_list_controller.dart';

class LeadListPage extends StatefulWidget {
  @override
  _LeadListPageState createState() => _LeadListPageState();
}

class _LeadListPageState extends State<LeadListPage> {
  final controller = Get.find<LeadListController>();
  final GlobalKey<ListingViewState> listViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteConfig.leadCreateUpdate);
        },
        child: const Icon(Icons.add, size: 38, color: Colors.white),
        backgroundColor: UIConfig.buttonColor,
      ),
      body: Obx(() {
        if (controller.listLeadDTO.isNotEmpty) {
          Print("listLeadDTO : ${controller.listLeadDTO.length}");
          listViewKey.currentState?.setItems(items: controller.listLeadDTO);
        }
        return _content(context);
      }),
    );
  }

  Widget _content(BuildContext context) {
    /*return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: listView()),
        //UIConfig.button(context: context, title: "Create Lead", onTap: () {})
      ],
    );*/

    return listView();
  }

  Widget listView() {
    return ListingView<LeadListDTO>(
      key: listViewKey,
      enablePullUp: false,
      itemMargin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      listingWithSearchItemType: ListingWithSearchItemType.TYPE_CARD,
      onListProcessing: ({filterColumn, maxDate, minDate, pageNumber, pageSize, paging, searchText}) {
        controller.getLeads();
      },
      onCreateListItem: (context, item, index, items) {
        return StatefulBuilder(builder: (context, setState2) {
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            width: double.infinity,
            child: InkWell(
                onTap: () {
                  /*
            setState2(() {
              for (int i = 0; i < items.length; i++) {
                AllDriverListingData dto = items[i];
                if (index != i) {
                  dto.isSelected = false;
                }
              }

              item.isSelected = !item.isSelected;

              _myKey.currentState.onRefreshListView();
            });
            print("item.isSelected : ${item.isSelected}");
            */
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Icon(
                        FontAwesomeIcons.solidUser,
                        size: 20,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          "${item.customerName}",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ]),
                    SizedBox(height: 10),
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Icon(
                        FontAwesomeIcons.mobileAlt,
                        size: 20,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          "${item.contactNo}",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ]),
                    SizedBox(height: 10),
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Icon(
                        FontAwesomeIcons.users,
                        size: 20,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          "${item.contactedVia}",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ]),
                    SizedBox(height: 10),
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Icon(
                        FontAwesomeIcons.solidAddressCard,
                        size: 20,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          "${item.contactedDetails}",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ]),
                    SizedBox(height: 10),
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Icon(
                        FontAwesomeIcons.mapMarkedAlt,
                        size: 20,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          "${item.place}",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ]),
                    SizedBox(height: 10),
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Icon(
                        FontAwesomeIcons.calendarCheck,
                        size: 20,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          "${DatesUtils.convertToHumanDate(item.date)}",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ]),
                    Container(
                      height: 1,
                      color: Colors.blueGrey,
                      margin: EdgeInsets.only(top: 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.getCreatedLeadById(item.leadNo, (LeadDTO? leadDTO) async {
                                var isRefresh = await Get.toNamed(RouteConfig.leadApproveCancel, arguments: [leadDTO]);

                                if (isRefresh != null && isRefresh as bool) {
                                  listViewKey.currentState?.onRefresh();
                                }
                              });
                            },
                            icon: Icon(FontAwesomeIcons.binoculars, size: 24, color: UIConfig.buttonColor)),
                        IconButton(
                            onPressed: () {
                              controller.getCreatedLeadById(item.leadNo, (LeadDTO? leadDTO) async {
                                if (leadDTO != null) {
                                  //Get.toNamed(RouteConfig.leadCreateUpdate, arguments: {LeadCreateUpdatePage.leadEditLeadDTOKey: leadDTO});
                                  LeadCreateEditDTO? leadCreateEditDTO = LeadCreateEditDTO(
                                      id: leadDTO.leadNo,
                                      customerName: leadDTO.customerName,
                                      contactedVia: leadDTO.contactedVia,
                                      contactedDetails: leadDTO.contactedDetails,
                                      contactNo: leadDTO.contactNo,
                                      price: leadDTO.price,
                                      place: leadDTO.place,
                                      quantity: leadDTO.quantity,
                                      description: leadDTO.description,
                                      productId: leadDTO.productId,
                                      productName: leadDTO.name);
                                  var isRefresh = await Get.toNamed(RouteConfig.leadCreateUpdate, arguments: [leadCreateEditDTO]);

                                  if (isRefresh != null && isRefresh as bool) {
                                    listViewKey.currentState?.onRefresh();
                                  }
                                }
                              });
                            },
                            icon: Icon(FontAwesomeIcons.solidEdit, size: 24, color: UIConfig.buttonColor)),
                      ],
                    )
                  ],
                )),
          );
        });
      },
      getSavedDate: (item) {},
    );
  }

  @override
  void dispose() {
    Get.delete<LeadListController>();
    super.dispose();
  }
}
