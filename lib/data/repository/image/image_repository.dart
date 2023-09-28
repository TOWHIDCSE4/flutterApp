import 'dart:io';
import 'package:dio/dio.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class ImageRepository {
  Future<String?> uploadImage({File? image, required String type}) async {
    try {
      var res = await SahaServiceManager().service!.uploadImage(
        {
          "image":
              image == null ? null : await MultipartFile.fromFile(image.path),
          "type": type
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<String?> uploadVideo({File? video, required String type}) async {
    try {
      var res = await SahaServiceManager().service!.uploadVideo(
        {
          "video":
          video == null ? null : await MultipartFile.fromFile(video.path),
          "type": type
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}
