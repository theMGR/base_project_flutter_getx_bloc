import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project/app_initializer.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/data/local/repository/login_details_local_repository.dart';
import 'package:project/data/remote/model/login_details_dto.dart';
import 'package:project/ui/config/route_config.dart';
import 'package:project/ui/config/ui_config.dart';

import '../home_controller.dart';

class HomeDrawer {

  static Drawer drawer(LoginDetailsDTO? loginDetailsDTO) {
    Print("Drawer logindetails mobile ${loginDetailsDTO?.mobileNo} ${loginDetailsDTO?.userName}");
    return Drawer(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        loginDetailsDTO != null && loginDetailsDTO.userName != null && loginDetailsDTO.mobileNo != null
            ? _createDrawerHeader(loginDetailsDTO.userName, loginDetailsDTO.mobileNo)
            : Container(),
        Expanded(
            child: SingleChildScrollView(
                child: Column(
          children: [
            ListTile(
              leading: Icon(FontAwesomeIcons.shoppingBasket, color: UIConfig.iconColor),
              title:  Text("Enquiry", style: TextStyle(fontSize: 20)),
              onTap: () {
                Get.offAllNamed(RouteConfig.home);
              },
            )
          ],
        ))),
        ListTile(
          leading: Icon(FontAwesomeIcons.signOutAlt, color: UIConfig.iconColor),
          title:  Text("Logout", style: TextStyle(fontSize: 20)),
          onTap: () {
            AppInitializer.clearData();
            Get.offAllNamed(RouteConfig.login);
          },
        )
      ],
    ));
  }

  static Widget _createDrawerHeader(String? userName, String? mobileNumber) {
    return Stack(
      children: [
        Container(
          height: 220,
          child: DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              //decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/woc/images/slidermenu_companybg.png'))),
              decoration: BoxDecoration(color: UIConfig.accentColor),
              child: Stack(children: <Widget>[
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                            width: 100,
                            height: 100,
                            child: Icon(
                              FontAwesomeIcons.solidUserCircle,
                              size: 50,
                              color: Colors.grey,
                            ),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20)))),
/*                        Positioned.fill(
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "4.5",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        ),*/
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(userName!, style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                    Text(mobileNumber!, style: TextStyle(color: Colors.white70, fontSize: 24, fontWeight: FontWeight.w500)),
                  ],
                )),
              ])),
        ),
        Positioned.fill(
          child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  _closeDrawer();
                },
              )),
        ),
      ],
    );
  }

  static void _closeDrawer() {
    Navigator.of(Get.context!).pop();
  }
}
