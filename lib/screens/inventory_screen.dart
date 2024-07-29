import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';
import 'package:lifeguard/widgets/inventory-widgets/inventory_editing.dart';
import '../widgets/app-widgets/app_drawer.dart';
import '../widgets/inventory-widgets/inventory_list.dart';

class InventoryScreen extends StatefulWidget {

  final VoidCallback toggleTheme;

  InventoryScreen({required this.toggleTheme});

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> with SingleTickerProviderStateMixin {
  //bool _isEditingVisible = false;
  bool isEditing = false;
  List<String> quantity = ['10', '20', '30'];
  List<String> itemNames = ['Предмет 1', 'Предмет 2', 'Предмет 3'];
  List<String> items = ['Противогаз ' , 'Огнетушитель', 'Палка'];
  List<String> entries = ['Entry1', 'Entry2', 'Entry3'];
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

 /* void _toggleEditingWidget() {
    setState(() {
      _isEditingVisible = !_isEditingVisible;
      if (_isEditingVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }*/

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

  void editItemQuantity(int index) {
    final TextEditingController _Quantitycontroller = TextEditingController(text: quantity[index]);
    final TextEditingController _Itemscontroller = TextEditingController(text: items[index]);

    showDialog(context: context,
        builder: (BuildContext context)
    {
        return InventoryEditing(
          ItemName: itemNames[index],
          currentQuantity: quantity[index],
          Quantitycontroller: _Quantitycontroller,
          ItemNamecontroller: _Itemscontroller,
          labelText: 'Кол-во',
            onPressed: (onPressed) {
            setState(() {
              quantity[index] = _Quantitycontroller.text;
              items[index] = _Itemscontroller.text;
            });
        },
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
      body: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 10, left: 0, right: 10),
          child: SingleChildScrollView (
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              InventoryList(
                isEditing: isEditing,
                onDelete: deleteItem,
                onEditQuantity: editItemQuantity,
                GroupName: 'Огонь',
                ItemName: itemNames,
                MainWidth: MediaQuery.of(context).size.width * 0.9,
                entries: entries,
                items: items,
                quantity: quantity,
              ),
              InventoryList(
                isEditing: isEditing,
                onDelete: deleteItem,
                onEditQuantity: editItemQuantity,
                GroupName: 'Вода',
                ItemName: itemNames,
                MainWidth: MediaQuery.of(context).size.width * 0.9,
                entries: entries,
                items: items,
                quantity: quantity,
              ),
              InventoryList(
                isEditing: isEditing,
                onDelete: deleteItem,
                onEditQuantity: editItemQuantity,
                GroupName: 'Воздух',
                ItemName: itemNames,
                MainWidth: MediaQuery.of(context).size.width * 0.9,
                entries:  entries,
                items: items,
                quantity: quantity,
              ),
              SizedBox(height: 20,),
              CustomButton(
                  buttonText: 'Редактировать данные',
                  MiniButton: false,
                  onPressed: toggleEditing),
            ],
          )
      ),
      ),
    );
  }
  }

