import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermission extends ChangeNotifier {
  bool permissiongGranted = false;
  Future getStoragePermission() async {
    try {
      if (await Permission.storage.request().isGranted) {
        permissiongGranted = true;
        //notify that the value is true
        print('permission granted');
        notifyListeners();

        //if the permission is denied
      } else if (await Permission.storage.request().isDenied) {
        permissiongGranted = false;
        print('storage permission denied ');
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
/**
 * this will handle is the mobile applicatio n 
 * has allowed the device to access the  internal
 * mwmory of it 
 */