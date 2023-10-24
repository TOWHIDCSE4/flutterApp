

import 'package:image_picker/image_picker.dart';

class ImageData {
  XFile? file;
  String? linkImage;
  bool? errorUpload;
  bool? uploading;

  ImageData({this.file, this.linkImage, this.errorUpload, this.uploading});
}
