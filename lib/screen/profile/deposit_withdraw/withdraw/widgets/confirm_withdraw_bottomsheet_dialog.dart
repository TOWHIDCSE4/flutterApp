import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../withdraw_otp_page.dart';
import 'withdraw_text_tile.dart';

class ConfirmWithdrawBottomSheetDialog extends StatelessWidget {
  ConfirmWithdrawBottomSheetDialog({
    this.bankAccountHolderName,
    this.bankAccountNumber,
    this.bankCode,
    this.withdrawMoney,
    super.key,
  });
  String? bankAccountHolderName;
  String? bankAccountNumber;
  String? bankCode;
  num? withdrawMoney;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Center(
            child: Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                color: AppColor.dark0,
                borderRadius: BorderRadius.circular(112),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                'Xác nhận thông tin rút tiền',
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Text(
            'Tài khoản người nhận',
            style: TextStyle(
              color: AppColor.dark4,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '$bankAccountHolderName',
            style: const TextStyle(
              color: AppColor.dark1,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Số tài khoản $bankAccountNumber',
            style: const TextStyle(
              color: AppColor.dark1,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            SahaStringUtils().convertBankName(bankCode),
            style: const TextStyle(
              color: AppColor.dark1,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          const WithdrawTextTile(
            title: 'Nội dung',
            value: 'Rút tiền Rencity',
            valueFontSize: 14,
          ),
          WithdrawTextTile(
            title: 'Số tiền rút',
            value: withdrawMoney!.toString(),
            valueFontSize: 14,
            valueColor: AppColor.primaryColor,
          ),
          const WithdrawTextTile(
            title: 'Phí giao dịch',
            value: '12.000 VNĐ',
            valueFontSize: 14,
          ),
          CustomButton(
            title: 'Xác nhận',
            radius: 4,
            height: 48,
            bgColor: AppColor.primaryColor,
            onTap: () => Get.to(() => WithdrawOTPEntryPage()),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}