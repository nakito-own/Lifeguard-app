import 'package:flutter/material.dart';
import '../../models/staff_model.dart';
import 'package:lifeguard/utils/permissions_manager.dart';

class CustomSearchBar extends StatefulWidget {
  final List<Staff> items;
  final Function(List<Staff>) onSearch;
  final bool isDarkTheme;
  final VoidCallback onAddPressed;

  CustomSearchBar({
    required this.items,
    required this.onSearch,
    required this.isDarkTheme,
    required this.onAddPressed
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
    return Container(
      margin: EdgeInsets.all(8),
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
                    if (permissions.contains('user new') & permissions.contains('role new')) {
                      return IconButton(
                        onPressed: widget.onAddPressed,
                        icon: Icon(Icons.add),
                        style: IconButton.styleFrom(
                          backgroundColor: ColorScheme.of(context).secondary,
                          foregroundColor: ColorScheme.of(context).onSecondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
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
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: ColorScheme.of(context).primary,
                  ),
                  child: TextField(
                    onChanged: _onSearchChanged,
                    showCursor: true,
                    cursorColor: ColorScheme.of(context).secondary,
                    style: TextTheme.of(context).bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Поиск',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 24),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
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
