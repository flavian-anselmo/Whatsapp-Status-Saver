import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:statussaver/screens/navigation.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  //id for the spalsh screen
  static const String id = 'splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFecthedAll = true;
  bool isStoragePermission = true;
  bool isVideoFetched = true;
  late List<dynamic> videoList = [];
  //check the permission to fetch videos form the hidden status file
  @override
  void initState() {
    //FETCH ALL the data before proceding t the app
    fetchData();
    super.initState();
  }

  // Future<void> checkStoragePermission() async {
  //   try {
  //     await Provider.of<StoragePermission>(context, listen: false)
  //         .getStoragePermission();

  //     setState(() {
  //       //chage to true
  //       isStoragePermission = true;
  //     });

  //     if (isStoragePermission == true) {
  //       print('permission granted ');
  //     } else {
  //       print('permission denied ');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // //get the videos form the directories
  // //aftert accessing the permission
  // Future<void> fetchVideosFromDir() async {
  //   try {
  //     if (isStoragePermission == true) {
  //       videoList = await Provider.of<VideoStorage>(context, listen: false)
  //           .getListOfVideos();
  //       //await checkStoragePermission();
  //       setState(() {
  //         isVideoFetched = true;
  //         if (isVideoFetched == true) {
  //           print('Video is fetched ');
  //           print(videoList);
  //         } else {
  //           print('not fetched well');
  //         }
  //       });
  //     } else {
  //       print('permission to dir was denied ');
  //     }
  //   } catch (e) {
  //     print(e);
  //     print('erro::failed to fetch videoes ');
  //   }
  // }

  Future<void> fetchData() async {
    try {
      //fetch the videos form the dir
      // await checkStoragePermission();
      // await fetchVideosFromDir();

      if (isVideoFetched == true && isStoragePermission == true) {
        //naviaget to the next screen and pass the list of videos
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return NavigationToScreens();
            }),
          );
        });
      }
    } catch (e) {
      print(e);
      print('error::fetching data and getiing permission ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'status saver',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 45,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Center(
                //check for internet connection and display somethidn else
                child: SpinKitCubeGrid(
                  color: Colors.green,
                  size: 100.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Center(
                  child: Text(
                    'built by Anselmo.Jr',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
