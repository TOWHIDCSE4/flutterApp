import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/withdraw/choose_bank_page.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/withdraw/widgets/custom_withdraw_appbar.dart';
import 'package:gohomy/screen/profile/profile_details/personal_information/widgets/custom_textfiield.dart';
import 'package:gohomy/screen/profile/profile_details/personal_information/widgets/text_field_title.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';
import 'package:gohomy/utils/string_utils.dart';
import './withdraw_controller.dart';


class ManageAccountPage extends StatefulWidget {
  ManageAccountPage({super.key});

  @override
  State<ManageAccountPage> createState() => _ManageAccountPageState();
}

class _ManageAccountPageState extends State<ManageAccountPage> {
  WithdrawController withdrawController = Get.find<WithdrawController>();
  TextEditingController bank = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: const CustomWithdrawAppBar(
        title: 'Quản lý tài khoản nhận tiền',
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextFieldTextTitle(title: 'Ngân hàng'),
                CustomTextFiled(
                  textEditingController: bank,
                  hintText: SahaStringUtils().convertBankName(withdrawController.bankCode.value.text),
                  backgroungColor: AppColor.light2,
                  enabled: false,
                ),
                const TextFieldTextTitle(title: 'Số tài khoản'),
                CustomTextFiled(
                  textEditingController: withdrawController.bankAccountNumber,
                  hintText: 'Số tài khoản',
                  keyboardType: TextInputType.number,
                ),
                const TextFieldTextTitle(title: 'Chủ tài khoản'),
                CustomTextFiled(
                  textEditingController: withdrawController.bankAccountHolderName,
                  hintText: 'Chủ tài khoản',
                ),
                SizedBox(height: size.height * 0.25),
                CustomButton(
                  title: 'Tiếp tục',
                  bgColor: AppColor.primaryColor,
                  // width: size.width * 0.85,
                  onTap: () async {
                    await withdrawController.addBankInfo();
                    Get.to(() => ChooseBankPage());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
