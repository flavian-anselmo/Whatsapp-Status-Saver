import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/services/fetchImage.dart';
import 'package:statussaver/services/permission.dart';

class ImageScreen extends StatefulWidget {
  ImageScreen({Key? key}) : super(key: key);
  static const String id = 'image-display';

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  //storage check instance
  StoragePermission checkStorage = StoragePermission();
  ImageStorage imageStore = ImageStorage();

  //String path = 'storage/emulated/0/whatsapp/Media/.Statuses/';
  var dir = Directory('storage/emulated/0/whatsapp/Media/.Statuses/');
  var imageList;
  bool isLoading = false;

  @override
  void initState() {
    //make sure the data is fetched form the db
    fetchData();
    super.initState();
  }

  Future<void> checkStoragePermission() async {
    try {
      await Provider.of<StoragePermission>(context, listen: false)
          .getStoragePermission();
      if (await checkStorage.permissiongGranted == true) {
        print('permission successful');
      } else if (await checkStorage.permissiongGranted == false) {
        print('permissionfailed');
      }
    } catch (e) {
      print('error::creating a permission ');
    }
  }

  Future<void> fetchImagesFromDir() async {
    try {
      //use provider to change the state of the app
      imageList = await Provider.of<ImageStorage>(context, listen: false)
          .getListOfImages();
      //imageList=await Provider.of<ImageStorage>(context,listen: false).imageList;
      isLoading = true;
    } catch (e) {
      print(e);
      print('error::failed to fetch the images ');
    }
  }

  //fetch evrything needed
  Future<void> fetchData() async {
    await checkStoragePermission();
    await fetchImagesFromDir();
    //isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    //chek if the dir exists in order to display the content
    return SafeArea(
      child: Scaffold(
          body: isLoading == true
              ? ListView.builder(
                  itemCount: imageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(File(imageList[index]));
                  },
                )
              : Center(child: CircularProgressIndicator())),
    );
  }
}

/**
 * this is the place we shall place the images for the application 
 * the user will be able to view the images tha are present in the location
 *  
 */
