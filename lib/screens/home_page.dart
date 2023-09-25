import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:thermal_paper_reader/screens/history.dart';
import 'package:thermal_paper_reader/widgets/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final screens = [
    const History(title: "Thermal Paper Reader"),
  ];
  int index = 0;
  var image = null;
  var scannedText = "(Scanned text will appear here)";
  var temp = " temp ";
  void getText() async {
    final inputImage = InputImage.fromFile(image);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText text = await textDetector.processImage(inputImage);
    await textDetector.close();
    for (TextBlock block in text.blocks) {
      for (TextLine line in block.lines) {
        scannedText += '${line.text}';
      }
    }
    print(scannedText);

    // int count = 0;
    // for(int i = 0; i < scannedText.length; i++){
    //   if(scannedText[i] == ' ') count++;
    //   if(count%2 == 1) temp += '\n';
    //   else temp += scannedText[i];
    // }
    
    setState(() {});
  }

  void cropImage() async {
    var croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepPurple.shade200,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    setState(() {
      image = File(croppedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  child: ImageInput(
                    onPickImage: (file) {
                      setState(() {
                        image = file;
                      });
                    },
                    currentImage: image,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (image != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 90,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            scannedText = "";
                            getText();
                          },
                          child: Text(
                            "SCAN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 30),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 90,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: cropImage,
                          child: Text(
                            "CROP",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 80,
                  width: 120,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          image = null;
                          scannedText = " ";
                        });
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  temp,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
