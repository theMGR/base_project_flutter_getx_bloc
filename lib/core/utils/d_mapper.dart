import 'package:flutter/cupertino.dart';

class DMapper<T> {
  var key;
  int id;
  String idString;
  String text;
  int position;
  bool selected;
  String savedDate;
  T object;
  List<int> refIds;
  List<String> refValues;

  DMapper(
      {this.key,
      required this.id,
      this.idString= "",
      required this.text,
      this.position = -1,
      this.selected = false,
      this.savedDate = "",
      required this.object,
      this.refIds = const [],
      this.refValues = const []});
}