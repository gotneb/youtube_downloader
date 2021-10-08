import 'package:flutter/material.dart';

import 'downloads.dart';

class Tabbar extends StatefulWidget {
  final List<Widget> screens;

  const Tabbar({required this.screens});

  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;

      // Refresh screen Downloads, because IndexedStack not refresh it
      if (index == 1) {
        widget.screens.removeAt(index);
        widget.screens.insert(index, Downloads());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: widget.screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_download_rounded),
            label: 'Downloads',
          ),
        ],
        currentIndex: _currentIndex,
        backgroundColor: const Color.fromRGBO(41, 39, 56, 1),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromRGBO(78, 59, 247, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
