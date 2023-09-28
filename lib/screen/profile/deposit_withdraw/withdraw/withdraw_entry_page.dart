import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';

import '../widget/custom_entry_textfield.dart';
import '../widget/tranaction_type.dart';
import 'choose_bank_page.dart';
import './withdraw_controller.dart';

class WithdrawEntryPage extends StatefulWidget {
  late WithdrawController withdrawController;

  WithdrawEntryPage({super.key}) {
    withdrawController = Get.put(WithdrawController());
    withdrawController.getListBankUser(isRefresh: true);
  }

  @override
  State<WithdrawEntryPage> createState() => _WithdrawEntryPageState();
}

class _WithdrawEntryPageState extends State<WithdrawEntryPage> {
  bool isTyping = false;
  num currentBalance =
      Get.find<DataAppController>().currentUser.value.goldenCoins ?? 0;

  @override
  void dispose() {
    widget.withdrawController.withdrawValue.dispose();
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
          'Rút tiền',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Nhập số tiền cần rút',
                          style: TextStyle(
                            color: AppColor.dark2,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.withdrawController.withdrawValue.text =
                                  currentBalance.toString();
                              isTyping = true;
                            });
                          },
                          child: const Text(
                            'Tất cả',
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomEntryTextField(
                      controller: widget.withdrawController.withdrawValue,
                      isTyping: isTyping,
                      hintText: 'Tối thiểu 50.000',
                      transactionType: TransactionType.withdraw,
                      onChanged: (text) {
                        setState(() {
                          isTyping = text.isNotEmpty;
                        });
                      },
                      onRemove: () {
                        widget.withdrawController.withdrawValue.clear();
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
                          'Số dư khả dụng',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.dark5,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          currentBalance.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.dark4,
                          ),
                        ),
                      ],
                    ),
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
              bgColor: isTyping ? AppColor.primaryColor : AppColor.light3,
              onTap: () {
                if (int.parse(
                        widget.withdrawController.withdrawValue.value.text) <
                    50000) {
                  SahaAlert.showError(message: "Số tiền tối thiểu là 50.000");
                  return;
                }
                if (int.parse(
                        widget.withdrawController.withdrawValue.value.text) >
                    currentBalance) {
                  SahaAlert.showError(message: "Số dư không đủ để thực hiện");
                  return;
                }
                Get.to(() => ChooseBankPage());
              },
            ),
          )),
    );
  }
}
