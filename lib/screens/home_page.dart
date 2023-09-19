import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:thermal_paper_reader/screens/history.dart';
import 'package:thermal_paper_reader/screens/home_page.dart';
import 'package:thermal_paper_reader/widgets/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var image;
  var scannedText = "(Scanned text will appear here)";

  void getText() async {
    final inputImage = InputImage.fromFile(image);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText text = await textDetector.processImage(inputImage);
    await textDetector.close();
    Text(scannedText,
        style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold));
    for (TextBlock block in text.blocks) {
      for (TextLine line in block.lines) {
        scannedText += line.text + "\n";
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          animationDuration: const Duration(milliseconds: 200),
          backgroundColor: Colors.white,
          color: Colors.deepPurple.shade200,
          onTap: (index) {
            print(index);
          },
          items: [
            Icon(Icons.home),
            Icon(Icons.receipt),
          ]),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                ImageInput(
                  onPickImage: (file) {
                    image = file;
                  },
                ),
                SizedBox(
                  height: 90,
                  width: 200,
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
                SizedBox(
                  height: 30,
                ),
                Text(scannedText)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
