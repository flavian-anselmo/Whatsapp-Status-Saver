import 'package:share_plus/share_plus.dart';

class ShareImage {
  static Future<void> shareImage(List<String>img_path) async {
    Share.shareFiles(img_path);
  }
}
/**
 * this is the class model for sending images 
 * theough any social media account 
 */