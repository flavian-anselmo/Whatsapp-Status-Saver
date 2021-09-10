
import 'dart:io';

import 'package:flutter/material.dart';

class ViewSpecificImage extends StatelessWidget {
  ViewSpecificImage({this.image_path});
  final image_path;
  static const String id = 'view-specific-image';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //pick the image path and display 
        child: Image.file(File(image_path))
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