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
      //print(videoList);
      //l = videoList;
      //print(l);
      return videoList;
    } catch (e) {
      print(e);
      notifyListeners();
      return [e];
    }
  }
}
