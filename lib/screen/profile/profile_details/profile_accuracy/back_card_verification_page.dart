import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';
import 'package:gohomy/screen/profile/profile_details/widget/image_picker_tile.dart';

import '../controller/registration_controller.dart';
import '../repository/image_repository.dart';
import '../widget/custom_button.dart';
import 'capture_image_page.dart';
import 'widgets/card_verification_tile.dart';

class BackCardVerificationPage extends StatelessWidget {
  const BackCardVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RegistrationController registrationController = Get.put(RegistrationController());
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        iconTheme: const IconThemeData(
          color: AppColor.dark5,
        ),
        elevation: 0,
        title: const Text(
          "Chụp ảnh xác minh",
          style: TextStyle(color: AppColor.dark5),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CardVerificationTile(
            title: "mặt sau CMND/CCCD",
            instruction: "Xin đưa mặt sau của CMND/CCCD vào khung hình, hệ thống sẽ chụp tự động",
            imgPath: ImageAssets.imgBackCard,
            // onTapContinue: () => Get.to(const CaptureImagePage()),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: ImagePickerTile(
              child: CustomButton(
                title: 'Tiếp tục',
                width: size.width * 0.6,
                radius: 10,
              ),
              onSelectImage: (imagePath) async {
                log(imagePath.toString());
                registrationController.backCardImagePath.value = imagePath!;
                String recognizedText = await ImageRepository.instance
                    .convertImageToText(imagePath: imagePath);
                log(recognizedText);
                registrationController.scannedBackCardText.value = recognizedText;
                Future.delayed(Duration.zero, () {
                  Get.to(() => const CaptureImagePage());
                });
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
