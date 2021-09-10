import 'package:flutter/material.dart';
import 'package:statussaver/screens/image.dart';
import 'package:statussaver/screens/specific-img.dart';
import 'package:statussaver/screens/navigation.dart';
import 'package:statussaver/screens/splash.dart';
import 'package:statussaver/screens/videos.dart';

void main() {
  //the root to the application 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status Saver ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: NavigationToScreens.id,
      routes: {
        //this is the list of screens
        ViewSpecificImage.id:(context)=>ViewSpecificImage(),
        NavigationToScreens.id:(context)=>NavigationToScreens(),
        VideosFromStorage.id: (context) => VideosFromStorage(),
        SplashScreen.id:(context)=>SplashScreen(),
        ImageScreen.id:(context)=>ImageScreen()
      },
    );
  }
}
