class Item {
  final String Name;
  final int Number;
  final String InventoryType;
  final String Description;
  final String WareHouse;
  final String ShortName;
  Item({
    required this.Description,
    required this.Name,
    required this.InventoryType,
    required this.Number,
    required this.WareHouse,
    required this.ShortName,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      Name: json['name'] ?? '',
      Description: json['description'] ?? '',
      Number: json['number'] ?? 0,
      InventoryType: json['inventoryType'] ?? '',
      WareHouse: json['warehouse'] ?? '',
      ShortName: json['short_name'] ?? '',
    );
  }
}