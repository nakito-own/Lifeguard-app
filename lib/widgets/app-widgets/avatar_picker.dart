import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  final Function(Uint8List) onImagePicked;

  AvatarPicker({required this.onImagePicked});

  @override
  _AvatarPickerState createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  Uint8List? _avatarImageData;

  Future<void> _pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final Uint8List imageData = await image.readAsBytes();
        setState(() {
          _avatarImageData = imageData;
        });
        widget.onImagePicked(imageData);
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: _avatarImageData != null ? MemoryImage(_avatarImageData!) : null,
            child: _avatarImageData == null ? Icon(Icons.add_a_photo_outlined, size: 50) : null,
          ),
          Positioned(
            bottom: -10,
            right: -10,
            child: IconButton(
              onPressed: _pickImage,
              icon: Icon(Icons.add_box_rounded, size: 30),
              tooltip: 'Выбрать файл',
              color: ColorScheme.of(context).secondary,
            ),
          ),
        ],
      ),
    );
  }
}