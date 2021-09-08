import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  //String path = 'storage/emulated/0/whatsapp/Media/.Statuses/';
  var dir = Directory('storage/emulated/0/whatsapp/Media/.Statuses/');

  @override
  void initState() {
    //check the population
    checkStoragePermission();
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

  @override
  Widget build(BuildContext context) {
    //chek if the dir exists in order to display the content
    if (!Directory('${dir.path}').existsSync()) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Insall Whats app'),
            Text('Your Friends Data will Be Available Here'),
          ],
        ),
      );
    } else {
      final imageList = dir
          .listSync()
          .map((e) => e.path)
          .where((element) => element.endsWith('.jpg'));
      if (imageList.length > 0) {
        return ListView.builder(
          itemCount: imageList.length,
          itemBuilder: (BuildContext context, int index) {
            final path = imageList[index];
            return Container(Text(path));
          },
        );
      }
    }
  }
}

/**
 * this is the place we shall place the images for the application 
 * the user will be able to view the images tha are present in the location
 *  
 */
