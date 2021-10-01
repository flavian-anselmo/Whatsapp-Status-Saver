import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:statussaver/constants/constants.dart';

class VideoStorage extends ChangeNotifier {
  var _dir = Directory(path);
  var videoList;
  //List<String> l = [];
  Future<List> getListOfVideos() async {
    try {
      videoList = _dir
          .listSync()
          .map((e) => e.path)
          .where(
            (element) => element.endsWith('.mp4'),
          )
          .toList();
      notifyListeners();
      return videoList;
    } catch (e) {
      print(e);
      notifyListeners();
      return [e];
    }
  }
}
/**
 * this service here will fecch the videos 
 * from the associated dir and store them 
 * in a list if videos that will help me display the 
 * videos 
 */
