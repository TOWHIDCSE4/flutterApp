import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/withdraw/widgets/custom_withdraw_appbar.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';

import 'manage_account_otp_success_page.dart';
import 'widgets/otp_digit_textfieldbox.dart';

class ManageAccountOTPPage extends StatefulWidget {
  const ManageAccountOTPPage({super.key});

  @override
  State<ManageAccountOTPPage> createState() => _ManageAccountOTPPageState();
}

class _ManageAccountOTPPageState extends State<ManageAccountOTPPage> {
  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomWithdrawAppBar(
        title: 'Xác thực',
        isEnableTrailing: true,
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Mã xác thực của bạn đã được gửi tới số \nđiện thoại (+84) 912 345 678',
                      style: TextStyle(
                        color: AppColor.dark3,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      'Vui lòng nhập mã xác thực',
                      style: TextStyle(
                        color: AppColor.dark4,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OTPDigitTextFieldBox(
                          first: true,
                          last: false,
                          forward: addToOtp,
                          backward: removeFromOtp,
                        ),
                      ),
                      Expanded(
                        child: OTPDigitTextFieldBox(
                          first: false,
                          last: false,
                          forward: addToOtp,
                          backward: removeFromOtp,
                        ),
                      ),
                      Expanded(
                        child: OTPDigitTextFieldBox(
                          first: false,
                          last: false,
                          forward: addToOtp,
                          backward: removeFromOtp,
                        ),
                      ),
                      Expanded(
                        child: OTPDigitTextFieldBox(
                          first: false,
                          last: false,
                          forward: addToOtp,
                          backward: removeFromOtp,
                        ),
                      ),
                      Expanded(
                        child: OTPDigitTextFieldBox(
                          first: false,
                          last: false,
                          forward: addToOtp,
                          backward: removeFromOtp,
                        ),
                      ),
                      Expanded(
                        child: OTPDigitTextFieldBox(
                          first: false,
                          last: true,
                          forward: addToOtp,
                          backward: removeFromOtp,
                        ),
                      ),
                    ],
                  ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Gửi lại mã sau: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.dark7,
                                ),
                              ),
                              TextSpan(
                                text: '30s',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.dark2,
                                ),
                              ),
                            ],
                          ),
                        ),
                    )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: MediaQuery.of(context).viewInsets.vertical > 0
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  title: 'Tiếp tục',
                  radius: 4,
                  height: 48,
                  bgColor: otp.length == 6 ? AppColor.primaryColor : AppColor.light3,
                  onTap: () {
                    log('OTP: $otp');
                    if (otp.length == 6) {
                      Get.to(const ManageAccountOTPSuccessPage());
                    }
                  },
                ),
              )
            : null,
      ),
    );
  }

  void addToOtp(value) {
    setState(() {
      otp = otp + value;
    });
  }

  void removeFromOtp(value) {
    setState(() {
      otp = otp.substring(0, otp.length - 1);
    });
  }
}