import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';
import 'package:gohomy/screen/navigator/navigator_screen.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../deposit_withdraw_page.dart';
import 'widgets/deposit_text_tile.dart';

class DepositProcessingPage extends StatelessWidget {
   const DepositProcessingPage({this.depositAmount, this.tradingCode, this.tradingDate,super.key});

   final num? depositAmount;
   final String? tradingCode;
   final String? tradingDate;
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
                  ImageAssets.paymentProcessing,
                  height: 80,
                  width: 80,
                ),
                const Text(
                  'Giao dịch đang được xử lý!',
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
                DepositTextTile(
                  title: 'Số tiền',
                  value: '${SahaStringUtils().convertToMoney(depositAmount ?? 0)} VNĐ',
                ),
                DepositTextTile(
                  title: 'Thời gian thực hiện',
                  value: tradingDate ?? '',
                ),
                DepositTextTile(
                  title: 'Mã giao dịch',
                  value: tradingCode ?? '',
                ),
                const Spacer(),
                CustomButton(
                  title: 'Quay lại trang chủ',
                  onTap: ()  {
                      Get.to(
                            () => NavigatorApp(
                          selectedIndex: 0,
                        ),
                      );
                    }
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
