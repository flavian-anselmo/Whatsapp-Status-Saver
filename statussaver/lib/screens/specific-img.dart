import 'dart:io';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/services/imgdownload.dart';
import 'package:statussaver/services/shareImage.dart';

// ignore: must_be_immutable
class ViewSpecificImage extends StatelessWidget {
  ViewSpecificImage({this.image_path});
  var image_path;
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
          IconButton(
            onPressed: () {
              //allow sharing of the image
              ShareImage.shareImage([image_path]);
            },
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              //allow downloading the image
              Provider.of<ImageDownload>(context, listen: false)
                  .downLoadToGallery(image_path);
            },
            icon: Icon(Icons.download),
          ),
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
