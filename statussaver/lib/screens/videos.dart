import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/services/permission.dart';
import 'package:statussaver/services/fetchVideos.dart';

class VideosFromStorage extends StatefulWidget {
  const VideosFromStorage({Key? key}) : super(key: key);
  //id for the video screen
  static const String id = 'display-videos';

  @override
  _VideosFromStorageState createState() => _VideosFromStorageState();
}

class _VideosFromStorageState extends State<VideosFromStorage> {
  @override
  void initState() {
    //provide permission and list the videos
    fetchData();
    super.initState();
  }

  late bool isLoading = false;
  late bool isLoading2 = false;
  var videoList;

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
        if (videoList != null) {
          //set the isloading value to true
          setState(() {
            isLoading2 = true;
            print('fetched weell');
          });
        }
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
