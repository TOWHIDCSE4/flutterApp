import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/deposit/deposit_processing_page.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../deposit_success_page.dart';
import 'deposit_text_tile.dart';

class ConfirmDepositBottomSheetDialog extends StatefulWidget {
  String? bankAccountName;
  String? bankCode;
  String? bankNumber;
  int? depositAmount;
  String? tradingCode;
  String? qrCode;
  String? tradingDate;

  ConfirmDepositBottomSheetDialog(
      {super.key,
      this.bankAccountName,
      this.bankCode,
      this.bankNumber,
      this.depositAmount,
      this.tradingCode,
        this.tradingDate,
      this.qrCode});

  @override
  State<ConfirmDepositBottomSheetDialog> createState() =>
      _ConfirmDepositBottomSheetDialogState();

  Future<void> copyText(text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      SahaAlert.showSuccess(message: "Sao chép thành công");
    } catch (error) {
      SahaAlert.showError(message: "Sao chép thất bại");
    }
  }
}

class _ConfirmDepositBottomSheetDialogState
    extends State<ConfirmDepositBottomSheetDialog> {
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
                'Xác nhận thông tin nạp tiền',
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Text(
            'Tài khoản người nhận:',
            style: TextStyle(
              color: AppColor.dark4,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${widget.bankAccountName}',
                  style: const TextStyle(
                    color: AppColor.dark1,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // const SizedBox(width: 20),

              Padding(
                  padding: const EdgeInsets.all(0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      widget.copyText(widget.bankNumber);
                    },
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.copy,
                        color: AppColor.dark6,
                        size: 16,
                      ),
                    ),
                    label: const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Text(
                        'Sao chép',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.dark5,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.light1,
                      padding: const EdgeInsets.all(3),
                      shadowColor: Colors.transparent
                    ),
                  )),
            ],
          ),
          Text(
            'Số tài khoản: ${widget.bankNumber}',
            style: const TextStyle(
              color: AppColor.dark1,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '${SahaStringUtils().convertBankName(widget.bankCode)}',
            style: const TextStyle(
              color: AppColor.dark1,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Nội dung:',
            style: TextStyle(
              color: AppColor.dark1,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            children: [
               Expanded(
                child: Text(
                  '${widget.tradingCode}',
                  style: const TextStyle(
                    color: AppColor.dark1,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      widget.copyText(widget.tradingCode);
                    },
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.copy,
                        color: AppColor.dark6,
                        size: 16,
                      ),
                    ),
                    label: const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Text(
                        'Sao chép',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.dark5,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.light1,
                        padding: const EdgeInsets.all(3),
                        shadowColor: Colors.transparent
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DepositTextTile(
                    title: 'Số tiền nạp',
                    value:
                        SahaStringUtils().convertToMoney(widget.depositAmount),
                    valueFontSize: 14,
                    valueColor: AppColor.primaryColor,
                  ),
                  DepositTextTile(
                    title: 'Mã giao dịch',
                    value: widget.tradingCode!,
                    valueFontSize: 14,
                  ),
                ],
              ),
              GestureDetector(
                  onTap: () {
                    SahaDialogApp.showQRCodePopup(
                        imageLink: '${widget.qrCode}');
                  },
                  child: Image.network(
                    '${widget.qrCode}',
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ))
            ],
          ),
          CustomButton(
            title: 'Xác nhận đã thanh toán',
            radius: 4,
            height: 48,
            bgColor: AppColor.primaryColor,
            onTap: () {
              Get.to(() => DepositProcessingPage(
                depositAmount: widget.depositAmount,
                tradingDate: widget.tradingDate,
                tradingCode: widget.tradingCode,
              ));
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
