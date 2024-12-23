import 'package:flutter/material.dart';
import '../../models/staff_model.dart';

class CustomSearchBar extends StatefulWidget {
  final List<Staff> items;
  final Function(List<Staff>) onSearch;
  final bool isDarkTheme;

  CustomSearchBar({
    required this.items,
    required this.onSearch,
    required this.isDarkTheme,
  });

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
    return widget.items
        .where((staff) =>
        '${staff.name}${staff.surname}${staff.patronymic}'
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDarkTheme ? Colors.white : Colors.black;
    final containerColor = widget.isDarkTheme ? Colors.white10 : Colors.grey[200];

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1400),
        child: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: containerColor,
          ),
          child: Center(
            child: TextField(
              onChanged: _onSearchChanged,
              style: TextStyle(color: textColor, height: 1.0),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isCollapsed: true,
                hintText: 'Поиск',
                hintStyle: TextStyle(color: Colors.grey[700]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[800]),
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
