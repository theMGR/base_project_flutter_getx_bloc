import 'package:flutter/material.dart';
import 'package:project/core/utils/print_utils.dart';

class Item {
  String imageUrl;
  int rank;
  Item(this.imageUrl, this.rank);
}

class DocumentViewer extends StatefulWidget {
  @override
  _DocumentViewerState createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {

  List<Item> itemList = [];
  List<Item> selectedList = [];
  @override
  void initState() {

    loadList();
    super.initState();
  }
  void loadList() {
    itemList = [];
    selectedList = [];

    List.generate(20,(index){
      itemList.add(Item("assets/woc/images/driver.png", index+1));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _content());
  }

  Widget _content() {
    return GridView.builder(
        itemCount: itemList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.56,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2),
        itemBuilder: (context, index) {
          return GridItem(
              item: itemList[index],
              isSelected: (bool value) {
                setState(() {
                  if (value) {
                    selectedList.add(itemList[index]);
                  } else {
                    selectedList.remove(itemList[index]);
                  }
                });
                Print.Reference("$index : $value");
              },
              key: Key(itemList[index].rank.toString()));
        });
  }
}










class GridItem<Item> extends StatefulWidget {
  final Key key;
  final Item item;
  final ValueChanged<bool> isSelected;

  GridItem({required this.item,required  this.isSelected,required  this.key});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        });
      },
      child: Stack(
        children: <Widget>[
          Image.asset(
            widget.item.imageUrl,
            color: Colors.black.withOpacity(isSelected ? 0.9 : 0),
            colorBlendMode: BlendMode.color,
          ),
          isSelected
              ? Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue,
              ),
            ),
          )
              : Container()
        ],
      ),
    );
  }
}
