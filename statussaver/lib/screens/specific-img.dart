import 'dart:io';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:statussaver/services/shareImage.dart';

// ignore: must_be_immutable
class ViewSpecificImage extends StatefulWidget {
  ViewSpecificImage({this.image_path});
  var image_path;
  static const String id = 'view-specific-image';

  @override
  _ViewSpecificImageState createState() => _ViewSpecificImageState();
}

class _ViewSpecificImageState extends State<ViewSpecificImage> {
  Future<void> downLoadImg() async {
    try {
      var appDir = await getTemporaryDirectory();
      var save_path = appDir.path + "image_path";
      await ImageGallerySaver.saveFile(save_path);
      print('object fixed');
    } catch (e) {
      print('object');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        //pick the image path and display
        child: Container(
          child: Image.file(
            File(widget.image_path),
          ),
        ),
      ),
      floatingActionButton: FabCircularMenu(
        children: <Widget>[
          IconButton(
            onPressed: () {
              //allow sharing of the image
              ShareImage.shareImage([widget.image_path]);
            },
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              //allow downloading the image
              downLoadImg();
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
