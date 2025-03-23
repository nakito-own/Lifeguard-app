import 'dart:async';
import 'package:flutter/material.dart';

class KeyboardManager {
  static final KeyboardManager _instance = KeyboardManager._internal();
  factory KeyboardManager() => _instance;
  KeyboardManager._internal();
  
  final _enterPressedController = StreamController<BuildContext>.broadcast();
  final _escapePressedController = StreamController<BuildContext>.broadcast();

  Stream<BuildContext> get onEnterPressed => _enterPressedController.stream;
  Stream<BuildContext> get onEscapePressed => _escapePressedController.stream;

  void handleEnter(BuildContext context) => _enterPressedController.add(context);
  void handleEscape(BuildContext context) => _escapePressedController.add(context);

  void dispose() {
    _enterPressedController.close();
    _escapePressedController.close();
  }
} 