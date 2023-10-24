import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../components/arlert/saha_alert.dart';
import '../../data/firebase/load_firebase.dart';
import '../../data/repository/repository_manager.dart';
import '../../utils/user_info.dart';
import '../data_app_controller.dart';
import '../navigator/navigator_screen.dart';
import '../profile/choose_type_user/choose_type_user_screen.dart';
import 'otp/otp_register_screen.dart';

class RegisterController extends GetxController {
  var isObscure = true.obs;
  var stateSignUp = "".obs;
  var signUpping = false.obs;
  var shopPhones = "".obs;

  String? facebookId;

  var otp = "";
  DataAppController dataAppController = Get.find();

  TextEditingController textEditingControllerPass = TextEditingController();
  TextEditingController textEditingControllerPhone = TextEditingController();
  TextEditingController textEditingControllerName = TextEditingController();
  var referralCode = TextEditingController();

  RegisterController({this.facebookId}) {
    print(facebookId);
  }

  Future<void> checkHasPhoneNumber() async {
    try {
      var data = await RepositoryManager.accountRepository.checkExists(
          emailOrPhoneNumber: textEditingControllerPhone.text,
          referralCode: referralCode.text,
          type: 0);
      Get.to(() => OtpRegisterScreen());
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> onSignUp() async {
    signUpping.value = true;
    try {
      print(textEditingControllerPass.text);
      print(textEditingControllerName.text);
      print(textEditingControllerPhone.text);

      var dataRegister = await RepositoryManager.accountRepository.register(
          // password: textEditingControllerPass.text,
          name: textEditingControllerName.text,
          phone: textEditingControllerPhone.text,
          otp: otp,
          referralCode: referralCode.text);

      loginAccount(
        textEditingControllerPhone.text,
      );
      SahaAlert.showSuccess(message: "Đăng ký thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    signUpping.value = false;
  }

  Future<void> loginAccount(String phone) async {
    try {
      var res =
          await RepositoryManager.accountRepository.login(phone, otp, true);
      await UserInfo().setToken(res!.data!.token);
    await FCMMess().initToken();
      await dataAppController.getBadge();
      if (dataAppController.badge.value.user?.isHost == null) {
        Get.to(() => ChooseTypeUserScreen())!
            .then((value) => UserInfo().logout());
        return;
      } else {
        Get.offAll(() => NavigatorApp());
        dataAppController.isLogin.value = true;
        print('===============${dataAppController.isLogin.value}');
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
