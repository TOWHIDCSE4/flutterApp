import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/firebase/load_firebase.dart';
import '../../../model/user_login.dart';
import '../../../screen/data_app_controller.dart';
import '../../../screen/login/login_screen.dart';
import '../../../screen/navigator/navigator_screen.dart';
import '../../../utils/user_info.dart';
import '../../arlert/saha_alert.dart';
import '../../button/saha_button.dart';
import '../../empty/saha_empty_avatar.dart';
import '../../loading/loading_container.dart';
import '../../loading/loading_full_screen.dart';
import 'check_customer_login_controller.dart';

class CheckCustomerLogin extends StatelessWidget {
  final Widget child;

  CheckCustomerLogin({Key? key, required this.child}) : super(key: key);
  CheckCustomerLoginController controller = CheckCustomerLoginController();
  DataAppController dataAppController = Get.find();

  var loading = false.obs;

  @override
  Widget build(BuildContext context) {
    print("======>>>>>>>${dataAppController.isLogin.value}");
    return Obx(
      () => dataAppController.isLogin.value == true
          ? child
          : Scaffold(
              appBar: AppBar(
                title: const Text("Đăng nhập"),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        // begin: Alignment.bottomLeft,
                        // end: Alignment.topRight,
                        colors: <Color>[Colors.deepOrange, Colors.orange]),
                  ),
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.05),
              body: Obx(
                () => Stack(
                  children: [
                    // if (dataAppController.listUserLogin.isNotEmpty)
                    //   Positioned(
                    //     top: 10,
                    //     right: 10,
                    //     child: IconButton(
                    //         onPressed: () {
                    //         print('abbbbbbbbbsdfsdfsdfsdffs');
                    //           Get.to(() => ConfigUserScreen())!.then((value) =>
                    //               {
                    //                 dataAppController.getUserLogin(
                    //                     refresh: true)
                    //               });
                    //         },
                    //         icon: Icon(
                    //           Icons.settings,
                    //           color: Colors.grey,
                    //         )),
                    //   ),

                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SahaEmptyAvata(
                                height: 100,
                                width: 100,
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          ...dataAppController.listUserLogin
                              .map((e) => itemUserLogin(e))
                              .toList(),
                          const SizedBox(
                            height: 50,
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
                                          top: 10,
                                          bottom: 10,
                                          left: 20,
                                          right: 20),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey[300]!),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: const Text(
                                        'Đăng nhập bằng tài khoản khác',
                                      ),
                                    ),
                                  )
                                : SizedBox(
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
                          SizedBox(
                            height: 40,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "© 2022 RENCITY JSC ${UserInfo().getIsRelease() == null ? "" : "(DEV)"}",
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 12),
                            ),
                          ),
                          Container(
                            width: Get.width,
                            padding: const EdgeInsets.only(
                                top: 5, right: 10, bottom: 20, left: 10),
                            child: Center(
                              child: Text(
                                "version ${dataAppController.packageInfo.value.version} - Build ${dataAppController.packageInfo.value.buildNumber}",
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    if (loading.value) SahaLoadingFullScreen(),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> login(UserLogin user) async {
    loading(true);
    try {
      await UserInfo().setToken(user.token);
      await FCMMess().initToken();
      dataAppController.isLogin.value = true;
      await dataAppController.getBadge();
      Get.offAll(() => NavigatorApp());
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading(false);
  }

  Widget itemUserLogin(UserLogin user) {
    return InkWell(
      onTap: () {
        login(user);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.phone ?? '',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  )
                ],
              ),
            ),
                Obx(
                ()=>controller.loadInit.value ? const SizedBox():  controller.listNotiUser.isEmpty ? const SizedBox():
                controller.listNotiUser.firstWhere((e) => e.userId == user.id).notiUnread == 0 ? const SizedBox():
                ClipOval(
                  child: Container(
                    width: 35,
                    height: 35,
                    
                    decoration:const BoxDecoration(color: Colors.red,),
                    child: Center(child: Text("${controller.listNotiUser.firstWhere((e) => e.userId == user.id).notiUnread ?? 0}",style: const TextStyle(color: Colors.white),)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
