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
      if (await checkStorage.permissiongGranted==true) {
        print('permission successful');
      } else if (await checkStorage.permissiongGranted==false) {
        print('permissionfailed');
      }
    } catch (e) {
      print('error::creating a permission ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Center(child: Text('Display images from path')));
  }
}

/**
 * this is the place we shall place the images for the application 
 * the user will be able to view the images tha are present in the location
 *  
 */
