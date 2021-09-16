import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/services/permission.dart';
import 'package:statussaver/services/fetchVideos.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideosFromStorage extends StatefulWidget {
  const VideosFromStorage({Key? key}) : super(key: key);
  //id for the video screen
  static const String id = 'display-videos';

  @override
  _VideosFromStorageState createState() => _VideosFromStorageState();
}

class _VideosFromStorageState extends State<VideosFromStorage> {
  bool isloading3 = false;
  late bool isLoading = false;
  late bool isLoading2 = false;
  bool isgetThumb = false;
  late List<dynamic> videoList;

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

  Future getThumbnail(videopathURL) async {
    //fetch the thumb nail from the videos
    var thumbnail;
    await Provider.of<StoragePermission>(context, listen: false)
        .getStoragePermission();
    isgetThumb = true;
    if (isgetThumb == true) {
      thumbnail = await VideoThumbnail.thumbnailData(
        video: videopathURL.path,
        quality: 25,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128,
      );
    }

    //print('thumbnailNKSDJVNSDIOVJNSDIIIIIIIIII');
    return Image.memory(thumbnail!);
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
                    return FutureBuilder(
                      future: getThumbnail(videoList[index]),
                      //initialData: InitialData,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            print('hasdata');
                          } else {
                            print('no data');
                          }
                          return Card(
                            child: Text(videoList[index]),
                          );
                        } else {
                          return Card(
                            child: Text('no data'),
                          );
                        }
                      },
                    );
                  },
                )
              : Center(child: CircularProgressIndicator())),
    );
  }
}
