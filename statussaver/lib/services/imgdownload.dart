import 'package:flutter/widgets.dart';

class ImageDownload extends ChangeNotifier {
  Future<void> downLoadToGallery(var img_name) async {
    //allow the user to download the image to the gallery
    try {
      
      print('downloaded');
      notifyListeners();
    } catch (e) {
      print(e);
      print('error:::image not saved to gallery ');
      notifyListeners();
    }
  }
}
