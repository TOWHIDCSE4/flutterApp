import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../data/repository/repository_manager.dart';

class SelectAvatarImage extends StatelessWidget {
  late SelectLogoImageController selectImageController;

  final Function? onChange;
  final String? linkLogo;
  String type;

  SelectAvatarImage(
      {Key? key, this.onChange, this.linkLogo, required this.type}) {
    selectImageController = Get.put(SelectLogoImageController(type: type));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Obx(() {
        var deviceImage = selectImageController.pathImage;
        if (deviceImage.value == "") {
          return addImage();
        }
        return buildItemAsset(File(deviceImage.value));
      }),
    );
  }

  Widget addImage() {
    return selectImageController.isLoadingAdd.value
        ? SahaLoadingWidget()
        : Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                selectImageController.getImage(onOK: (link) {
                  onChange!(link);
                });
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border:
                        Border.all(color: Theme.of(Get.context!).primaryColor)),
                child: linkLogo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: CachedNetworkImage(
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          imageUrl: linkLogo!,
                          // placeholder: (context, url) => SahaLoadingWidget(
                          //   size: 20,
                          // ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      )
                    : const Center(
                        child: Icon(Icons.camera_alt_outlined),
                      ),
              ),
            ),
          );
  }

  Widget buildItemAsset(File asset) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Theme.of(Get.context!).primaryColor)),
        child: SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.file(
                      asset,
                      fit: BoxFit.cover,
                      width: 300,
                      height: 300,
                    )),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    selectImageController.removeImage();
                    onChange!("");
                  },
                  child: Container(
                    height: 17,
                    width: 17,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: const Center(
                      child: Text(
                        "x",
                        style: TextStyle(
                          fontSize: 10,
                          height: 1,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectLogoImageController extends GetxController {
  var pathImage = "".obs;
  var onUpload = false.obs;
  final picker = ImagePicker();
  var isLoadingAdd = false.obs;
  String type;
  SelectLogoImageController({required this.type});

  Future getImage({Function? onOK, Function? onError}) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var file = File(pickedFile.path);

      final dir = await path_provider.getTemporaryDirectory();
      final targetPath = "${dir.absolute.path}${basename(pickedFile.path)}.jpg";

      var result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path, targetPath,
          quality: 60, minHeight: 512, minWidth: 512);
      onUpload.value = true;
      var link = await upLogo(result);
      onOK!(link);
      pathImage.value = pickedFile.path;
      onUpload.value = false;
    }
  }

  void removeImage() {
    pathImage("");
  }

  Future<String?> upLogo(File? file) async {
    isLoadingAdd.value = true;
    try {
      var link = await RepositoryManager.imageRepository
          .uploadImage(image: file, type: type);
      isLoadingAdd.value = false;
      return link;
    } catch (err) {
      isLoadingAdd.value = false;
      SahaAlert.showError(message: err.toString());
    }
    return null;
  }
}
