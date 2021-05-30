import 'package:flutter/material.dart';
import 'package:happy_us/screens/about_us_page.dart';
import 'package:happy_us/screens/feeds_page.dart';
import 'package:happy_us/screens/settings_page.dart';
import 'package:happy_us/screens/volunteers_page.dart';

class HomeNavigationScreen extends StatefulWidget {
  static const id = 'HomeNavigationScreen';

  const HomeNavigationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeNavigationScreenState createState() => _HomeNavigationScreenState();
}

class _HomeNavigationScreenState extends State<HomeNavigationScreen> {
  int _selectedIndex = 0;

  final _pages = [
    FeedsPage(),
    VolunteersPage(),
    SettingsPage(),
    AboutUsPage(),
  ];

  void _updateIndex(index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          fixedColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          onTap: _updateIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Feed",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Volunteers",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "About Us",
            ),
          ],
        ),
      ),
    );
  }
}
