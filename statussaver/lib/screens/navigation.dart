import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/screens/image.dart';
import 'package:statussaver/screens/videos.dart';
import 'package:statussaver/services/fetchImage.dart';
import 'package:statussaver/services/fetchVideos.dart';
import 'package:statussaver/services/permission.dart';

class NavigationToScreens extends StatefulWidget {
  NavigationToScreens({Key? key}) : super(key: key);
  static const String id = 'navigation';
  @override
  _NavigationToScreensState createState() => _NavigationToScreensState();
}

class _NavigationToScreensState extends State<NavigationToScreens> {
  int _selectedIdx = 0; //the selected screen

  final screens = [
    //this is the list of screens
    //both to display the videos and the images
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
    return MultiProvider(
      providers: [
        //raising state for the storage permission
        ChangeNotifierProvider.value(
          value: StoragePermission(),
        ),
        //raise state for fetching images
        ChangeNotifierProvider.value(
          value: ImageStorage(),
        ),
        ChangeNotifierProvider.value(
          value: VideoStorage(),
        ),
      ],
      child: Scaffold(
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
      ),
    );
  }
}
/**
 * 
 * 
 * this is the navigation bar for the application 
 * this alows the user to switch the screens 
 * with the bottom navigation bar provided by the 
 * widget bottom navigation bar 
 */
