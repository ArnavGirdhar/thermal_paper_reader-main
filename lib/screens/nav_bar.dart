import 'package:flutter/material.dart';
import 'package:thermal_paper_reader/screens/history.dart';
import 'package:thermal_paper_reader/screens/home_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;
  final screens = [
    const HomePage(title: "Thermal Paper Reader"),
    const History(title: "Thermal Paper Reader"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.deepPurple.shade100,
          ),
          child: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (index) => setState(() {
              this.index = index;
            }),
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.receipt), label: 'History'),
            ],
          ),
        ));
  }
}
