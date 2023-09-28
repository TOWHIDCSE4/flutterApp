import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';
import 'package:gohomy/screen/navigator/navigator_screen.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';

class SuccessProfilePage extends StatelessWidget {
  const SuccessProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFDC5A5), Color(0xFFFDF9ED)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageAssets.tickCircle,
                  height: 60,
                  width: 60,
                ),
                const Text(
                  'Kích hoạt ví Renren thành công! Chúc mừng bạn nhận được 20.000 Xu bạc từ hệ thống',
                  style: TextStyle(
                    color: AppColor.dark0,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                CustomButton(
                  title: 'Quay về Cá nhân',
                  onTap: () {
                    Get.offAll(
                      () => NavigatorApp(
                        selectedIndex: 3,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
