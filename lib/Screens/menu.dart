import 'package:flutter/material.dart';
import 'package:nicode/Screens/profile.dart';
import 'package:nicode/Screens/search.dart';
import 'package:nicode/Screens/tools.dart';

import '../constans.dart';
import 'home.dart';
import 'incress.dart';

class menu extends StatefulWidget {
  const menu({Key? key}) : super(key: key);

  @override
  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {
  var _currentIndex = 0;
  final List<Widget> _children = [
    profile(),
    search(),
    incress(),
    tools(),
    home()
  ];
  List _namedPage = ['profile', 'search', 'incress', 'category', 'home'];

  void onTabTaped(int index) {
    setState(() {
      _currentIndex = index;
      print('index');
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            clipBehavior: Clip.antiAlias,
            onPressed: () {},
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          color: wh.withOpacity(1),
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
              unselectedItemColor: bla.withOpacity(1),
              selectedItemColor: bl.withOpacity(1),
              currentIndex: _currentIndex,
              onTap: (i) {
                setState(() {
                  () => _currentIndex = i;
                  onTabTaped(i);
                  print(_currentIndex);
                });
              },
              showSelectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: 'profile',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'search'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      color: wh.withOpacity(1),
                    ),
                    label: 'incress',
                    backgroundColor: wh.withOpacity(1)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'category'),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home')
              ]),
        ),
        body: _children[_currentIndex],
      ),
    );
  }
}
