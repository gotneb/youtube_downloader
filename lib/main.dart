import 'package:flutter/material.dart';
import 'package:youtube_downloader/screens/downloads.dart';

import 'screens/home.dart';
import 'screens/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NavigationBar(),
        );
  }
}

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;

  final _widgetOptions = <Widget>[
    Home(),
    Downloading(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
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
        currentIndex: _selectedIndex,
        backgroundColor: const Color.fromRGBO(41, 39, 56, 1),
        selectedItemColor: const Color.fromRGBO(78, 59, 247, 1),
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
