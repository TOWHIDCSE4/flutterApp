import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';

import '../controller/registration_controller.dart';
import 'front_card_verification_page.dart';
import '../widget/custom_button.dart';
import 'widgets/selected_item_tile.dart';

class ProfileAccuracyPage extends StatefulWidget {
  const ProfileAccuracyPage({super.key});

  @override
  State<ProfileAccuracyPage> createState() => _ProfileAccuracyPageState();
}

class _ProfileAccuracyPageState extends State<ProfileAccuracyPage> {
  RegistrationController registrationController = Get.put(RegistrationController());
  int sValue = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: const Text('Cập nhật thông tin định danh'),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Center(
            child: Text(
              'Bạn vui lòng lựa chọn loại giấy tờ tùy thân.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: SizedBox(
                height: 50,
                child: RadioListTile<int>(
                  title: Text(
                    "Chứng minh thư nhân dân",
                    style: TextStyle(
                      color: sValue == 1
                          ? const Color(0xFF664B00)
                          : const Color(0xFF666666),
                      fontSize: 14,
                      fontWeight:
                          sValue == 1 ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  value: 1,
                  groupValue: sValue,
                  onChanged: (value) {
                    setState(() {
                      sValue = value!;
                    });
                    registrationController.idType.value = IdCardType.peopleID;
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: SizedBox(
                height: 50,
                child: RadioListTile<int>(
                  title: Text(
                    "Căn cước công dân",
                    style: TextStyle(
                      color: sValue == 2
                          ? const Color(0xFF664B00)
                          : const Color(0xFF666666),
                      fontSize: 14,
                      fontWeight:
                          sValue == 2 ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  value: 2,
                  groupValue: sValue,
                  onChanged: (value) {
                    setState(() {
                      sValue = value!;
                    });
                    registrationController.idType.value = IdCardType.citizenId;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SelectedItemTile(
                        iconPath: ImageAssets.icTick,
                        title: 'Sử dụng giấy tờ gốc, nguyên vẹn và còn hiệu lực',
                      ),
                      SelectedItemTile(
                        iconPath: ImageAssets.icTick,
                        title: 'Đảm bảo môi trường chụp đủ ánh sáng',
                      ),
                      SelectedItemTile(
                        iconPath: ImageAssets.icCross,
                        title: 'Không chụp lóe sáng',
                      ),
                      SelectedItemTile(
                        iconPath: ImageAssets.icCross,
                        title: 'Không chụp mất góc',
                      ),
                      SelectedItemTile(
                        iconPath: ImageAssets.icCross,
                        title: 'Không chụp bị che khuất',
                      ),
                      Image.asset(
                        ImageAssets.imgCard,
                        scale: 3,
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        title: 'Tiếp tục',
                        width: size.width * 0.6,
                        bgColor: AppColor.primaryColor,
                        radius: 10,
                        onTap: () => Get.to(() => const FrontCardVerificationPage()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

