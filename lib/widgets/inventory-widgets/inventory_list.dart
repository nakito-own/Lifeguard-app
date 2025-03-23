import 'package:flutter/material.dart';
import '../../models/Item_model.dart';

class InventoryList extends StatefulWidget {
  InventoryList({
    Key? key,
    required this.ShortName,
    required this.ItemName,
    required this.Description,
    required this.GroupName,
    required this.MainWidth,
    required this.items,
    required this.WareHouse,
    required this.isEditing,
    required this.onDelete,
    required this.MainQuantity,
    required this.ItemQuantity,
    required this.onLookDescription,
    required this.ItemList,
  }) : super(key: key);

  final List<String> ItemName;
  final List<String> Description;
  final List<Item> ItemList;
  final String GroupName;
  final double MainWidth;
  final List<String> WareHouse;
  final List<String> items;
  final List<String> ShortName;
  final List<String> MainQuantity;
  final List<String> ItemQuantity;
  final bool isEditing;
  final Function(int) onDelete;
  final Function(Item) onLookDescription;

  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;

  Map<String, List<Map<String, dynamic>>> _groupItems() {
    final Map<String, List<Map<String, dynamic>>> groupedItems = {};

    for (int i = 0; i < widget.ShortName.length; i++) {
      final shortName = widget.ShortName[i];
      if (!groupedItems.containsKey(shortName)) {
        groupedItems[shortName] = [];
      }
      groupedItems[shortName]!.add({
        'itemName': widget.ItemName[i],
        'description': widget.Description[i],
        'mainQuantity': widget.MainQuantity[i],
        'itemQuantity': widget.ItemQuantity[i],
        'item': widget.ItemList[i],
      });
    }

    return groupedItems;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  void _toggleList() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkTheme ? Color(0xff2d2a2a) : Color(0xffd3d6d6);
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final backNumberColor = isDarkTheme ? Colors.white10 : Color.fromRGBO(176, 172, 172, 1);
    final tileColor = isDarkTheme ? Color.fromRGBO(83, 83, 83, 1) : Color(0xffc6c7c7);

    final groupedItems = _groupItems();

    return Card(
      color: cardColor,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.GroupName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: backNumberColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '${widget.WareHouse.length}',
                style: TextStyle(color: textColor, fontSize: 14),
              ),
            ),
            onTap: _toggleList,
          ),
          SizeTransition(
            sizeFactor: _animationController,
            axisAlignment: 0.0,
            child: _isExpanded
                ? Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.45,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: groupedItems.keys.length,
                itemBuilder: (context, index) {
                  final shortName = groupedItems.keys.elementAt(index);
                  final items = groupedItems[shortName]!;
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    shadowColor: Colors.transparent,
                    color: isDarkTheme ? Colors.grey[800] : Colors.grey[300],
                    child: ExpansionTile(
                      dense: true,
                      collapsedIconColor: Colors.transparent,
                      iconColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      title:
                      Text(
                        '${shortName}',
                        style: TextStyle(color: textColor, fontSize: 16),
                      ),
                      children: items.map((item) {
                        return ListTile(
                          tileColor: tileColor,
                          title: Text(
                            item['itemName']!,
                            style: TextStyle(color: textColor),
                          ),
                          trailing: widget.isEditing
                              ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                color: Colors.green,
                                icon: Icon(Icons.edit),
                                onPressed: () {},
                              ),
                              IconButton(
                                color: Colors.red,
                                icon: Icon(Icons.delete_forever),
                                onPressed: () => widget.onDelete(items.indexOf(item)),
                              ),
                            ],
                          )
                              : IconButton(
                            icon: Icon(Icons.description_outlined),
                            color: textColor,
                            onPressed: () {
                              widget.onLookDescription(item['item']);
                            },
                          ),
                        );

                      }).toList(),

                    ),
                  );
                },
              ),
            )
                : SizedBox(),
          ),
         IconButton(
              icon: Icon(
                _isExpanded ? Icons.keyboard_arrow_up: Icons.keyboard_arrow_down,
                color: textColor,
              ),
              iconSize: 30,
              onPressed: _toggleList,
            ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
