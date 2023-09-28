import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';
import 'package:gohomy/screen/navigator/navigator_screen.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';

import '../deposit_withdraw_page.dart';
import 'widgets/deposit_text_tile.dart';

class DepositSuccessPage extends StatelessWidget {
  const DepositSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.logoBee),
          scale: 2,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFDC5A5),
            Color(0xFFFDF9ED),
            Colors.white,
            Colors.white,
          ],
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
                const Spacer(),
                Image.asset(
                  ImageAssets.tickCircle,
                  height: 80,
                  width: 80,
                ),
                const Text(
                  'Lệnh nạp tiền thành công!',
                  style: TextStyle(
                    color: AppColor.dark0,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                const DepositTextTile(
                  title: 'Dịch vụ',
                  value: 'Nạp tiền',
                ),
                const DepositTextTile(
                  title: 'Số tiền',
                  value: '1.000.000 VNĐ',
                ),
                const DepositTextTile(
                  title: 'Thời gian thực hiện',
                  value: '20 tháng 12, 2022 lúc 12:53',
                ),
                const DepositTextTile(
                  title: 'Mã giao dịch',
                  value: 'F12949FJFKFNYY',
                ),
                const Spacer(),
                CustomButton(
                  title: 'Hoàn thành',
                  onTap: () async {
                    await Future.delayed(Duration.zero, () {
                      Get.offAll(
                        () => NavigatorApp(
                          selectedIndex: 3,
                        ),
                      );
                    });
                    await Future.delayed(Duration.zero, () {
                      Get.to(DepositWithdrawPage());
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
