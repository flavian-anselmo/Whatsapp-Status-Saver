import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:statussaver/screens/videos.dart';

class ImageScreen extends StatefulWidget {
  ImageScreen({Key? key}) : super(key: key);
  static const String id = 'image-display';

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late PersistentTabController controller;
  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> buildscreens() {
    /**
     * this method will be sued to return the build screens 
     * as it persists the bottom bar 
     */
    return [
      ImageScreen(),
      VideosFromStorage(),
    ];
  }

  List<PersistentBottomNavBarItem> bottomNavBarItems() {
    /**
   * now create the navigation bar items 
   * those are the buttons to be used by the user 
   */
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.video_collection),
        title: ('videos'),
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: ImageScreen.id,
          routes: {
            VideosFromStorage.id: (context) => VideosFromStorage(),
            ImageScreen.id: (context) => ImageScreen()
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.image),
        title: ('images'),
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: ImageScreen.id,
          routes: {
            VideosFromStorage.id: (context) => VideosFromStorage(),
            ImageScreen.id: (context) => ImageScreen()
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: buildscreens(),
      items: bottomNavBarItems(),
      confineInSafeArea: true,
      stateManagement: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      
    );
  }
}
