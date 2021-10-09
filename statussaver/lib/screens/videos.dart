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
  List<VideoPlayerController> videoControllerList = [];
  List <ChewieController>chewieControllerList = [];
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
        print(videoList);
      } else {
        print('permission to dir was denied ');
      }
    } catch (e) {
      print(e);
      print('erro::failed to fetch videoes ');
    }
  }

  Future<void> videoInitializer() async {
    //await checkStoragePermission();
    setState(() {
      try {
        for (int index = 0; index < videoList.length; index++) {
          videocontroller = VideoPlayerController.contentUri(
            Uri.parse(videoList[index]),
          );
          videoControllerList.add(videocontroller);
        }
        //This is the lenghth of both the controllers and the video list
        print(videoControllerList.length);
        print(videoList.length);
        if (videoControllerList.length == videoList.length) {
          //setit to true to know that the contrllers anre ready
          isFecthedAll = true;
        }
      } catch (e) {
        print(e);
      }
    });
    try {
      if (isFecthedAll == true) {
        await videocontroller.initialize().whenComplete(() {
          //if th initialisation is over
          setState(() {
            for (int index = 0; index < videoControllerList.length; index++) {
              //get the list of chewie controllers
              chewiecontroller = ChewieController(
                videoPlayerController: videoControllerList[index],
                autoPlay: false,
                looping: false,
              );
              //add chewie controllers to the list of chewie controllres
              chewieControllerList.add(chewiecontroller);
            }
            //get the liength of chewies
            print(chewieControllerList.length);

            // for (int index = 0; index < chewieControllerList.length; index++) {
            //   //set the widgets with the chewie controllers in a list
            //   playerWidget = Chewie(controller: chewieControllerList[index]);
            //   playerWidgetList.add(playerWidget);
            // }
            // print(
            //     "===================================${playerWidgetList.length}==========================");
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
    //chewiecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: videocontroller.value.isInitialized && chewieControllerList.length == videoControllerList.length 
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: chewieControllerList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chewie(
                            controller: chewieControllerList[index]),
                      );
                    }),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      )),
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
