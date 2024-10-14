import 'package:flutter/material.dart';
import 'package:lifeguard/api-services/inventory_service.dart';
import 'package:lifeguard/models/Item_model.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';
import 'package:lifeguard/widgets/inventory-widgets/inventory_description.dart';
import 'package:lifeguard/widgets/inventory-widgets/inventory_editing.dart';
import '../utils/permissions_manager.dart';
import '../widgets/app-widgets/app_drawer.dart';
import '../widgets/inventory-widgets/inventory_list.dart';


class InventoryScreen extends StatefulWidget {

  final VoidCallback toggleTheme;

  InventoryScreen({required this.toggleTheme});

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> with SingleTickerProviderStateMixin {
  bool isEditing = false;
  late Future<List<Item>> futureItem;
  final InventoryService inventoryService = InventoryService() ;

  List<String> MainQuantity = ['122', '20', '30'];
  List<Item> items = [];
  List<Item> Name = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  final PermissionsManager permissionsManager = PermissionsManager();

  String selectedInventory = 'Inventory 1';

  @override
  void initState() {
    super.initState();
    futureItem = inventoryService.fetchItem();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {

    _controller.dispose();
    super.dispose();
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void deleteItem(int index) {
    setState(() {
    });
  }

  void lookDescription (Item item) {
    showDialog(
      context: context,
      builder: (context) {
        return InventoryDescription(
            Description: item.Description,
            ItemName: item.Name,
            WareHouse: item.WareHouse,
            item: item,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Оборудование'),
      ),
      drawer: AppDrawer(toggleTheme: widget.toggleTheme),
      body: FutureBuilder<List<Item>>(
        future: futureItem,
        builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('Инвентарь не загружен'));
          } else {
          final items = snapshot.data!;

          Map<String, List<Item>> groupedItems = {};
          for (var item in items) {
            if (groupedItems.containsKey(item.InventoryType)) {
              groupedItems[item.InventoryType]!.add(item);
            } else {
              groupedItems[item.InventoryType] = [item];
            }
          }

          return SingleChildScrollView (
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [  ...groupedItems.entries.map<Widget>((entry) {
              String inventoryType = entry.key;
              List<Item> groupItems = entry.value;

              return InventoryList(
                isEditing: isEditing,
                onDelete: deleteItem,
                onLookDescription: () {
                  lookDescription(groupItems.first); // Передаем первый элемент группы
                },
                GroupName: inventoryType,
                ItemName: groupItems.map((item) => item.Name).toList(),
                MainWidth: MediaQuery.of(context).size.width * 0.9,
                WareHouse: groupItems.map((item) => item.WareHouse).toList(),
                items: groupItems.map((item) => item.Name).toList(),
                MainQuantity: MainQuantity,
                ItemQuantity: groupItems.map((item) => item.Number.toString()).toList(),
                Description: groupItems.map((item) => item.Description).toList(),
                ShortName: groupItems.map((item) => item.ShortName).toList(),
              );
            }).toList(),
              SizedBox(height: 20,),
              CustomButton(
                  buttonText: 'Редактировать данные',
                  MiniButton: false,
                  onPressed: toggleEditing),
              ]
          )

      );


    }
    }
    ),
    );
  }
  }

