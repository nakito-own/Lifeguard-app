import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AvatarPicker extends StatefulWidget {
  @override
  _AvatarPickerState createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  Uint8List? _avatarImageData;

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.first.bytes != null) {
        setState(() {
          _avatarImageData = result.files.first.bytes;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _avatarImageData != null ? MemoryImage(_avatarImageData!) : null,
          child: _avatarImageData == null ? Icon(Icons.image_outlined, size: 50) : null,
        ),
        IconButton(
          onPressed: _pickImage,
          icon: Icon(Icons.camera_alt),
          tooltip: 'Выбрать файл',
          color: Colors.blue,
        ),
      ],
    );
  }
}
