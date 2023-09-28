import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/withdraw/widgets/custom_withdraw_appbar.dart';
import 'package:gohomy/screen/profile/profile_details/personal_information/widgets/custom_textfiield.dart';
import 'package:gohomy/screen/profile/profile_details/personal_information/widgets/text_field_title.dart';
import 'package:gohomy/screen/profile/profile_details/profile_details_page.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';

class EditBankPage extends StatefulWidget {
  const EditBankPage({super.key});

  @override
  State<EditBankPage> createState() => _EditBankPageState();
}

class _EditBankPageState extends State<EditBankPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: const CustomWithdrawAppBar(
        title: 'Chỉnh sửa thông tin ngân hàng',
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
                  textEditingController: phoneController,
                  hintText: 'Vietcombank - Ngân hàng TMCP Ngoại thương',
                  backgroungColor: AppColor.light2,
                ),
                const TextFieldTextTitle(title: 'Số tài khoản'),
                CustomTextFiled(
                  textEditingController: emailController,
                  hintText: '10335665233',
                  keyboardType: TextInputType.number,
                ),
                const TextFieldTextTitle(title: 'Chủ tài khoản'),
                CustomTextFiled(
                  textEditingController: jobController,
                  hintText: 'VŨ ANH TÙNG',
                ),
                SizedBox(height: size.height * 0.25),
                CustomButton(
                  title: 'Cập nhật',
                  bgColor: AppColor.primaryColor,
                  // width: size.width * 0.85,
                  onTap: () => Get.back(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
