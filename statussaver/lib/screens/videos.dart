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
  bool isFecthedAll = false;
  bool isStoragePermission = false;
  bool isVideoFetched = false;
  bool isgetThumb = false;
  late List<dynamic> videoList;
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void initState() {
    //provide permission and list the videos
    fetchData();

    super.initState();
  }

  //check the permission to fetch videos form the hidden status file
  Future<void> checkStoragePermission() async {
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
    try {
      if (isStoragePermission == true) {
        videoList = await Provider.of<VideoStorage>(context, listen: false)
            .getListOfVideos();
        await checkStoragePermission();
        setState(() {
          isVideoFetched = true;
          if (isVideoFetched == true) {
            for (int index = 0; index < videoList.length; index++) {
              controller = VideoPlayerController.contentUri(
                Uri.parse(
                  videoList[index],
                ),
              );
            }
            initializeVideoPlayerFuture = controller.initialize();

            //controller.addListener(() {});
            //controller.initialize().then((value) => controller.play());
          } else {
            print('not fetched well');
          }

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
    setState(() {
      isFecthedAll = true;
    });
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
      body: FutureBuilder(
        future: initializeVideoPlayerFuture,
        //initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              videoList.length > 0) {
            return ListView.builder(
              itemCount: videoList.length,
              itemBuilder: (BuildContext context, int index) {
                return AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          });
        },
      ),
    ));
  }
}
