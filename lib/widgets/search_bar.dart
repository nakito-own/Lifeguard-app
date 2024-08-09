import 'package:flutter/material.dart';

import '../models/staff_model.dart';

class CustomSearchBar extends StatefulWidget {
  final List<Staff> items;
  final Function(List<Staff>) onSearch;

  CustomSearchBar({required this.items, required this.onSearch});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  String query = '';

  void _onSearchChanged(String value) {
    setState(() {
      query = value;
    });
    widget.onSearch(_filterItems(value));
  }

  List<Staff> _filterItems(String query) {
    return widget.items.where((staff) => '${staff.name}${staff.surname}${staff.patronymic}'.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final text_Color = isDarkTheme ? Colors.black : Colors.black;
    final container_Color = isDarkTheme ? Colors.white : Color(0xffd3d6d6);

    return Container(
      padding: EdgeInsets.fromLTRB(5,0,15,0),
      margin: EdgeInsets.fromLTRB(10,10,10,20),
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: container_Color,
      ),
      child: TextField(
        onChanged: _onSearchChanged,
        style: TextStyle(color: text_Color),
        decoration: InputDecoration(
          hintText: 'Поиск',
          hintStyle: TextStyle(color: Colors.grey[700]),
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Colors.grey[800],
          border: InputBorder.none
        ),
      ),
    );
  }
}