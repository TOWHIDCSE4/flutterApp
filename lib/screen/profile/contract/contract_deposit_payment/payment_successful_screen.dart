import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';
import 'package:gohomy/screen/home/home_screen.dart';
import 'package:gohomy/screen/navigator/navigator_screen.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage(ImageAssets.logoBee),
      //     scale: 2,
      //   ),
      //   gradient: const LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: [
      //       Color(0xFFFDC5A5),
      //       Color(0xFFFDF9ED),
      //       Colors.white,
      //       Colors.white,
      //     ],
      //   ),
      // ),
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Image.asset(
                ImageAssets.paymentSuccessful,
                width: Get.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              width: Get.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Yayy~ Bạn đã thanh toán thành công rồi, hãy chờ chủ nhà xác nhận nha ~',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
                      child: Text('Hoàn tất', style: TextStyle(
                        fontSize: 16
                      ),),
                    ),
                    onPressed: () {
                      Get.offAll(() => NavigatorApp());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
