import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:badges/badges.dart' as b;

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:gohomy/screen/home/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version_check/version_check.dart';

import '../chat/chat_list/chat_list_controller.dart';
import '../chat/chat_list/chat_list_screen.dart';
import '../data_app_controller.dart';
import '../home/home_screen.dart';
import '../notification/notification_cus_controller.dart';
import '../notification/notification_cus_screen.dart';
import '../owner/post_management/add_update_post_management/add_update_post_management_screen.dart';
import '../owner/post_management/host_post_screen.dart';
import '../profile/customer_post/customer_post_screen.dart';
import '../profile/profile_screen.dart';
import '../profile/service_sell/product_user_screen/product_user_controller.dart';
import '../profile/service_sell/product_user_screen/product_user_screen.dart';
import '../profile/service_sell/services_sell_user_controller.dart';
import '../profile/service_sell/services_sell_user_screen.dart';
import 'navigator_controller.dart';

class NavigatorApp extends StatefulWidget {
  late NavigatorController navigatorController;
  int? selectedIndex;

  NavigatorApp({this.selectedIndex}) {
    navigatorController =
        Get.put(NavigatorController(selecteIndex: selectedIndex ?? 0));
  }

  @override
  State<NavigatorApp> createState() => _NavigatorAppState();
}

class _NavigatorAppState extends State<NavigatorApp> {
  DataAppController dataAppController = Get.find();

  List<Widget> pages = [
    const HomeScreen(),
    const ServicesSellUserLockScreen(),
    const ChatListLockScreen(),
    const ProfileLockScreen(),
    HostPostLockScreen()
  ];

  final iconList = <String>[
    "assets/icon/home_fill.svg",
    "assets/icon/icon-mang.svg",
    "assets/icon/chat.svg",
    "assets/icon/user.svg"
  ];

  final listTitle = ['Trang chủ', 'Dịch vụ', 'Tin nhắn', 'Cá nhân'];

  var indexScroll = 0;

  String? version = '';
  String? storeVersion = '';
  String? storeUrl = '';
  String? packageName = '';

  @override
  void initState() {
    if (dataAppController.badge.value.user?.isHost == false) {
      pages = [
        const HomeScreen(),
        const ServicesSellUserLockScreen(),
        const ChatListLockScreen(),
        const ProfileLockScreen(),
        const CustomerPostLockScreen()
      ];
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        checkVersion();
      });
    });
    super.initState();
  }

  var versionCheck = VersionCheck();

  Future checkVersion() async {
    versionCheck = VersionCheck(
      packageName: dataAppController.packageInfo.value.packageName,
      packageVersion: dataAppController.packageInfo.value.version,
      showUpdateDialog: customShowUpdateDialog,
      country: 'vn',
    );
    await versionCheck.checkVersion(context);

    version = versionCheck.packageVersion;
    packageName = versionCheck.packageName;
    storeVersion = versionCheck.storeVersion;
    storeUrl = versionCheck.storeUrl;
  }

  void customShowUpdateDialog(BuildContext context, VersionCheck versionCheck) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Có bản cập nhật mới'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Cập nhật lên phiên bản mới ${versionCheck.storeVersion}?'),
              Text('(phiên bản hiện tại ${versionCheck.packageVersion})'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cập nhật'),
            onPressed: () async {
              if (Platform.isAndroid) {
                final url = Uri.parse(
                    "market://details?id=${dataAppController.packageInfo.value.packageName}");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $url';
                }
              } else {
                await versionCheck.launchStore();
              }
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Thoát'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: widget.navigatorController.selectedIndex.value,
          children: pages,
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton:
          // dataAppController.badge.value.user?.isHost == false
          //     ? null
          //     :
          FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Increment',
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            'assets/icon/home.svg',
            color: Colors.white,
          ),
        ),
        onPressed: () {
          widget.navigatorController.selectedIndex.value = 4;
        },
      ),
      floatingActionButtonLocation:
          // dataAppController.badge.value.user?.isHost == false
          //     ? null
          //     :
          FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar.builder(
          backgroundColor: Colors.white,
          splashColor: Theme.of(context).primaryColor,
          borderColor: Colors.grey[200],
          activeIndex: widget.navigatorController.selectedIndex.value,
          gapLocation:
              // dataAppController.badge.value.user?.isHost == false
              //     ? GapLocation.none
              //     :

              GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          onTap: (index) {
            widget.navigatorController.selectedIndex.value = index;
            if (widget.navigatorController.selectedIndex.value == 0) {
              indexScroll = indexScroll + 1;

              if (dataAppController.isLogin.value == true) {
                dataAppController.getBadge();
              }

              if (indexScroll >= 2) {
                Get.find<HomeController>().scrollTop();
              }
            }
            if (index != 0) {
              indexScroll = 0;
            }

            if (widget.navigatorController.selectedIndex.value == 3) {
              if (dataAppController.isLogin.value == true) {
                Get.find<DataAppController>().getBadge();
              }
            }
            if (widget.navigatorController.selectedIndex.value == 2) {
              if (dataAppController.isLogin.value == true) {
                Get.find<ChatListController>().getChatAdminHelper();
              }
              // if (dataAppController.isLogin.value == true) {
              //   Get.find<NotificationController>()
              //       .historyNotification(isRefresh: true);
              //   Get.find<DataAppController>().getBadge();
              // }
            }
            if (widget.navigatorController.selectedIndex.value == 1) {
              if (dataAppController.isLogin.value == true) {
                Get.find<ServicesSellUserController>()
                    .getAllCategory(isRefresh: true);
              }
            }
          },
          tabBuilder: (int index, bool isActive) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => b.Badge(
                    toAnimate: false,
                    padding: const EdgeInsets.all(3),
                    showBadge:
                        // index == 2
                        //     ? dataAppController.isLogin.value &&
                        //             ((dataAppController
                        //                         .badge.value.notificationUnread !=
                        //                     0 &&
                        //                 dataAppController
                        //                         .badge.value.notificationUnread !=
                        //                     null))
                        //         ? true
                        //         : false
                        //     :
                        index == 2
                            ? (dataAppController.isLogin.value &&
                                    (dataAppController.badge.value.chatUnread !=
                                            0 &&
                                        dataAppController
                                                .badge.value.chatUnread !=
                                            null)
                                ? true
                                : false)
                            : false,
                    badgeContent: Text(
                      '${dataAppController.badge.value.chatUnread ?? ''}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    child: SvgPicture.asset(
                      iconList[index],
                      width: 20,
                      height: 20,
                      color: isActive
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  listTitle[index],
                  style: TextStyle(
                      color: isActive
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                      fontSize: 12),
                )
              ],
            );
          },
          itemCount: iconList.length,
        ),
      ),
    );
  }
}
