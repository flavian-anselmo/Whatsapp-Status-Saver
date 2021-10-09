import 'package:share_plus/share_plus.dart';

class ShareImage {
  static Future<void> shareImage(List<String>imgPath) async {
    Share.shareFiles(imgPath);
  }
}
/**
 * this is the class model for sending images 
 * theough any social media account 
 */