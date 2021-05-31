import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_container/easy_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ThemeSwitchingArea(
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: Colors.indigo,
              appBar: kIsWeb
                  ? AppBar(
                      toolbarHeight: 65,
                      title: _customBottomNavigationBar(),
                      titleSpacing: 0,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    )
                  : null,
              body: EasyContainer(
                margin: 0,
                padding: 0,
                color: Colors.transparent,
                customBorderRadius: BorderRadius.vertical(
                  top: kIsWeb ? Radius.circular(40) : Radius.zero,
                  bottom: kIsWeb ? Radius.zero : Radius.circular(40),
                ),
                child: IndexedStack(
                  index: _selectedIndex,
                  children: _pages,
                ),
              ),
              bottomNavigationBar: kIsWeb ? null : _customBottomNavigationBar(),
            );
          },
        ),
      ),
    );
  }

  Widget _customBottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GNav(
        rippleColor: Colors.grey[300]!,
        hoverColor: Colors.grey[100]!,
        gap: 8,
        activeColor: Colors.black,
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: Colors.grey[100]!,
        color: Colors.black,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Feed',
            backgroundColor: Colors.pink,
          ),
          GButton(
            icon: Icons.person,
            text: 'Volunteers',
            backgroundColor: Colors.green,
          ),
          GButton(
            icon: Icons.settings,
            text: 'Settings',
            backgroundColor: Colors.red,
          ),
          GButton(
            icon: Icons.person,
            text: 'About Us',
            backgroundColor: Colors.amber,
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
