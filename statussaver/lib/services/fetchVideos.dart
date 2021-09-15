import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:statussaver/constants/constants.dart';

class VideoStorage extends ChangeNotifier {
  var _dir = Directory(path);
  var videoList;
  Future<void> getListOfVideos() async {
    try {
      videoList = _dir
          .listSync()
          .map((e) => e.path)
          .where((element) => element.endsWith('.mp4'));
      notifyListeners();
      print(videoList);
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }
}
