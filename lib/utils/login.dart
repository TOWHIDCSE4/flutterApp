import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/utils/user_info.dart';
import 'package:hive/hive.dart';
import '../data/firebase/load_firebase.dart';
import '../model/user.dart';
import '../model/user_login.dart';
import '../screen/navigator/navigator_screen.dart';
import '../screen/profile/choose_type_user/choose_type_user_screen.dart';
import '../screen/profile/update_phone/update_phone_screen.dart';

class LoginUtil {
  static Future<void> login(String? token) async {
    if (token == null) {
      SahaAlert.showError(message: 'Không thể đăng nhập');
      return;
    }
    await UserInfo().setToken(token);
    await FCMMess().initToken();
    // RepositoryManager.notificationRepository
    //     .sendDeviceToken(token: FCMToken().getToken() ?? '');
    Get.find<DataAppController>().getBadge().then((value) {
      if (Get.find<DataAppController>().badge.value.user?.phoneNumber == null) {
        Get.to(() => UpdatePhoneScreen())!
            .then((value) => {UserInfo().logout()});
      } else {
        Get.find<DataAppController>().isLogin.value = true;

        if (Get.find<DataAppController>().badge.value.user?.isHost == null) {
          Get.to(() => ChooseTypeUserScreen())!
              .then((value) => UserInfo().logout());
          return;
        }

        
        if ((Get.find<DataAppController>().badge.value.user!.listMotelRented ??
                [])
            .isEmpty) {
          Get.offAll(() => NavigatorApp());
        } else {
          Get.offAll(() => NavigatorApp(
                selectedIndex: 3,
              ));
        }
      }
    });
  }

  var listUserLogin = RxList<UserLogin>();
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
}
