import 'dart:io';

import 'package:flutter/material.dart';
import 'package:statussaver/constants/constants.dart';

class ImageStorage extends ChangeNotifier {
  var dir = Directory(path);
  var imageList;
  Future<List> getListOfImages() async {
    try {
      imageList = dir
          .listSync()
          .map((e) => e.path)
          .where((element) => element.endsWith('.jpg'))
          .toList();
      //notify the change using provider
      //iam currently fetchong jpg files
      notifyListeners();
      print(imageList);
      return imageList;
    } catch (e) {
      print(e);
      //return a list of exceptions that happend
      notifyListeners();
      return [e];
    }
  }
}
