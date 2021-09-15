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
  late VideoPlayerController controller; //controller for the videos
  late Future<void> initilizeVideoPlayerFuture;
  late File file;

  @override
  void initState() {
    //provide permission and list the videos
    fetchData();
    if (isLoading2 == true && isLoading == true) {
      controller = VideoPlayerController.file(file);
    }
    super.initState();
  }

  late bool isLoading = false;
  late bool isLoading2 = false;
  late List<dynamic> videoList;

  //check the permission to fetch videos form the hidden status file
  Future<void> checkStoragePermission() async {
    try {
      await Provider.of<StoragePermission>(context, listen: false)
          .getStoragePermission();

      setState(() {
        //chage to true
        isLoading = true;
      });

      if (isLoading == true) {
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
      if (isLoading == true) {
        videoList = await Provider.of<VideoStorage>(context, listen: false)
            .getListOfVideos();
        setState(() {
          isLoading2 = true;
          //file = File(videoList);
          print(videoList);
          print('fetched weell');
          //print(file);
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: isLoading2
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: videoList.length,
                  itemBuilder: (BuildContext contenxt, int index) {
                    return Card(
                      child: Text('data'),
                    );
                  },
                )
              : Center(child: CircularProgressIndicator())),
    );
  }
}
