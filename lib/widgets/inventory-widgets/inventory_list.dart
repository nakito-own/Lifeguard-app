import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/small_text.dart';

class InventoryList extends StatefulWidget {
  InventoryList({Key? key,
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
  }) : super(key: key);
  final List<String> ItemName;
  final List<String> Description;
  final String GroupName;
  final double MainWidth;
  final List<String> WareHouse;
  final List<String> items;
  final List<String> ShortName;
  final List<String> MainQuantity;
  final List<String> ItemQuantity;
  final bool isEditing;
  final Function(int) onDelete;
  final VoidCallback onLookDescription;


  @override
  _InventoryListState createState() => _InventoryListState();
  }

  class _InventoryListState extends State<InventoryList> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  final TextEditingController controller = TextEditingController();



  void _toggleList() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDarkTheme ? Color(0xff2d2a2a) : Color(0xffd3d6d6);
    final border_Color = isDarkTheme ? Color(0xff383434) : Color(0xffc8cccc);
    final text_Color = isDarkTheme ? Colors.white : Colors.black;
    final container_Color = isDarkTheme ? Color(0xff3a3636) : Color(0xffc6c7c7);

    return Column(
      children:  [
        AnimatedContainer(
          duration: Duration(milliseconds: 450),
          height: _isExpanded ? 20 : 0,
          margin: EdgeInsets.fromLTRB( MediaQuery.of(context).size.width * 0.04, 0, MediaQuery.of(context).size.width * 0.04, 10),
          child: Row (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SmallText(some_text: _isExpanded ? '${widget.GroupName}' : '', Width: 190),
              SmallText(some_text: _isExpanded ? 'Кол-во' : '', Width: 70),
            ],
          ),
        ),

        AnimatedContainer(
        duration: Duration(milliseconds: 400),
        width: widget.MainWidth,
        height: _isExpanded ? MediaQuery.of(context).size.height * 0.55 : MediaQuery.of(context).size.height * 0.0652,
        margin: EdgeInsets.fromLTRB(4,0,4,20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
          border: Border.all(
              color: border_Color,
              width: 2
          ),
        ),
          child: Column (
            children: [
             Expanded (
            child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            AnimatedContainer(
              padding: EdgeInsets.fromLTRB(10, 7, 0, 7),
            duration: Duration(milliseconds: 500),
              height: _isExpanded ? widget.WareHouse.length * 180 : 0.0,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(0,0,10,0),
              itemCount: widget.WareHouse.length,
              itemBuilder: (context, index) => ExpansionTile(
                   trailing:widget.isEditing
                       ? Row(
                     mainAxisSize: MainAxisSize.min,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                        IconButton(
                           color: Colors.green,
                           alignment: Alignment.bottomLeft,
                           icon: Icon(Icons.edit),
                           onPressed: () {},
                         ),
                         IconButton(
                           color: Colors.red,
                           alignment: Alignment.centerLeft,
                           icon: Icon(Icons.delete_forever),
                           onPressed: () => widget.onDelete(index),
                         ),
                     ],
                   )
                       : Text (' ${widget.MainQuantity[index]}', style: TextStyle(fontSize: 16, ),),
                   title:
                 Text( widget.ShortName[index] ,),
                 children: [
                   ExpansionTile(
                     trailing:
                        Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(onPressed: () => widget.onLookDescription(), icon: Icon(Icons.sd_card)),
                          Text(' ${widget.ItemQuantity[index]}', style: TextStyle(fontSize: 16, ),) ,
                          ]
                        ),
                     title:
                     Text(
                       '${widget.ItemName[index]}',
                       textAlign: TextAlign.center,
                         style: TextStyle(color: text_Color, fontSize: 16,),
                     ),
                     children:[

                    ],
                   ),
                  ],
                  ),
                ),
              ),

              ]
            ),
       ),
      ),

          /// Это код для закруглённой только снизу полоски
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: MediaQuery.of(context).size.height * 0.06,
            width: widget.MainWidth,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
              color: container_Color,
              borderRadius: _isExpanded ? BorderRadius.vertical(top: Radius.zero, bottom: Radius.circular(5))
                  : BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( _isExpanded ? '' : '${widget.GroupName}' ),
              IconButton(
              iconSize: MediaQuery.of(context).size.height * 0.0396,
              alignment: Alignment.topCenter,
              icon: _isExpanded ? Icon(Icons.keyboard_arrow_up) : Icon(Icons.keyboard_arrow_down),
              onPressed: () { _toggleList(); }
             ),

              ]
        ),
        ),
        ],
        ),
      ),
    ]
    );
  }
}

