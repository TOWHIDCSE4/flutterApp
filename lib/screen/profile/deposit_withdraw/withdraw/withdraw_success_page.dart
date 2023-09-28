import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';
import 'package:gohomy/screen/navigator/navigator_screen.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';
import 'package:gohomy/utils/date_utils.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../deposit/widgets/deposit_text_tile.dart';
import '../deposit_withdraw_page.dart';
import './withdraw_controller.dart';

class WithdrawSuccessPage extends StatelessWidget {
  WithdrawSuccessPage({
    this.withdrawAmount,
    this.tradingDate,
    this.tradingCode,
    super.key});
  num? withdrawAmount;
  String? tradingDate;
  String? tradingCode;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Spacer(),
                  SizedBox(height: size.height * 0.1),
                  Image.asset(
                    ImageAssets.tickCircle,
                    height: 80,
                    width: 80,
                  ),
                  const Text(
                    'Lệnh rút tiền thành công',
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
                    value: 'Rút tiền',
                  ),
                  DepositTextTile(
                    title: 'Số tiền',
                    value: '${SahaStringUtils().convertToMoney(withdrawAmount ?? 0)} VNĐ',
                  ),
                  DepositTextTile(
                    title: 'Thời gian thực hiện',
                    value: tradingDate ?? "",
                  ),
                  DepositTextTile(
                    title: 'Mã giao dịch',
                    value: tradingCode ?? "",
                  ),
                  // const Spacer(),
                  const Text(
                    'Tiền sẽ được chuyển cho bạn muộn nhất sau 24h\n Nếu chưa nhận được tiền vui lòng liên hệ tổng đài\n Rencity để được xử lý.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColor.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.05),
                  CustomButton(
                    title: 'Hoàn thành',
                    onTap: () {
                      Get.offAll(
                        () => NavigatorApp(
                          selectedIndex: 3,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
