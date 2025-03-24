import 'package:flutter/material.dart';
import 'dart:async';
import '../../utils/keyboard_manager.dart';
import 'app_drawer.dart';

class KeyboardAwareScaffold extends StatefulWidget {

  final String title;
  final VoidCallback toggleTheme;
  final Widget body;
  final VoidCallback? onEnterPressed;
  final VoidCallback? onEscapePressed;
  final String keyboardTooltip;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const KeyboardAwareScaffold({
    Key? key,
    required this.title,
    required this.toggleTheme,
    required this.body,
    this.onEnterPressed,
    this.onEscapePressed,
    this.keyboardTooltip = 'Управление с клавиатуры:\nCapsLock - открыть меню\nEnter - основное действие\nEsc - отмена',
    this.actions,
    this.bottomNavigationBar,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  _KeyboardAwareScaffoldState createState() => _KeyboardAwareScaffoldState();
}
class _KeyboardAwareScaffoldState extends State<KeyboardAwareScaffold> {
  late final StreamSubscription _capsLockSubscription;
  late final StreamSubscription? _enterSubscription;
  late final StreamSubscription? _escapeSubscription;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _setupKeyboardListeners();
  }

  void _setupKeyboardListeners() {
    _capsLockSubscription = KeyboardManager().onCapsLockPressed.listen((context) {
      _handleCapsLockPressed();
    });
    
    if (widget.onEnterPressed != null) {
      _enterSubscription = KeyboardManager().onEnterPressed.listen((context) {
        widget.onEnterPressed!();
      });
    }
    
    if (widget.onEscapePressed != null) {
      _escapeSubscription = KeyboardManager().onEscapePressed.listen((context) {
        widget.onEscapePressed!();
      });
    }
  }
  
  void _handleCapsLockPressed() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void dispose() {
    _capsLockSubscription.cancel();
    _enterSubscription?.cancel();
    _escapeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> appBarActions = [
      Tooltip(
        message: widget.keyboardTooltip,
        child: Icon(Icons.keyboard, size: 20),
      ),
      SizedBox(width: 10),
    ];

    if (widget.actions != null) {
      appBarActions.insertAll(0, widget.actions!);
    }
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: appBarActions,
      ),
      drawer: AppDrawer(toggleTheme: widget.toggleTheme),
      body: widget.body,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
    );
  }
} 