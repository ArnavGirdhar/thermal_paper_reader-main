import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput(
      {super.key, required this.onPickImage, required this.currentImage});
  final File? currentImage;
  final void Function(File image) onPickImage;  

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? takenImage;

  void deleteImage(){
    setState(() {
      takenImage = null;
    });
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final gallery =
        await imagePicker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    // final gallery =
    //     await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (gallery == null) {
      return;
    }

    setState(() {
      takenImage = File(gallery.path);
    });

    widget.onPickImage(takenImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(Icons.camera),
      label: Text(
        "Take a picture",
        style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 31),
      ),
    );

    if (widget.currentImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          widget.currentImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
        ),
      ),
      child: content,
    );
  }
}
