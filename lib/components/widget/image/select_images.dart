import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/widget/image/show_image.dart';
import '../../../model/image_assset.dart';
import '../../empty/saha_empty_image.dart';
import '../../loading/loading_widget.dart';
import 'select_images_controller.dart';

// ignore: must_be_immutable
class SelectImages extends StatelessWidget {
  String title;
  String subTitle;
  Function? onUpload;
  Function? doneUpload;
  int maxImage;
  final List<ImageData>? images;

  String type;
  late SelectImageController selectImageController;
  SelectImages(
      {this.onUpload,
      this.doneUpload,
      this.images,
      required this.type,
      required this.maxImage,
      required this.title,
      required this.subTitle}) {
    selectImageController = SelectImageController(
        onUpload: onUpload,
        doneUpload: doneUpload,
        type: type,
        maxImage: maxImage);

    if (images != null) {
      selectImageController.dataImages.value = images!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Obx(() {
        var dataImages = selectImageController.dataImages.toList();

        if (dataImages.isEmpty) {
          return Row(
            children: [
              addImage(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          subTitle,
                          style: const TextStyle(
                              color: Colors.grey, fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        }

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataImages.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  buildItemImageData(dataImages[index]),
                  index == dataImages.length - 1 &&
                          dataImages.length < MAX_SELECT
                      ? addImage()
                      : Container()
                ],
              );
            });
      }),
    );
  }

  Widget addImage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          print('abc');
          selectImageController.loadAssets();
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: Theme.of(Get.context!).primaryColor)),
          child: Center(
            child: Icon(
              Icons.camera_alt_outlined,
              color: Theme.of(Get.context!).primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Theme.of(Get.context!).primaryColor)),
        height: 100,
        width: 100,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  height: 95,
                  width: 95,
                  fit: BoxFit.cover,
                  imageUrl: "",
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const SahaEmptyImage(),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
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
            )
          ],
        ),
      ),
    );
  }

  Widget buildItemImageData(ImageData imageData) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.only(right: 5),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Stack(
          alignment: Alignment.bottomLeft,
          clipBehavior: Clip.none,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: imageData.linkImage != null
                    ? InkWell(
                        onTap: () {
                          ShowImage.seeImage(
                              listImageUrl: [imageData.linkImage!], index: 0);
                        },
                        child: CachedNetworkImage(
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                          imageUrl: imageData.linkImage!,
                          placeholder: (context, url) => Stack(
                            children: [
                              imageData.file == null
                                  ? Container()
                                  : Image.file(
                                      File(imageData.file!.path),
                                      width: 300,
                                      height: 300,
                                    ),
                              SahaLoadingWidget(),
                            ],
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )
                    : imageData.file == null
                        ? const SahaEmptyImage()
                        : Image.file(
                            File(imageData.file!.path),
                            width: 300,
                            height: 300,
                          ),
              ),
            ),
            Positioned(
              top: -5,
              right: -5,
              child: InkWell(
                onTap: () {
                  selectImageController.deleteImage(imageData);
                },
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: const Center(
                    child: Text(
                      "x",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            (imageData.uploading ?? false)
                ? SahaLoadingWidget(
                    size: 50,
                  )
                : Container(),
            (imageData.errorUpload ?? false)
                ? const Icon(
                    Icons.error,
                    color: Colors.redAccent,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
