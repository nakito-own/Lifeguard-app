import 'package:flutter/material.dart';
import 'package:lifeguard/models/Item_model.dart';

class InventoryDescription extends StatelessWidget {
  final String ItemName;
  final String Description;
  final String WareHouse;
  final String Number;
  final Item item;

  InventoryDescription({
    Key? key,
    required this.Number,
    required this.ItemName,
    required this.Description,
    required this.WareHouse,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final text_Color = isDarkTheme ? Colors.black : Colors.white;
    final description_Color = isDarkTheme ? Colors.grey : Colors.black;
    final descriptionWord_Color = isDarkTheme ? Colors.white : Colors.black;
    final container_Color = isDarkTheme ? Colors.orange[500] : Color(0xffc6c7c7);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
              decoration: BoxDecoration(
                color: container_Color,
                borderRadius: BorderRadius.vertical(top: Radius.circular(31), bottom: Radius.circular(100)),
              ),
              height: MediaQuery.of(context).size.height * 0.105,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 2.5,
                    width: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  SizedBox( height: 10,),
                  Text(
                    '${ItemName}',
                    style: TextStyle(fontSize: 20, color: text_Color, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                'https://m.media-amazon.com/images/I/61ZzyBQhnQS._AC_UL1500_.jpg',
                height: 100,
              ),
            ),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Описание: ', style: TextStyle(color: descriptionWord_Color),),
                    TextSpan(text: '${Description}', style: TextStyle(color: description_Color),),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 20),
                Text('Склад: ', style: TextStyle(color: descriptionWord_Color),),
                Text('${WareHouse}', style: TextStyle(color: description_Color),),
              ],
            ),
            SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text('Количество: ', style: TextStyle(color: descriptionWord_Color)),
                    Text('${Number}', style: TextStyle(color: description_Color)),
                  ]
                ),
                SizedBox(height: 15),
                Row(
                    children: [
                      SizedBox(width: 20),
                      Text('Номера: ', style: TextStyle(color: descriptionWord_Color)),
                      Text('№1 - №200', style: TextStyle(color: description_Color)),
                    ]
                )
              ]
            ),
          ],
        ),
      ),
    );
  }
}
