import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thermal_paper_reader/screens/home_page.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: GoogleFonts.raleway().fontFamily,
          useMaterial3: true,
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              )),
      home: const HomePage(title: 'Thermal Paper Reader'),
    );
  }
}
