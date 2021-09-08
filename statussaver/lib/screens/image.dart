import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  ImageScreen({Key? key}) : super(key: key);
  static const String id = 'image-display';

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Center(child: Text('Display images from path')));
  }
}
