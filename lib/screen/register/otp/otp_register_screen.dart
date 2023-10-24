import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/button/saha_button.dart';
import '../../../components/loading/loading_widget.dart';
import '../../../components/text_field/text_field_input_otp.dart';
import '../../login/login_controller.dart';
import '../register_controller.dart';

class OtpRegisterScreen extends StatelessWidget {
  final formKey3 = GlobalKey<FormState>();

  OtpRegisterScreen() {}

  RegisterController registerController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Đăng ký"),
      ),
      body: Form(
        key: formKey3,
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFieldInputOtp(
                  email: "",
                  isCustomer: false,
                  isPhoneValidate: true,
                  numberPhone:
                      registerController.textEditingControllerPhone.text,
                  onChanged: (va) {
                    registerController.otp = va;
                  },
                ),
                const SizedBox(height: 15),
                Center(
                  child: SahaButtonSizeChild(
                    text: "Hoàn thành",
                    width: 200,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (formKey3.currentState!.validate()) {
                        registerController.onSignUp();
                      }
                    },
                  ),
                ),
              ],
            ),
            registerController.signUpping.value
                ? SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Center(
                      child: SahaLoadingWidget(),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
