import 'package:admin/screens/user/category/category_screen.dart';
import 'package:admin/screens/user/home/home_screen.dart';
import 'package:admin/screens/user/search/search_screen.dart';
import 'package:admin/screens/user/userFunctionality/favorite_screen.dart';
import 'package:admin/screens/user/userFunctionality/profile_screen.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  static const roteName = '/navbar';
  @override
  State<StatefulWidget> createState() {
    return _MyBottomNavigationBarState();
  }
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    slider1(),
    CategoryScreen(),
    Search(),
    favorite(),
    profile()
  ];
  onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.home, color: Colors.blueGrey[500]),
              title: new Text("Home")),
          BottomNavigationBarItem(
              icon: new Icon(Icons.category, color: Colors.blueGrey[500]),
              title: new Text("Category")),
          BottomNavigationBarItem(
              icon: new Icon(Icons.search_rounded, color: Colors.blueGrey[500]),
              title: new Text("Search")),
          BottomNavigationBarItem(
              icon: new Icon(Icons.favorite, color: Colors.blueGrey[500]),
              title: new Text("Favorite")),
          BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle, color: Colors.blueGrey[500]),
              title: new Text("Profile"))
        ],
        selectedItemColor: Colors.blue[500],
      ),
    );
  }
}
