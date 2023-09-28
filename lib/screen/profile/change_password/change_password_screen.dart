import 'package:flutter/material.dart';
import '../../../components/button/saha_button.dart';
import '../../../components/text_field/sahashopTextField.dart';
import '../../../utils/keyboard.dart';
import 'change_password_controller.dart';

class ChangePassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  ChangePasswordController changePasswordController =
      ChangePasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thay đổi mật khẩu"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SahaTextField(
              controller: changePasswordController.textEditingControllerOldPass,
              onChanged: (value) {},
              autoFocus: true,
              maxLines: 1,
              validator: (value) {
                return null;
              },
              textInputType: TextInputType.text,
              obscureText: true,
              withAsterisk: true,
              labelText: "Mật khẩu cũ",
              hintText: "Nhập mật khẩu cũ",
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),
            SahaTextField(
              maxLines: 1,
              controller: changePasswordController.textEditingControllerNewPass,
              onChanged: (value) {},
              autoFocus: true,
              validator: (value) {
                if (value!.length < 6) {
                  return 'Mật khẩu phải từ 6 ký tự';
                }
                return null;
              },
              textInputType: TextInputType.text,
              obscureText: true,
              withAsterisk: true,
              labelText: "Mật khẩu mới",
              hintText: "Nhập mật khẩu mới",
            ),
            SahaButtonSizeChild(
                width: 200,
                text: "Thay đổi",
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    KeyboardUtil.hideKeyboard(context);
                    changePasswordController.onChange();
                  }
                }),
            const Spacer(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
