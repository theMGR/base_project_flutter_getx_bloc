import 'package:flutter/material.dart';

class ImageWithText {
  static Widget imageWIthText_1(
      {required String title,
      IconData? faIcon,
      Color faIconColor = Colors.black,
      String imageAsset = "",
      required Function() function,
      double fontSize = 14,
      FontWeight fontWeight = FontWeight.normal,
      Color fontColor = Colors.black,
      double iconSize = 60}) {
    return InkWell(
      onTap: function,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageAsset.trim().length > 0
              ? Container(
                  height: iconSize,
                  width: iconSize,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : faIcon != null
                  ? Icon(
                      faIcon,
                      size: iconSize,
                      color: faIconColor,
                    )
                  : Icon(
                      Icons.circle,
                      size: iconSize,
                      color: faIconColor,
                    ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(1),
            child: Text(
              title,
              style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: fontColor),
            ),
          )
        ],
      ),
    );
  }
}
