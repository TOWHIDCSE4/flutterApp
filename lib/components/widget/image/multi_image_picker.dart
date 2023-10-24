import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class MultiImagePicker extends StatefulWidget {
  Function onChange;
  MultiImagePicker({Key? key, required this.onChange})
      : super(key: key);

  @override
  State<MultiImagePicker> createState() => _MultiImagePickerState();
}

class _MultiImagePickerState extends State<MultiImagePicker> {
  var controller = MultiImagePickerController(
    maxImages: 9,
    allowedImageTypes: const ['jpg', 'jpeg', 'png'],
  );


  var listImage = RxList<ImageFile>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height:
        listImage.length < 3
            ? Get.width / 3
            : listImage.length <= 5
                ? ((Get.width / 3) * 2)
                : listImage.length == 7
                    ? Get.width
                    : Get.width,
        width: Get.width,
        child: MultiImagePickerView(
          controller: controller,
          padding: const EdgeInsets.all(0),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 170,
              childAspectRatio: 1,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0),
          initialContainerBuilder: (context, pickerCallback) {
            return SizedBox(
              height: 170,
              width: double.infinity,
              child: Center(
                child: ElevatedButton(
                  child: const Text('Thêm ảnh'),
                  onPressed: () {
                    pickerCallback();
                  },
                ),
              ),
            );
          },
          itemBuilder: (context, file, deleteCallback) {
            return ImageCard(file: file, deleteCallback: deleteCallback);
          },
          addMoreBuilder: (context, pickerCallback) {
            return SizedBox(
              height: 170,
              width: double.infinity,
              child: Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.withOpacity(0.2),
                    shape: const CircleBorder(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.add,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  onPressed: () {
                    pickerCallback();
                  },
                ),
              ),
            );
          },
          onChange: (list) {
            widget.onChange(list);

            listImage.value = list.toList();


            print(listImage.length);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({Key? key, required this.file, required this.deleteCallback})
      : super(key: key);

  final ImageFile file;
  final Function(ImageFile file) deleteCallback;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        Positioned.fill(
          child: !file.hasPath
              ? Image.memory(
                  file.bytes!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Text('No Preview'));
                  },
                )
              : Image.file(
                  File(file.path!),
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: InkWell(
            excludeFromSemantics: true,
            onLongPress: () {},
            child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 20,
                )),
            onTap: () {
              deleteCallback(file);
            },
          ),
        ),
      ],
    );
  }
}
