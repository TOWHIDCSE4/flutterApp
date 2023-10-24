import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/splash/splash_controller.dart';
import '../../components/arlert/saha_alert.dart';
import '../../main.dart';
import '../../utils/user_info.dart';
import '../data_app_controller.dart';
import '../find_room/find_room_post/post_find_room_screen.dart';
import '../find_room/post_roommate/post_roommate_screen.dart';
import '../find_room/room_information/room_information_screen.dart';
import '../home/home_controller.dart';
import '../navigator/navigator_screen.dart';
import '../profile/choose_type_user/choose_type_user_screen.dart';
import '../profile/update_phone/update_phone_screen.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({super.key,});
   
       
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with RouteAware {
  var hasClick = false;

  DataAppController dataAppController = Get.put(DataAppController());

  HomeController homeController = Get.put(HomeController());

  SplashController splashController = SplashController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () async {
      await homeController.getAllHomeApp();
      await checkLogin();
      handleDynamicLinks();
    });
  }

  String? version = '';
  String? storeVersion = '';
  String? storeUrl = '';
  String? packageName = '';

  void handleDynamicLinks() async {
    PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
     FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

   

 
  if (initialLink != null) {
    final Uri deepLink = initialLink.link;
  
    List<String> segments = deepLink.path.split("/");
    String typePost = segments[1];
    int? postId = int.tryParse(segments[2]);
  
    if (typePost == "post") {
      if (postId == null) {
        SahaAlert.showError(message: "Bài đăng không tồn tại hoặc đã bị xoá");
        return;
      }
      Get.to(() => RoomInformationScreen(
            roomPostId: postId,
          ));
    } else if (typePost == "roommate") {
      if (postId == null) {
        SahaAlert.showError(message: "Bài đăng không tồn tại hoặc đã bị xoá");
        return;
      }
      Get.to(() => PostRoommateScreen(
            postRoommateId: postId,
          ));
    } else {
      if (postId == null) {
        SahaAlert.showError(message: "Bài đăng không tồn tại hoặc đã bị xoá");
        return;
      }
      Get.to(() => PostFindRoomScreen(
            postFindRoomId: postId,
          ));
    }
  }
  


    dynamicLinks.onLink.listen((dynamicLinkData) {
      print('link from abc: ===>>>${dynamicLinkData.link}');

      List<String> segments = dynamicLinkData.link.path.split("/");
      String typePost = segments[1];
      int? postId = int.tryParse(segments[2]);

      if (typePost == "post") {
        if (postId == null) {
          SahaAlert.showError(message: "Bài đăng không tồn tại hoặc đã bị xoá");
          return;
        }
        Get.to(() => RoomInformationScreen(
              roomPostId: postId,
            ));
      } else if (typePost == "roommate") {
        if (postId == null) {
          SahaAlert.showError(message: "Bài đăng không tồn tại hoặc đã bị xoá");
          return;
        }
        Get.to(() => PostRoommateScreen(
              postRoommateId: postId,
            ));
      } else {
        if (postId == null) {
          SahaAlert.showError(message: "Bài đăng không tồn tại hoặc đã bị xoá");
          return;
        }
        Get.to(() => PostFindRoomScreen(
              postFindRoomId: postId,
            ));
      }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }


  

  Future<void> checkLogin() async {
    if (await UserInfo().hasLogged()) {
      await dataAppController.getBadge().then((value) {
        if (dataAppController.badge.value.user?.phoneNumber == null &&
            dataAppController.badge.value.user?.id != null) {
          if (dataAppController.connectionStatus == ConnectivityResult.none) {
            Get.to(() => UpdatePhoneScreen())!
                .then((value) => {UserInfo().logout()});
          }
        } else {
          dataAppController.isLogin.value = true;

          if (dataAppController.badge.value.user?.isHost == null) {
            Get.to(() => ChooseTypeUserScreen())!
                .then((value) => UserInfo().logout());
            return;
          }

          if ((dataAppController.badge.value.user!.listMotelRented ?? [])
              .isEmpty) {
            Get.offAll(() => NavigatorApp());
          } else {
            Get.offAll(() => NavigatorApp(
                  selectedIndex: 3,
                ));
          }
        }
      });
    } else {
      dataAppController.isLogin.value = false;
      Get.offAll(() => NavigatorApp());
    }
  }

  void onNext() {
    hasClick = true;
    Get.offAll(() => NavigatorApp());
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => splashController.loadInit.value
            ? const SizedBox()
            : SizedBox(
                height: double.infinity,
                // width: double.infinity,
                child: Image.asset(
                  'assets/intro.jpg',
                  // height: Get.width / 2,
                  width: Get.width,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
      ),
    );
  }
}
