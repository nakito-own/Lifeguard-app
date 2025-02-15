import 'package:flutter/material.dart';
import '../../models/staff_model.dart';
import 'package:lifeguard/utils/permissions_manager.dart';

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
  late Future<List<String>?> permissionsFuture;

  @override
  void initState() {
    super.initState();
    permissionsFuture = PermissionsManager().getPermissions();
  }

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
    return Container(
      margin: EdgeInsets.only(left: 12),
      constraints: BoxConstraints(
        maxWidth: 1200
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              FutureBuilder<List<String>?>(
                future: permissionsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error);
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Container();
                  } else {
                    final permissions = snapshot.data!;
                    if (permissions.contains('user new')) {
                      return IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.orange[800],
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: EdgeInsets.all(10),
                          splashFactory: InkRipple.splashFactory,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }
                },
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8),
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: containerColor,
                  ),
                  child: TextField(
                    onChanged: _onSearchChanged,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Поиск',
                      hintStyle: TextStyle(color: Colors.grey[700]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[800]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
