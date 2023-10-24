import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';

class ImageUtils {
  static Future<File> getImageFileFromAssetsIos(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }

  static Future<File> getImageFileFromAssetsAndroid(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }

  static Future<File?> getImageFileFromAsset(Asset? asset) async {
    if (Platform.isAndroid) {
      return await getImageFileFromAssetsAndroid(asset!);
    } else if (Platform.isIOS) {
      return await getImageFileFromAssetsIos(asset!);
    }
    return null;
  }

  static Future<File?> getImageCompress(File file,
      {int quality = 20, int minHeight = 1024, int minWidth = 1024}) async {
    var path = file.path;
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = "${dir.absolute.path}${basename(path)}.jpg";

    return await FlutterImageCompress.compressAndGetFile(path, targetPath,
        quality: quality, minHeight: minHeight, minWidth: minWidth);
  }
}
