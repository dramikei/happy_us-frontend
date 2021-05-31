import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_container/easy_container.dart';
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
    final showBelow = MediaQuery.of(context).size.width < 475;
    return SafeArea(
      child: ThemeSwitchingArea(
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: Colors.indigo,
              appBar: showBelow
                  ? null
                  : AppBar(
                      toolbarHeight: 65,
                      title: Row(
                        mainAxisAlignment: showBelow
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceBetween,
                        children: [
                          Text("LOGO HERE"),
                          if (!showBelow) _customBottomNavigationBar(),
                        ],
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
              body: EasyContainer(
                margin: 0,
                padding: 0,
                color: Colors.transparent,
                customBorderRadius: BorderRadius.vertical(
                  top: showBelow ? Radius.zero : Radius.circular(40),
                  bottom: showBelow ? Radius.circular(40) : Radius.zero,
                ),
                child: IndexedStack(
                  index: _selectedIndex,
                  children: _pages,
                ),
              ),
              bottomNavigationBar:
                  showBelow ? _customBottomNavigationBar() : null,
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
