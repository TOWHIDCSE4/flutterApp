import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../repository/image_repository.dart';
import 'bottomsheet_widget.dart';

class ImagePickerTile extends StatelessWidget {
  const ImagePickerTile({
    super.key,
    required this.onSelectImage,
    required this.child,
  });

  final Function(String?) onSelectImage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          builder: (context) {
            return BottomSheetWidget(
              onPickCamera: () => _openImagePicker(source: ImageSource.camera),
              onPickGallery: () => _openImagePicker(source: ImageSource.gallery),
            );
          },
        );
      },
      child: child,
    );
  }

  ///open Image From Camera or Gallery
  Future<void> _openImagePicker({
    required ImageSource source,
  }) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
    );
    CroppedFile? croppedImageFile = await ImageRepository.instance.cropImage(pickedFile);
    String imagePath = croppedImageFile!.path;
    onSelectImage(imagePath);
    Get.back();
  }
}