import 'package:chewie/chewie.dart';
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
  late VideoPlayerController videocontroller;
  late ChewieController chewiecontroller;
  late Future<void> initializeVideoPlayerFuture;

  //dingle video and chewie widget
  var playerWidget;
  var videoList;

  //this are the lists that define the video display
  List videoControllerList = [];
  List chewieControllerList = [];
  List playerWidgetList = [];

  @override
  void initState() {
    super.initState();
    //provide permission and list the videos
    fetchData().whenComplete(() {
      //when the action of fecthing data is complete display a video
      videoInitializer();
    });
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

  Future<void> videoInitializer() async {
    await checkStoragePermission();
    setState(() {
      try {
        for (int idx = 0; idx < videoList; idx++) {
          //initialise a video controller with a video then add it to the
          //list of controllers below
          videocontroller = VideoPlayerController.contentUri(
            Uri.parse(videoList[idx]),
          );
          //add a controller to the list
          videoControllerList.add(videocontroller);
        }
        isFecthedAll = true;
      } catch (e) {
        print(e);
      }
    });
    try {
      if (isFecthedAll==true) {
        //check if the length are the same
        await videocontroller.initialize().whenComplete(() {
          //if th initialisation is over
          setState(() {
            for (int index = 0; index < videoControllerList.length; index++) {
              //iterate the videoControllers to make a list of chewie controllers

              //set the chewies with its config
              chewiecontroller = ChewieController(
                videoPlayerController: videoControllerList[index],
                autoPlay: false,
                looping: false,
              );
              //add a chewie controller to the list
              chewieControllerList.add(chewiecontroller);
            }
            if (videoControllerList.length == chewieControllerList.length) {
              //set the widgets for display
              for (int idx = 0; idx < chewieControllerList.length; idx++) {
                //iterate as we fetch the controllers for display
                playerWidget = Chewie(controller: chewieControllerList[idx]);
                //add widgets to a list of widgets
                playerWidgetList.add(playerWidget);
              }
            }

            //this is the widget that displays the videos
          });
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchData() async {
    //fetch the videos from the dir
    await checkStoragePermission();
    await fetchVideosFromDir();
  }

  @override
  void dispose() {
    //free up the memory
    videocontroller.dispose();
    chewiecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AspectRatio(
          aspectRatio: videocontroller.value.aspectRatio,
          child: videocontroller.value.isInitialized
              ? ListView.builder(
                  itemCount: playerWidgetList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return playerWidgetList[index];
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}

/**
 * 
 * if i have to display a list of videos 
 * i will have a list of viseo controllers and chewie controller 
 * this will be displayed through the helip of array indexing
 * 
 * 
 * have a list of player widgets 
 * 
 * have a list of videocontrollers 
 * 
 * 
 * i will need a list of chewies the n set the specific controller 
 * with its specific index in  the lis  
 * 
 */
