import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/user_login.dart';
import 'package:hive/hive.dart';
import '../../components/arlert/saha_alert.dart';
import '../../data/firebase/load_firebase.dart';
import '../../data/repository/repository_manager.dart';
import '../../model/user.dart';
import '../../utils/user_info.dart';
import '../data_app_controller.dart';
import '../navigator/navigator_screen.dart';
import '../register/otp/otp_register_screen.dart';
import '../register/otp/otp_sign_up_screen.dart';

class LoginController extends GetxController {
  var isHidePassword = true.obs;
  var phoneOrEmailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  DataAppController dataAppController = Get.find();
  var isObscure = true.obs;
  bool? isOff;
  var loadingLogin = false.obs;
  var otp = '';
  var signUpping = false.obs;
  LoginController({this.isOff}) {
    getUserLogin();
  }

  Future<void> loginAccount() async {
  loadingLogin.value = true;
    try {
      var res = await RepositoryManager.accountRepository
          .login(phoneOrEmailEditingController.text, otp, true);
      await UserInfo().setToken(res!.data!.token);
      await FCMMess().initToken();
      dataAppController.isLogin.value = true;
      await dataAppController.getBadge();
      Get.offAll(() => NavigatorApp());
      addUserLogin(res.data!.user!, res.data!.token!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }

    loadingLogin.value = false;
  }

  Future<void> addUserLogin(User user, String token) async {
    var box = await Hive.openBox('USER_LOGIN');
    var index = listUserLogin.map((e) => e.id).toList().indexOf(user.id);

    if (index != -1) {
      if (listUserLogin[index].token != token) {
        box.add(UserLogin(
            id: user.id,
            name: user.name,
            phone: user.phoneNumber,
            email: user.email,
            avatar: user.avatarImage,
            token: token,
            isHost: user.isHost,
            isAdmin: user.isAdmin
            ));
      }
    } else {
      box.add(UserLogin(
          id: user.id,
          name: user.name,
          phone: user.phoneNumber,
          email: user.email,
          avatar: user.avatarImage,
          token: token,
          isHost: user.isHost,
          isAdmin: user.isAdmin
          ));
    }

    Get.find<DataAppController>().getUserLogin(refresh: true);
  }

  var listUserLogin = RxList<UserLogin>();

  void getUserLogin() async {
    var box = await Hive.openBox('USER_LOGIN');
    print(box.values);
    for (var element in box.values) {
      listUserLogin.add(element);
    }
  }

  Future<void> checkHasPhoneNumber() async {
    try {
      var data = await RepositoryManager.accountRepository.checkExists(
          emailOrPhoneNumber: phoneOrEmailEditingController.text, type: 1);
      Get.to(() => OtpSignUpScreen());
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
