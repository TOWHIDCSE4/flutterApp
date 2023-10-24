import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/repository/repository_manager.dart';
import '../../../model/image_assset.dart';

const MAX_SELECT = 10;

class SelectImageController extends GetxController {
  Function? onUpload;
  Function? doneUpload;
  String type;
  int maxImage;
  SelectImageController(
      {this.onUpload,
      this.doneUpload,
      required this.type,
      required this.maxImage});

  var dataImages = <ImageData>[].obs;

  void deleteImage(ImageData? imageData) {
    if (imageData!.file == null) {
      var indexRm = dataImages
          .toList()
          .map((e) => e.linkImage)
          .toList()
          .indexOf(imageData.linkImage!);
      dataImages.removeAt(indexRm);
    } else {
      var indexRm = dataImages
          .toList()
          .map((e) => e.file)
          .toList()
          .indexOf(imageData.file!);
      dataImages.removeAt(indexRm);
    }
    //updateListImage(dataImages.map((element) => element.file).toList());
    doneUpload!(dataImages.toList());
  }

  void updateListImage(List<XFile?> listAsset) {
    print(listAsset.map((e) => e!.path));
    print(dataImages.map((e) => e.file?.path));
    onUpload!();

    var listPre = dataImages.toList();

    for (var asset in listAsset) {
      if (listPre.isEmpty) {
        dataImages.add(ImageData(
            file: asset,
            linkImage: null,
            errorUpload: false,
            uploading: false));
      } else {
        var check =
            listPre.map((e) => e.file?.path).toList().contains(asset!.path);
        print(check);
        if (check) {
          print("da ton tai");
        } else {
          print("add");
          dataImages.add(ImageData(
              file: asset,
              linkImage: null,
              errorUpload: false,
              uploading: false));
        }
      }
    }
    uploadListImage();
  }

  void uploadListImage() async {
    int stackComplete = 0;

    var responses = await Future.wait(dataImages.map((imageData) {
      if (imageData.linkImage == null) {
        return uploadImageData(
            indexImage: dataImages.indexOf(imageData),
            onOK: () {
              stackComplete++;
            });
      } else {
        return Future.value(null);
      }
    }));

    doneUpload!(dataImages.toList());
  }

  Future<void> uploadImageData(
      {required int indexImage, required Function onOK}) async {
    try {
      dataImages[indexImage].uploading = true;
      dataImages.refresh();

      var link = await RepositoryManager.imageRepository.uploadImage(
          image: File(dataImages[indexImage].file!.path), type: type);

      dataImages[indexImage].linkImage = link;
      dataImages[indexImage].errorUpload = false;
      dataImages[indexImage].uploading = false;
      dataImages.refresh();
    } catch (err) {
      print(err);
      dataImages[indexImage].linkImage = null;
      dataImages[indexImage].errorUpload = true;
      dataImages[indexImage].uploading = false;
      dataImages.refresh();
    }
    onOK();
  }

  Future<File> getImageFileFromAssetsAndroid(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future<void> loadAssets() async {
    List<XFile>? pickedFileList =
        []; //dataImages.toList().map((e) => e.file!).toList();
    String error = 'No Error Detected';
    print('bcd');
    try {
      pickedFileList = await ImagePicker().pickMultiImage(
        imageQuality: 50,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if ((pickedFileList ?? []).length > maxImage) {
      List<XFile> list = [];
      for (int i = 0; i < maxImage; i++) {
        list.add(pickedFileList![i]);
      }
      pickedFileList = list;
    }
    print((pickedFileList ?? []).map((e) => e.path));
    if (pickedFileList != null) {
      updateListImage(pickedFileList);
    }
  }
}
