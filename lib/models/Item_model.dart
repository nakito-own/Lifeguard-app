class Item {
  final String Name;
  final int Number;
  final String InventoryType;
  final String Description;
  final String WareHouse;
  final String ShortName;
  final int id;
  Item({
    required this.Description,
    required this.Name,
    required this.InventoryType,
    required this.Number,
    required this.WareHouse,
    required this.ShortName,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      Name: json['name'] ?? '',
      Description: json['description'] ?? '',
      Number: json['number'] ?? 0,
      InventoryType: json['inventoryType'] ?? '',
      WareHouse: json['warehouse'] ?? '',
      ShortName: json['short_name'] ?? '',
      id: json['id'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': Name,
      'description': Description,
      'number': Number,
      'inventoryType': InventoryType,
      'warehouse': WareHouse,
      'short_name': ShortName,
      'id': id,
    };
  }

  Item copyWith({
    String? name,
    String? description,
    int? number,
    String? inventoryType,
    String? wareHouse,
    String? shortName,
    int? itemId,
  }) {
    return Item(
      Name: name ?? this.Name,
      Description: description ?? this.Description,
      Number: number ?? this.Number,
      InventoryType: inventoryType ?? this.InventoryType,
      WareHouse: wareHouse ?? this.WareHouse,
      ShortName: shortName ?? this.ShortName,
      id: itemId ?? this.id,
    );
  }
}