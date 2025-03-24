import 'dart:async';
import 'package:flutter/material.dart';

class KeyboardManager {
  static final KeyboardManager _instance = KeyboardManager._internal();
  factory KeyboardManager() => _instance;
  KeyboardManager._internal();
  
  final _enterPressedController = StreamController<BuildContext>.broadcast();
  final _escapePressedController = StreamController<BuildContext>.broadcast();
  final _capslockPressedController = StreamController<BuildContext>.broadcast();

  Stream<BuildContext> get onEnterPressed => _enterPressedController.stream;
  Stream<BuildContext> get onEscapePressed => _escapePressedController.stream;
  Stream<BuildContext> get onCapsLockPressed => _capslockPressedController.stream;

  void handleEnter(BuildContext context) => _enterPressedController.add(context);
  void handleEscape(BuildContext context) => _escapePressedController.add(context);
  void handleCapsLock(BuildContext context) => _capslockPressedController.add(context);
  
  void handleShift(BuildContext context) {
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    if (scaffold != null && scaffold.hasDrawer) {
      _capslockPressedController.add(context);
    }
  }

  void dispose() {
    _enterPressedController.close();
    _escapePressedController.close();
    _capslockPressedController.close();
  }
} 