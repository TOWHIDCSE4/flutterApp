import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class SharePost {
  Future<void> sharePostImage(List<String?>? listUrl, String? content) async {
    Clipboard.setData(ClipboardData(text: content ?? ""));

    final cache = DefaultCacheManager(); // Gives a Singleton instance
    imagePaths = [];
    for (var image in (listUrl ?? [])) {
      final file = await cache.getSingleFile(image);

      imagePaths.add(file.path);
    }

    _onShare();
  }
    Future<void> shareLink(String link) async {
    //final box = Get.context!.findRenderObject() as RenderBox?;
    await Share.share(link);
  }

  Future<void> shareQrCode(String link) async {
  
    var qrImage = await QrPainter(
                  data: link,
                  version: QrVersions.auto,
                  errorCorrectionLevel: QrErrorCorrectLevel.L,
                ).toImageData(200);
    var file = await saveByteDataToFile(qrImage!);
    
    await Share.shareFiles([file.path]);
    

               
   
    
  }

  Future<File> saveByteDataToFile(ByteData byteData,) async {
  final buffer = byteData.buffer;
  final tempDir = await getTemporaryDirectory();
  final tempPath = tempDir.path;
  final file = File('$tempPath/qr_code.png');
  await file.writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  return file;
}






  List<String> imagePaths = [];
  Future<void> _onShare() async {
    final box = Get.context!.findRenderObject() as RenderBox?;
    await Share.shareFiles(imagePaths);
  }
}
