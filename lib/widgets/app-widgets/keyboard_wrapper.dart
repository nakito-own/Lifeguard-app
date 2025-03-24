import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/keyboard_manager.dart';

/// Виджет, обрабатывающий глобальные нажатия клавиш и передающий их в KeyboardManager
class KeyboardWrapper extends StatelessWidget {
  final Widget child;
  final FocusNode focusNode;
  
  KeyboardWrapper({
    Key? key,
    required this.child,
  }) : focusNode = FocusNode(),
       super(key: key);
       
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focusNode,
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.enter) {
            KeyboardManager().handleEnter(context);
          } else if (event.logicalKey == LogicalKeyboardKey.escape) {
            KeyboardManager().handleEscape(context);
          } else if (event.logicalKey == LogicalKeyboardKey.capsLock) {
            KeyboardManager().handleCapsLock(context);
          }
        }
      },
      child: child,
    );
  }
} 