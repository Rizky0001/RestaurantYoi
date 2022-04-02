import 'dart:io';

import 'package:restaurant/commons/theme.dart';
import 'package:restaurant/ui/settings_page.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/provider/preferences_provider.dart';
import 'package:restaurant/ui/favorite_page.dart';
import 'package:restaurant/ui/list_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  List<DotNavigationBarItem> _bottomNavBarItems = [
    DotNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
        selectedColor: secondaryColor,
        unselectedColor: primaryDarkColor),
    DotNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.bookmark : Icons.bookmark),
        selectedColor: secondaryColor,
        unselectedColor: primaryDarkColor),
    DotNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
        selectedColor: secondaryColor,
        unselectedColor: primaryDarkColor),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  List<Widget> _listWidget = [
    ListPage(),
    FavoritePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: Key("home_page_scaffold"),
        extendBody: true,
        body: _listWidget[_bottomNavIndex],
        bottomNavigationBar: Consumer<PreferencesProvider>(
          builder: (_, provider, child) {
            return DotNavigationBar(
              backgroundColor:
                  provider.isDarkTheme ? Color(0xFF222222) : primaryColor,
              borderRadius: 15,
              boxShadow: [
                BoxShadow(
                  color:
                  provider.isDarkTheme ? Colors.black : Color(0xFFBABABA),
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
              currentIndex: _bottomNavIndex,
              items: _bottomNavBarItems,
              onTap: _onBottomNavTapped,
            );
          },
        ),
      ),
    );
  }
}
