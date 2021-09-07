import 'package:flutter/material.dart';
import 'package:statussaver/screens/splash.dart';
import 'package:statussaver/screens/videos.dart';

void main() {
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
      initialRoute: SplashScreen.id,
      routes: {
        //this is the list of screens
        VideosFromStorage.id: (context) => VideosFromStorage(),
        SplashScreen.id:(context)=>SplashScreen()
      },
    );
  }
}
