import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:happy_us/screens/reach_out_page.dart';
import 'package:happy_us/screens/feeds_page.dart';
import 'package:happy_us/screens/dashboard_page.dart';
import 'package:happy_us/screens/volunteers_page.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/logo.dart';

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
    ReachOutPage(),
    DashboardPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final showBelow = MediaQuery.of(context).size.width < SMALL_SCREEN_WIDTH;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        appBar: showBelow
            ? null
            : AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 65,
                title: Row(
                  mainAxisAlignment: showBelow
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          if (_selectedIndex != 0)
                            setState(() => _selectedIndex = 0);
                        },
                        child: Logo()
                      ),
                    ),
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
          child: _pages[_selectedIndex],
        ),
        bottomNavigationBar: showBelow ? _customBottomNavigationBar() : null,
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
        activeColor: Colors.white,
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: kFocusColor,
        color: Colors.black,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Feed',
          ),
          GButton(
            icon: Icons.person,
            text: 'Volunteers',
          ),
          GButton(
            icon: Icons.star,
            text: 'Reach Out',
          ),
          GButton(
            icon: Icons.settings,
            text: 'Dashboard',
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
