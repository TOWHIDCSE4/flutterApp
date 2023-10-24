import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/text_field/text_field_input_otp.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/model/withdraw.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/withdraw/widgets/custom_withdraw_appbar.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/withdraw/withdraw_controller.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';

import 'widgets/otp_digit_textfieldbox.dart';
import 'withdraw_success_page.dart';

class WithdrawOTPEntryPage extends StatefulWidget {
  WithdrawOTPEntryPage({super.key});

  @override
  State<WithdrawOTPEntryPage> createState() => _WithdrawOTPEntryPageState();
}

class _WithdrawOTPEntryPageState extends State<WithdrawOTPEntryPage> {
  WithdrawController withdrawController = Get.find<WithdrawController>();

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
                  // const Center(
                  //   child: Text(
                  //     'Mã xác thực của bạn đã được gửi tới số \nđiện thoại (+84) 912 345 678',
                  //     style: TextStyle(
                  //       color: AppColor.dark3,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w400,
                  //     ),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  // const SizedBox(height: 24),
                  // const Center(
                  //   child: Text(
                  //     'Vui lòng nhập mã xác thực',
                  //     style: TextStyle(
                  //       color: AppColor.dark4,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  // const SizedBox(height: 16),
                  TextFieldInputOtp(
                    isPhoneValidate: true,
                    isCustomer: true,
                    isNotSendOtp: false,
                    numberPhone: Get.find<DataAppController>()
                        .currentUser
                        .value
                        .phoneNumber,
                    onChanged: (value) {
                      withdrawController.otp.text = value;
                    },
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: RichText(
                  //     text: const TextSpan(
                  //       children: [
                  //         TextSpan(
                  //           text: 'Gửi lại mã sau: ',
                  //           style: TextStyle(
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w400,
                  //             color: AppColor.dark7,
                  //           ),
                  //         ),
                  //         TextSpan(
                  //           text: '30s',
                  //           style: TextStyle(
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w600,
                  //             color: AppColor.dark2,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  title: 'Tiếp tục',
                  radius: 4,
                  height: 48,
                  bgColor: withdrawController.otp.value.text.length == 6
                      ? AppColor.primaryColor
                      : AppColor.light3,
                  onTap: () async {
                    if (withdrawController.otp.value.text.length == 6) {
                      Withdraw? res = await withdrawController.createWithdrawRequest();
                      if(res != null) {
                        Get.to(() => WithdrawSuccessPage(
                          withdrawAmount: res.withdrawAmount,
                          tradingCode: res.tradingCode,
                          tradingDate: res.withdrawDate,
                        ));
                      }
                    }
                  },
                ),
              )
      ),
    );
  }
}
