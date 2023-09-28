import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/widget/config_user_screen/config_user_controller.dart';
import 'package:hive/hive.dart';

import '../../../data/firebase/load_firebase.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/user_login.dart';
import '../../../screen/data_app_controller.dart';
import '../../../screen/login/login_screen.dart';
import '../../../screen/navigator/navigator_screen.dart';
import '../../../utils/user_info.dart';
import '../../arlert/saha_alert.dart';
import '../../button/saha_button.dart';
import '../../dialog/dialog.dart';
import '../../empty/saha_empty_avatar.dart';
import '../../loading/loading_container.dart';
import '../../loading/loading_full_screen.dart';

class ConfigUserScreen extends StatelessWidget {
  DataAppController dataAppController = Get.find();
  var loading = false.obs;
  ConfigUserController controller = ConfigUserController();

  Future<void> login(UserLogin user) async {
    loading(true);
    try {
      await RepositoryManager.adminManageRepository.deleteToken(
          userId: Get.find<DataAppController>().currentUser.value.id!,
          deviceToken: FCMToken().getToken()!);
      await UserInfo().setToken(user.token);
      await FCMMess().initToken();
      dataAppController.isLogin.value = true;
      await dataAppController.getBadge();
      dataAppController.getUserLogin(refresh: true);
      Get.offAll(() => NavigatorApp());
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading(false);
  }
  // List<Widget> listUser = [];
  // ConfigUserScreen() {
  //   listUser = dataAppController.listUserLogin.isNotEmpty ? dataAppController.listUserLogin
  //       .map((e) => itemUserLogin(e))
  //       .toList() : [];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
      ),
      body: Obx(
        () => loading.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ...dataAppController.listUserLogin
                        .map((e) => itemUserLogin(e))
                        .toList(),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => dataAppController.listUserLogin.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                Get.to(() => const LoginScreen(
                                      hasBack: true,
                                    ));
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 20, right: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(6)),
                                child: const Text(
                                  'Đăng nhập bằng tài khoản khác',
                                ),
                              ),
                            )
                          : Center(
                            child: SizedBox(
                                width: Get.width * 0.7,
                                child: SahaButtonFullParent(
                                  text: "Đăng nhập ngay",
                                  onPressed: () {
                                    Get.to(() => const LoginScreen(
                                          hasBack: true,
                                        ));
                                  },
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                          ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget itemUserLogin(UserLogin user) {
    return InkWell(
      onTap: () {
        login(user);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ]),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: dataAppController.currentUser.value.id == user.id
                ? Theme.of(Get.context!).primaryColor.withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  height: 55,
                  width: 55,
                  fit: BoxFit.cover,
                  imageUrl: user.avatar ?? '',
                  placeholder: (context, url) => const SahaLoadingContainer(),
                  errorWidget: (context, url, error) => const SahaEmptyAvata(
                    width: 55,
                    height: 55,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name ?? ''} (${user.isAdmin == true ? "Admin" : user.isHost == true ? "Chủ nhà" : "Khách thuê"})',
                      style: TextStyle(
                          color: Theme.of(Get.context!).primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      user.phone ?? '',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Obx(
                ()=>controller.loadInit.value ? const SizedBox():  controller.listNotiUser.isEmpty ? const SizedBox():
                controller.listNotiUser.firstWhereOrNull((e) => e.userId == user.id)?.notiUnread == 0 ? const SizedBox():
                ClipOval(
                  child: Container(
                    width: 25,
                    height: 25,


                    decoration:const BoxDecoration(color: Colors.red,),
                    child: Center(child: Text("${controller.listNotiUser.firstWhereOrNull((e) => e.userId == user.id)?.notiUnread ?? 0}",style: const TextStyle(color: Colors.white,fontSize: 12),)),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    SahaDialogApp.showDialogYesNo(
                        mess:
                            'Bạn có chắc chắn muốn xoá tài khoản đăng nhập này chứ ?',
                        onOK: () async {
                          var box = await Hive.openBox('USER_LOGIN');
                          var index = dataAppController.listUserLogin
                              .map((e) => e.id)
                              .toList()
                              .indexOf(user.id);
                          box.deleteAt(index);
                          dataAppController.getUserLogin(refresh: true);
                        });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}