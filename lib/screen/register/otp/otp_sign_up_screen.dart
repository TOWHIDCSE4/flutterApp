import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/button/saha_button.dart';
import '../../../components/loading/loading_widget.dart';
import '../../../components/text_field/text_field_input_otp.dart';
import '../../login/login_controller.dart';

class OtpSignUpScreen extends StatelessWidget {
  OtpSignUpScreen({super.key});

  final formKey3 = GlobalKey<FormState>();

  LoginController loginController = Get.find();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text("Đăng nhập"),
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
                  isNotSendOtp: loginController.phoneOrEmailEditingController.text == "0868917689" ? true : false,
                  isCustomer: false,
                  isPhoneValidate: true,
                  numberPhone:
                      loginController.phoneOrEmailEditingController.text,
                  onChanged: (va) {
                    loginController.otp = va;
                  },
                ),
                const SizedBox(height: 15),
                Obx(
                  () => loginController.loadingLogin.value
                      ? SahaLoadingWidget()
                      : Center(
                          child: SahaButtonSizeChild(
                            text: "Hoàn thành",
                            width: 200,
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              if (formKey3.currentState!.validate()) {
                                loginController.loginAccount();
                              }
                            },
                          ),
                        ),
                ),
              ],
            ),
            loginController.signUpping.value
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
