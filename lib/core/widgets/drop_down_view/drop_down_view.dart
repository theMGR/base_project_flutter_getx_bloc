/*
import 'package:flutter/material.dart';
import 'package:project/core/utils/d_mapper.dart';
import 'package:project/core/utils/validation_utils.dart';

enum DropViewSelectionType { SELECTION_BASED_ON_INDEX, SELECTION_BASED_ON_ID }

enum DropViewSelectionIdType { SELECTION_BASED_ON_ID_INT, SELECTION_BASED_ON_ID_STRING }

class DropDownView<Item> extends StatefulWidget {
  final List<DMapper<Item?>?> items;
  final String hint;
  final int selectedIndex;
  final Function(DMapper<Item?>?) onItemSelected;
  final String title;
  final DropViewSelectionType dropViewSelectionType;
  final DropViewSelectionIdType dropViewSelectionIdType;
  final int selectedId;
  final String selectedIdString;
  final bool isCaseSensitive;

  const DropDownView(
      {Key? key,
      required this.items,
      this.hint = "Choose an item ?",
      this.selectedIndex = -1,
      required this.onItemSelected,
      this.title = "",
      this.dropViewSelectionType = DropViewSelectionType.SELECTION_BASED_ON_INDEX,
      this.dropViewSelectionIdType = DropViewSelectionIdType.SELECTION_BASED_ON_ID_INT,
      this.selectedId = -1,
      this.selectedIdString = "",
      this.isCaseSensitive = false})
      : super(key: key);

  @override
  _DropDownViewState createState() => _DropDownViewState<Item>(
      selectedIndex: selectedIndex,
      items: items,
      hint: hint,
      onItemSelected: onItemSelected,
      title: title,
      dropViewSelectionType: dropViewSelectionType,
      dropViewSelectionIdType: dropViewSelectionIdType,
      selectedId: selectedId,
      selectedIdString: selectedIdString,
      isCaseSensitive: isCaseSensitive);
}

class _DropDownViewState<Item> extends State<DropDownView> {
  final List<DMapper<Item?>?> items;
  final String hint;
  int selectedIndex;
  final Function(DMapper<Item?>?) onItemSelected;
  final String title;
  final DropViewSelectionType dropViewSelectionType;
  final DropViewSelectionIdType dropViewSelectionIdType;
  int selectedId;
  String selectedIdString;
  final bool isCaseSensitive;

  List<DropdownMenuItem<DMapper<Item?>?>> _dropdownMenuItems = [];

  DMapper<Item?>? _selectedDMapper;

  _DropDownViewState(
      {required this.selectedIndex,
      required this.items,
      required this.hint,
      required this.onItemSelected,
      required this.title,
      required this.dropViewSelectionType,
      required this.dropViewSelectionIdType,
      required this.selectedId,
      required this.selectedIdString,
      required this.isCaseSensitive}) {
    _dropdownMenuItems = buildDropdownMenuItems(items);

    if (dropViewSelectionType == DropViewSelectionType.SELECTION_BASED_ON_INDEX) {
      selectedId = -1;
      selectedIdString = "";
      if (selectedIndex >= 0 && selectedIndex < items.length) {
        _selectedDMapper = items[selectedIndex];
      }
    } else if (dropViewSelectionType == DropViewSelectionType.SELECTION_BASED_ON_ID) {
      selectedIndex = -1;
      if (dropViewSelectionIdType == DropViewSelectionIdType.SELECTION_BASED_ON_ID_INT) {
        selectedIdString = "";
        for (var dMapper in items) {
          if(dMapper != null) {
            if (dMapper.id >= 0 && selectedId >= 0 && selectedId == dMapper.id) {
              _selectedDMapper = dMapper;
            }
          }
        }
      } else if (dropViewSelectionIdType == DropViewSelectionIdType.SELECTION_BASED_ON_ID_STRING) {
        selectedId = -1;
        for (var dMapper in items) {
          if (dMapper != null) {
            if (isCaseSensitive) {
              if (dMapper.idString.trim().length > 0 && selectedIdString.compareTo(dMapper.idString) == 0) {
                _selectedDMapper = dMapper;
              }
            } else {
              if (dMapper.idString.trim().length > 0 && selectedIdString.toLowerCase().compareTo(dMapper.idString.toLowerCase()) == 0) {
                _selectedDMapper = dMapper;
              }
            }
          }
        }
      }
    }
  }

  List<DropdownMenuItem<DMapper<Item?>?>> buildDropdownMenuItems(List<DMapper<Item?>?> list) {
    List<DropdownMenuItem<DMapper<Item?>?>> items = [];
    for (int i = 0; i < list.length; i++) {
      DMapper<Item?>? dMapper = list[i];
      if (dMapper != null) {
        items.add(
          DropdownMenuItem(
            value: dMapper,
            child: Text(dMapper.text),
          ),
        );
      }
    }
    return items;
  }

  void _onChangeDropdownItem(DMapper<Item?>? selectedDMapper) {
    setState(() {
      _selectedDMapper = selectedDMapper;
      onItemSelected(selectedDMapper);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValidationUtils.isEmpty(title)
            ? Container()
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: TextStyle(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
              ]),
        Container(
          width: double.infinity,
          //margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: Colors.grey)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<DMapper<Item?>?>(
                value: _selectedDMapper,
                //elevation: 5,
                style: TextStyle(color: Colors.black),
                hint: Text(hint, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey)),
                items: _dropdownMenuItems,
                onChanged: (DMapper<Item?>? selectedDMapper) {
                  _onChangeDropdownItem(selectedDMapper);
                }),
          ),
        )
      ],
    );
  }
}
*/
