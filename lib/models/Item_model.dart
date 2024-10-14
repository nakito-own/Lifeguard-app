//import 'dart:ffi';

class Item {
  final String Name;
  final String number;
  final String InventoryType;
  final String Description;
  final String WareHouse;
  Item({
    required this.Description,
    required this.Name,
    required this.InventoryType,
    required this.number,
    required this.WareHouse,
  });


  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      Name: json['name'] ?? '',
      Description: json['description'] ?? '',
      number: json['number'] ?? '',
      InventoryType: json['inventoryType'] ?? '',
      WareHouse: json['warehouse'] ?? '',
    );
  }
}
