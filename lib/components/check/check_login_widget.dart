import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/data_app_controller.dart';

import '../../screen/login/login_screen.dart';

class CheckLoginWidget extends StatelessWidget {
  DataAppController dataAppController = Get.find();
  final Widget child;

  CheckLoginWidget({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: dataAppController.isLogin.value == false
            ? const LoginScreen(
                hasBack: false,
              )
            : child,
      ),
    );
  }
}
