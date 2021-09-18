import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/services/permission.dart';
import 'package:statussaver/services/fetchVideos.dart';
import 'package:video_player/video_player.dart';

class VideosFromStorage extends StatefulWidget {
  const VideosFromStorage({Key? key}) : super(key: key);
  //id for the video screen
  static const String id = 'display-videos';

  @override
  _VideosFromStorageState createState() => _VideosFromStorageState();
}

class _VideosFromStorageState extends State<VideosFromStorage> {
  bool isFecthedAll= false;
  late bool isStoragePermission = false;
  late bool isVideoFetched = false;
  bool isgetThumb = false;
  late List<dynamic> videoList;
  late VideoPlayerController controller;

  @override
  void initState() {
    //provide permission and list the videos
    fetchData();
    controller = VideoPlayerController.file(File(videoList.first));

    super.initState();
  }

  //check the permission to fetch videos form the hidden status file
  Future<void> checkStoragePermission() async {
    try {
      await Provider.of<StoragePermission>(context, listen: false)
          .getStoragePermission();

      setState(() {
        //chage to true
        isStoragePermission= true;
      });

      if (isStoragePermission == true) {
        print('permission granted ');
      } else {
        print('permission denied ');
      }
    } catch (e) {
      print(e);
    }
  }

  //get the videos form the directories
  //aftert accessing the permission
  Future<void> fetchVideosFromDir() async {
    try {
      if (isStoragePermission == true) {
        videoList = await Provider.of<VideoStorage>(context, listen: false)
            .getListOfVideos();
        setState(() {
          isVideoFetched = true;
          print(videoList);
          print('fetched weell');
        });
      } else {
        print('permission to dir was denied ');
      }
    } catch (e) {
      print(e);
      print('erro::failed to fetch videoes ');
    }
  }

  Future<void> fetchData() async {
    //fetch the videos form the dir
    await checkStoragePermission();
    await fetchVideosFromDir();
    isFecthedAll = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(),
      ),
    );
  }
}
