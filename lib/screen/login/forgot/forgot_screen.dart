import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/button/saha_button.dart';
import '../../../components/loading/loading_widget.dart';
import '../../../utils/keyboard.dart';
import '../../../utils/phone_number.dart';
import 'forgot_controller.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  ForgotController forgotController = Get.put(ForgotController());
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lấy lại mật khẩu"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: forgotController.textEditingControllerPhone,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bạn chưa nhập số điện thoại';
                      } else {
                        return PhoneNumberValid.validateMobile(value);
                      }
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Số điện thoại',
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
                const SizedBox(
                  height: 30,
                ),
                SahaButtonSizeChild(
                    width: 200,
                    text: "Tiếp tục",
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        KeyboardUtil.hideKeyboard(context);
                        forgotController.checkHasPhoneNumber();
                      }
                    }),
                const Spacer(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          forgotController.loading.value || forgotController.resting.value
              ? SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: SahaLoadingWidget(),
                )
              : Container()
        ],
      ),
    );
  }
}
