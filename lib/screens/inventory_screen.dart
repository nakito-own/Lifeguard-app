import 'package:flutter/material.dart';
import 'package:lifeguard/models/Item_model.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';
import 'package:lifeguard/widgets/inventory-widgets/inventory_description.dart';
import 'package:lifeguard/widgets/inventory-widgets/inventory_editing.dart';
import '../api-services/show_staff_service.dart';
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
  late Future<Item> futureItem;
  List<String> MainQuantity = ['10', '20', '30'];
  List<String> ItemQuantity = ['1', '2', '3'];
  List<String> itemNames = ['Предмет 1', 'Предмет 2', 'Предмет 3'];
  List<String> items = ['Противогаз ' , 'Огнетушитель', 'Палка','Палка','Палка','Палка','Палка','Палка','Палка'];
  List<String> description = ['Это такой-то противогаз', 'Это такой-то огнетушитель', 'Это такая-то палка'];
  List<String> entries = ['Entry1', 'Entry2', 'Entry3'];
  List<String> groupName = ['Огонь', 'Вода', 'Воздух'];
  late AnimationController _controller;
  late Animation<double> _animation;
  final ShowStaffService _service = ShowStaffService();
  final PermissionsManager permissionsManager = PermissionsManager();

  String selectedInventory = 'Inventory 1';
  final TextEditingController _itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
      itemNames.removeAt(index);
      items.removeAt(index);
      entries.removeAt(index);
    });
  }

  void editItem(int index) {
    final TextEditingController _GroupNamecontroller = TextEditingController(text: groupName[index]);
    final TextEditingController _Itemscontroller = TextEditingController(text: items[index]);
    final TextEditingController _Descriptioncontroller = TextEditingController(text: description[index]);

    showDialog(context: context,
        builder: (BuildContext context)
    {
        return InventoryEditing(
          ItemName: itemNames[index],
          currentQuantity: groupName[index],
          GroupNamecontroller: _GroupNamecontroller,
          ItemNamecontroller: _Itemscontroller,
          Descriptioncontroller: _Descriptioncontroller,
            onPressed: (onPressed) {
            setState(() {
              groupName[index] = _GroupNamecontroller.text;
              items[index] = _Itemscontroller.text;
              description[index] = _Descriptioncontroller.text;
            });
        },
        );
    },
    );
  }

  void lookDescription (int index) {
    showDialog(context: context,
      builder: (BuildContext context)
      {
        return InventoryDescription(
            Description: description[index],
            ItemName: items[index],
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
      body: FutureBuilder<Item>(
        future: futureItem,
        builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('Инвентарь не загружен'));
          } else {
          final item = snapshot.data!;
          return SingleChildScrollView (
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              InventoryList(
                isEditing: isEditing,
                onDelete: deleteItem,
                onEditItem: editItem,
                onLookDescription: lookDescription,
                GroupName: 'Огонь',
                ItemName: itemNames,
                MainWidth: MediaQuery.of(context).size.width * 0.9,
                entries: entries,
                items: item.Name,
                MainQuantity: MainQuantity,
                ItemQuantity: ItemQuantity,
                Description: item.Description,
              ),
              InventoryList(
                isEditing: isEditing,
                onDelete: deleteItem,
                onEditItem: editItem,
                onLookDescription: lookDescription,
                GroupName: 'Вода',
                ItemName: itemNames,
                MainWidth: MediaQuery.of(context).size.width * 0.9,
                entries: entries,
                items: item.Name,
                MainQuantity: MainQuantity,
                ItemQuantity: ItemQuantity,
                Description: item.Description,
              ),
              InventoryList(
                isEditing: isEditing,
                onDelete: deleteItem,
                onEditItem: editItem,
                onLookDescription: lookDescription,
                GroupName: 'Воздух',
                ItemName: itemNames,
                MainWidth: MediaQuery.of(context).size.width * 0.9,
                entries:  entries,
                items: item.Name,
                MainQuantity: MainQuantity,
                ItemQuantity: ItemQuantity,
                Description: item.Description,
              ),
              SizedBox(height: 20,),
              CustomButton(
                  buttonText: 'Редактировать данные',
                  MiniButton: false,
                  onPressed: toggleEditing),
            ],
          )
      );


    }
    }
    ),
    );
  }
  }

