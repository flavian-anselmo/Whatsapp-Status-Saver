import 'package:flutter/material.dart';

class VideosFromStorage extends StatelessWidget {
  const VideosFromStorage({Key? key}) : super(key: key);
  //id for the video screen
  static const String id = 'display-videos';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //display the location of videos in the applications 
          child: Text('Display the location of the videos'),
        ),
      ),
    );
  }
}
