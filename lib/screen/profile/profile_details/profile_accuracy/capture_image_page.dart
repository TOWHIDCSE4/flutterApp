import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';
import 'package:gohomy/screen/profile/profile_details/widget/image_picker_tile.dart';

import '../controller/registration_controller.dart';
import 'capture_data_page.dart';
import 'widgets/card_verification_tile.dart';

class CaptureImagePage extends StatelessWidget {
  const CaptureImagePage({super.key});

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
            title: "xác minh khuôn mặt",
            instruction: "Xin đưa mặt của bạn vào trước khung hình!",
            imgPath: ImageAssets.imgCaptureImage,
            // onTapContinue: () => Get.to(const CaptureDataPage()),
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
              onSelectImage: (imagePath) {
                log(imagePath.toString());
                registrationController.profileImagePath.value = imagePath!;
                registrationController.getAllValuesForRegistration();
                Future.delayed(Duration.zero, () {
                  Get.to(const CaptureDataPage());
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
