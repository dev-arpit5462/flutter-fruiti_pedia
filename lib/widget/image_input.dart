import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
   ImageInput({super.key, required this.onPickImage,});

  final void Function(File image) onPickImage;


  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  
  void _takePicture() async {
    final imagepicker = ImagePicker();
    final pickedImage = await imagepicker.pickImage(
        source: ImageSource.camera, maxHeight: double.infinity, maxWidth: double.infinity);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Card(
      elevation: 5,
      color: const Color.fromARGB(160, 238, 232, 214),
      child: InkWell(
        child: Image.asset(
          "assets/icons/camera.png",
          height: 100,
          width: 100,
        ),
        onTap: () {
          _takePicture();
        },
      ),
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Hero(
          tag: 'inImage',
          child: Image.file(
            _selectedImage!,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 94, 85, 103))),
        alignment: Alignment.center,
        child: content);
  }
}
