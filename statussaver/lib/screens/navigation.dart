import 'package:flutter/material.dart';
import 'package:statussaver/screens/image.dart';
import 'package:statussaver/screens/videos.dart';

class NavigationToScreens extends StatefulWidget {
  NavigationToScreens({Key? key}) : super(key: key);
  static const String id = 'navigation';
  @override
  _NavigationToScreensState createState() => _NavigationToScreensState();
}

class _NavigationToScreensState extends State<NavigationToScreens> {
  int _selectedIdx = 0; //the selected screen

  final screens = [
    ImageScreen(),
    VideosFromStorage(),
  ];

  void _onItemTapped(int index) {
    //move to the next page as per the index
    setState(() {
      _selectedIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIdx,
        onTap: _onItemTapped,
        items: [
          //this are the buttons to diffrent pages
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'images',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection),
            label: 'videos',
          ),
        ],
      ),
      body: screens[_selectedIdx],
    );
  }
}
