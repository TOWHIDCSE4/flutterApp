import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../components/text_field/text_field_input_otp.dart';
import '../forgot_controller.dart';

class OtpForgotScreen extends StatelessWidget {
  final formKey3 = GlobalKey<FormState>();

  ForgotController forgotController = Get.find();

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
        title: const Text("Đăng ký"),
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
                  numberPhone: forgotController.textEditingControllerPhone.text,
                  onChanged: (va) {
                    forgotController.otp = va;
                  },
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: forgotController.textEditingControllerNewPass,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Mật khẩu mới phải lớn hơn 6 ký tự';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Mật khẩu',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 15,
                        bottom: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: SahaButtonSizeChild(
                    text: "Hoàn thành",
                    width: 200,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (formKey3.currentState!.validate()) {
                        forgotController.onReset();
                      }
                    },
                  ),
                ),
              ],
            ),
            forgotController.loading.value
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
