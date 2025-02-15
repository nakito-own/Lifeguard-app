import 'package:flutter/material.dart';
import 'package:lifeguard/models/Item_model.dart';
import '../../api-services/inventory_service.dart';

class InventoryDescription extends StatefulWidget {
  InventoryDescription({Key? key,
    required this.ItemName,
    required this.Description,
    required this.WareHouse,
    required this.item,
  }) : super(key: key);

  final String ItemName;
  final String Description;
  final String WareHouse;
  final Item item;


  @override
  _InventoryDescriptionState createState() => _InventoryDescriptionState();
}

class _InventoryDescriptionState extends State<InventoryDescription> {
  bool isObscured = true;
  late Future<List<Item>> futureItem;
  final InventoryService inventoryService = InventoryService() ;
  List<Item> ItemName = [];

  @override
  void initState() {
    futureItem = inventoryService.fetchItem();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final text_Color = isDarkTheme ? Colors.black : Colors.white;
    final description_Color = isDarkTheme ? Colors.white : Colors.black;
    final container_Color = isDarkTheme ? Colors.orange[500] : Color(0xffc6c7c7);

        return AlertDialog(

          titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          insetPadding: EdgeInsets.fromLTRB(60, 90, 60, 90),
          contentPadding: EdgeInsets.fromLTRB(35, 0, 35, 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
              top: Radius.circular(20), bottom: Radius.circular(20))),
          title:
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10,20,10,0),
            decoration: BoxDecoration(
              color: container_Color,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30), bottom: Radius.circular(100)),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${widget.ItemName}',
                    style: TextStyle(fontSize: 20,  color: text_Color, fontWeight: FontWeight.w600 ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                  ),
                ]
            ),
          ),
          content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image.network(
                      'https://m.media-amazon.com/images/I/61ZzyBQhnQS._AC_UL1500_.jpg',
                      height: 100),
                ),

                SizedBox(height: 30,),
                Text('Описание: ${widget.Description}', style: TextStyle(color: description_Color),),
                SizedBox(height: 20,),
                Text('Описание: ${widget.WareHouse}', style: TextStyle(color: description_Color),),
                SizedBox(height: 70,),
                BackButton(),
              ]
          ),


        );

  }
}