import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../../../../model/bank.dart';
import 'add_bank_account_page.dart';
import 'edit_bank_page.dart';
import 'widgets/bank_info_card_tile.dart';
import 'widgets/confirm_withdraw_bottomsheet_dialog.dart';
import 'widgets/custom_withdraw_appbar.dart';
import './withdraw_controller.dart';

class ChooseBankPage extends StatefulWidget {
  late WithdrawController withdrawController;

  ChooseBankPage({super.key}) {
    withdrawController = Get.find<WithdrawController>();
  }

  @override
  State<ChooseBankPage> createState() => _ChooseBankPageState();
}

class _ChooseBankPageState extends State<ChooseBankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: const CustomWithdrawAppBar(
        title: 'Chọn ngân hàng',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Đã lưu',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.dark6,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.to(const AddBankAccountPage()),
                  icon: const Icon(
                    Icons.add,
                    size: 32,
                    color: Color(0xFF404040),
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemCount: widget.withdrawController.listBank.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                BankInfo? bankInfo = widget.withdrawController.listBank[index];
                print(bankInfo.id);
                return BankInfoCardTile(
                  imgPath: ImageAssets.icBank1,
                  bankName: bankInfo.bankCode,
                  bankFullName:
                      SahaStringUtils().convertBankName(bankInfo.bankCode),
                  accountNumber: 'Số tài khoản - ${bankInfo.bankAccountNumber}',
                  accountHolder:
                      'Chủ tài khoản - ${bankInfo.bankAccountHolderName}',
                  onTapBank: () {
                    widget.withdrawController.bankCode.text =
                        bankInfo.bankCode ?? "";
                    widget.withdrawController.bankAccountNumber.text =
                        bankInfo.bankAccountNumber ?? "";
                    widget.withdrawController.bankAccountHolderName.text =
                        bankInfo.bankAccountHolderName ?? "";
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      builder: (context) {
                        return ConfirmWithdrawBottomSheetDialog(
                          bankCode: bankInfo.bankCode,
                          bankAccountHolderName: bankInfo.bankAccountHolderName,
                          bankAccountNumber: bankInfo.bankAccountNumber,
                          withdrawMoney: int.parse(widget
                              .withdrawController.withdrawValue.value.text),
                        );
                      },
                    );
                  },
                  onTapEdit: () => Get.to(const EditBankPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
