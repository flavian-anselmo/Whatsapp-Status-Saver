import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/services/permission.dart';
import 'package:statussaver/services/fetchVideos.dart';
import 'package:video_player/video_player.dart';

class VideosFromStorage extends StatefulWidget {
  const VideosFromStorage({this.videoList});
  final videoList;
  //id for the video screen
  static const String id = 'display-videos';

  @override
  _VideosFromStorageState createState() => _VideosFromStorageState();
}

class _VideosFromStorageState extends State<VideosFromStorage> {
  bool isFecthedAll = false;
  bool isStoragePermission = false;
  bool isVideoFetched = false;
  bool isgetThumb = false;
  late final VideoPlayerController controller;
  
  var videoList;

  @override
  void initState() {
    //provide permission and list the videos
    fetchData();

    super.initState();
  }

  //check the permission to fetch videos form the hidden status file
  Future<void> checkStoragePermission() async {
    //get the permission from the device first then fetch the videos 
    try {
      await Provider.of<StoragePermission>(context, listen: false)
          .getStoragePermission();

      setState(() {
        //chage to true
        isStoragePermission = true;
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
    //fetch the videos from associated dir ..only if permission is granted 
    try {
      if (isStoragePermission == true) {
        videoList = await Provider.of<VideoStorage>(context, listen: false)
            .getListOfVideos();
        //await checkStoragePermission();

      } else {
        print('permission to dir was denied ');
      }
    } catch (e) {
      print(e);
      print('erro::failed to fetch videoes ');
    }
  }

  Future<void> fetchData() async {
    //fetch the videos from the dir
    await checkStoragePermission();
    await fetchVideosFromDir();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(),
    ));
  }
}
