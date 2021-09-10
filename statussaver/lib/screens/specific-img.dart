import 'dart:io';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

class ViewSpecificImage extends StatelessWidget {
  ViewSpecificImage({this.image_path});
  final image_path;
  static const String id = 'view-specific-image';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        //pick the image path and display
        child: Container(
          child: Image.file(
            File(image_path),
          ),
        ),
      ),
      floatingActionButton: FabCircularMenu(
        children: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: Icon(Icons.download)),
          //IconButton(onPressed: () {}, icon: Icon(Icons.)),
        ],
      ),
    );
  }
}
/**
 * screen to view the specific image 
 * once it is tapped 
 * THis will allow the user to 
 * view download and share the image 
 */
