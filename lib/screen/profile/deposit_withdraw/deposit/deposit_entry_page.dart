import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';

import 'widgets/confirm_deposit_bottomsheet_dialog.dart';
import '../widget/custom_entry_textfield.dart';
import './deposit_controller.dart';

class DepositEntryPage extends StatefulWidget {
  const DepositEntryPage({super.key});

  @override
  State<DepositEntryPage> createState() => _DepositEntryPageState();
}

class _DepositEntryPageState extends State<DepositEntryPage> {
  DepositController depositController = DepositController();
  bool isTyping = false;

  @override
  void dispose() {
    depositController.depositValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: Get.back,
        ),
        title: const Text(
          'Nạp tiền',
          style: TextStyle(color: Color(0xFF1A1A1A)),
        ),
        centerTitle: true,
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const Divider(color: AppColor.dark5),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nhập số tiền nạp',
                    style: TextStyle(
                      color: AppColor.dark2,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomEntryTextField(
                    controller: depositController.depositValue,
                    isTyping: isTyping,
                    onChanged: (text) {
                      setState(() {
                        isTyping = text.isNotEmpty;
                      });
                    },
                    onRemove: () {
                      depositController.depositValue.clear();
                      setState(() {
                        isTyping = false;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '1.000 VNĐ = 1.000',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.dark5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Image.asset(
                        ImageAssets.goldCoin,
                        height: 14,
                        width: 14,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar:
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  title: 'Tiếp tục',
                  radius: 4,
                  height: 48,
                  bgColor: isTyping || depositController.isLoading ? AppColor.primaryColor : AppColor.light3,
                  isLoading: depositController.isLoading,
                  onTap: () async {
                    if (isTyping) {
                      if(int.parse(depositController.depositValue.value.text) < 50000) {
                        SahaAlert.showError(message: "Số tiền tối thiểu là 50.000");
                        return;
                      }
                      var res = await depositController.createDepositRequest();
                      if(res != null && context.mounted) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          builder: (context) {
                            return ConfirmDepositBottomSheetDialog(
                              bankAccountName: res.bankAccountHolderName,
                              bankCode: res.bankName,
                              bankNumber: res.accountNumber,
                              depositAmount: res.depositAmount,
                              tradingCode: res.tradingCode,
                              tradingDate: res.depositDate,
                              qrCode: res.qrCodeUrl ?? '',
                            );
                          },
                        );
                      }

                    }
                  },
                ),
              )
      ),
    );
  }
}
