import 'dart:io';

import 'package:badges/badges.dart' as b;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/empty/saha_empty_avatar.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';
import 'package:gohomy/const/sp_const.dart';
import 'package:gohomy/const/test_const.dart';

import 'package:gohomy/screen/admin/admin_screen.dart';
import 'package:gohomy/screen/admin/notification_admin/notification_screen.dart';
import 'package:gohomy/screen/profile/service_sell/orders/orders_screen.dart';

// admin review
import 'package:gohomy/screen/profile/wallet_admin_review/wallet_admin_review.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/profile/bill/bill_screen.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/deposit_withdraw_page.dart';
import 'package:gohomy/screen/profile/favourite_post/favourite_post_screen.dart';
import 'package:gohomy/screen/profile/profile_controller.dart';
import 'package:gohomy/screen/profile/service_sell/product_user_screen/product_user_screen.dart';
import 'package:gohomy/screen/users_bill/user_bill_screen.dart';
import 'package:gohomy/utils/sp_utils.dart';
import '../../components/button/saha_button.dart';
import '../../components/check/check_login_widget.dart';
import '../../components/empty/saha_empty_image.dart';
import '../../components/loading/loading_widget.dart';
import '../../components/widget/check_customer_login/check_customer_login_screen.dart';
import '../../components/widget/check_decentralization.dart';
import '../../components/widget/config_user_screen/config_user_screen.dart';
import '../../utils/string_utils.dart';
import '../../utils/user_info.dart';
import '../admin/bill/bill_admin_screen.dart';
import '../admin/chat_admin/choose_host/choose_host_screen.dart';
import '../admin/contact/admin_contact_screen.dart';
import '../admin/contract/contract_admin_screen.dart';
import '../admin/decentralization_admin/decentralization_manage_screen.dart';
import '../admin/find_fast_motel/find_fast_motel_screen.dart';
import '../admin/motel_room_admin/admin_motel_room_screen.dart';
import '../admin/motel_room_admin/admin_motel_screen.dart';
import '../admin/motel_room_admin/tower/tower_screen.dart';
import '../admin/post/post_admin_screen.dart';
import '../admin/post/post_screen.dart';
import '../admin/potential_user/potential_user_screen.dart';
import '../admin/problem/problem_admin_screen.dart';
import '../admin/referral_manage_screen.dart';
import '../admin/renter_manage_admin/renter_manage_admin_screen.dart';
import '../admin/report_screen.dart';
import '../admin/service_sell/orders/orders_admin_screen.dart';
import '../admin/service_sell/service_sell_screen.dart';
import '../admin/services_sell/services_sell_screen.dart';
import '../admin/support/support_screen.dart';
import '../admin/ui_mangage/ui_manage_screen.dart';
import '../admin/users/users_manage_screen.dart';
import '../home/home_controller.dart';
import '../owner/commission/commission_manage_screen.dart';
import '../owner/contract/contract_screen.dart';
import '../owner/customer_home_screen.dart';

import '../owner/motel_manager/tower_manager_screen.dart';
import '../owner/motel_room/list_motel_room_screen.dart';
import '../owner/motel_room/motel_room_manage_screen.dart';
import '../owner/post_management/list_post_management_screen.dart';
import '../owner/problem_owner/problem_owner_screen.dart';
import '../owner/renters/renter_screen.dart';
import '../owner/report/report_screen.dart';
import '../owner/reservation_motel/reservation_motel_host_screen.dart';
import '../owner/service/service_screen.dart';
import '../wallet_register/register_screen.dart';
import 'contract/contract_user_screen.dart';
import 'customer_post/customer_post_screen.dart';
import 'e_wallet_histories/e_wallet_histories_screen.dart';
import 'edit_profile/edit_profile_screen.dart';
import 'help_post/help_screen.dart';
import 'problem/problem_screen.dart';
import 'profile_details/profile_details_page.dart';
import 'service_sell/cart/cart_screen.dart';
import 'widgets/activated_button.dart';
import 'widgets/summart_tile.dart';

class ProfileLockScreen extends StatelessWidget {
  const ProfileLockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(child: ProfileScreen());
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DataAppController dataAppController = Get.find();
  HomeController homeController = Get.find();
  ProFileController proFileController = ProFileController();
  bool? kycRegSuccessStatus;
  String? kycUserName;
  String? kycUserImage;
  bool isLoadingSp = true;

  @override
  void initState() {
    getKycValuesFromSP();
    super.initState();
  }

  Future<void> getKycValuesFromSP() async {
    kycRegSuccessStatus =
        await SharedPref.getBoolValueFromSp(SpConstants.kycRegSuccessStatus) ??
            false;
    kycUserName =
        await SharedPref.getStringValueFromSp(SpConstants.kycUserName);
    kycUserImage =
        await SharedPref.getStringValueFromSp(SpConstants.kycUserImage);
    setState(() {
      isLoadingSp = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingSp
        ? SahaLoadingWidget()
        : Obx(() {
            if (dataAppController.badge.value.user?.isHost == true &&
                dataAppController.badge.value.user?.isAdmin == true) {
              return adminProfile();
            }
            if (dataAppController.badge.value.user?.isAdmin == true) {
              return adminProfile();
            }

            if (dataAppController.badge.value.user?.isHost == true) {
              return hostProfile();
            }

            if (dataAppController.badge.value.user?.isHost == false ||
                dataAppController.badge.value.user?.isHost == null) {
              return usersProfile();
            }

            return Container();
          });
  }

  Widget optionProfile(
      {required String icon,
      required String name,
      required Function onTap,
      int? badge,
      int? badgeAdmin}) {
    return Container(
      child: Column(
        children: [
          ListTile(
            onTap: () {
              onTap();
            },
            leading: Image.asset(
              icon,
              height: 35,
              width: 35,
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (badge != null && badge != 0)
                  Text(
                    '($badge)',
                    style: const TextStyle(color: Colors.green),
                  ),
                const SizedBox(
                  width: 5,
                ),
                // if (badgeAdmin != null && badgeAdmin != 0)
                //   Text(
                //     '($badgeAdmin)',
                //     style: TextStyle(color: Theme.of(context).primaryColor),
                //   )
              ],
            ),
            trailing: const Icon(Icons.navigate_next_rounded),
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget userProfile() {
    return CheckLoginWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  Container(
                    height: Get.height / 3,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => EditProfileUser(
                                      user: dataAppController.badge.value.user!,
                                    ));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: CachedNetworkImage(
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                  imageUrl: dataAppController
                                          .badge.value.user?.avatarImage ??
                                      "",
                                  // placeholder: (context, url) =>
                                  //     SahaLoadingWidget(),
                                  errorWidget: (context, url, error) =>
                                      const SahaEmptyAvata(
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dataAppController.badge.value.user
                                                      ?.isHost ==
                                                  true
                                              ? 'Xin chào chủ nhà'
                                              : 'Xin chào',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          dataAppController
                                                  .badge.value.user?.name ??
                                              "",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        (dataAppController.currentUser.value
                                                        .listMotelRented ??
                                                    [])
                                                .isEmpty
                                            ? Container()
                                            : Text(
                                                dataAppController
                                                        .badge
                                                        .value
                                                        .user
                                                        ?.listMotelRented?[0]
                                                        .motelName ??
                                                    '',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Get.to(() => const HelpScreen());
                                      },
                                      icon: const Icon(
                                        Icons.headset_mic_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => dataAppController
                                              .badge.value.user?.isHost ==
                                          true &&
                                      dataAppController.badge.value
                                              .totalProblemNotDoneManage !=
                                          null &&
                                      dataAppController.badge.value
                                              .totalProblemNotDoneManage !=
                                          0
                                  ? InkWell(
                                      onTap: () {
                                        Get.to(() => ProblemOwnerScreen());
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                              offset: const Offset(1,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/alert.svg",
                                              height: 20,
                                              width: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Có ${dataAppController.badge.value.totalProblemNotDoneManage} sự cố cần giải quyết',
                                              style: const TextStyle(),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Obx(
                              () => dataAppController.badge.value
                                              .totalMoneyNeedPayment ==
                                          null ||
                                      dataAppController.badge.value
                                              .totalMoneyNeedPayment ==
                                          0
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        Get.to(() => const UserBillScreen());
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                              offset: const Offset(1,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/alert.svg",
                                              height: 20,
                                              width: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Bạn còn ${SahaStringUtils().convertToMoney(dataAppController.badge.value.totalMoneyNeedPayment ?? "0")} đồng cần thanh toán',
                                              style: const TextStyle(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(
                                1, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Obx(
                        () => Column(
                          children: [
                            if (dataAppController.badge.value.user?.isHost ==
                                true)
                              optionProfile(
                                  name: 'Quản lý phòng trọ',
                                  icon: "assets/checklist.svg",
                                  onTap: () {
                                    Get.to(() => const CustomerHomeScreen())!
                                        .then((value) =>
                                            dataAppController.getBadge());
                                  }),
                            if (dataAppController.badge.value.user?.isAdmin ==
                                true)
                              optionProfile(
                                  name: 'Admin',
                                  icon: "assets/admin.svg",
                                  onTap: () {
                                    Get.to(() => const AdminScreen());
                                  }),
                            Obx(
                              () => optionProfile(
                                  badge: dataAppController
                                      .badge.value.totalQuantityContractPending,
                                  name: 'Hợp đồng',
                                  icon: "assets/contract.svg",
                                  onTap: () {
                                    Get.to(() => ContractUserScreen());
                                  }),
                            ),
                            Obx(
                              () => optionProfile(
                                  name: 'Hoá đơn',
                                  icon: "assets/bill.svg",
                                  badge: dataAppController
                                      .badge.value.totalQuantityBillsNeedPaid,
                                  onTap: () {
                                    Get.to(() => const UserBillScreen());
                                  }),
                            ),
                            Obx(
                              () => optionProfile(
                                  badge: dataAppController
                                      .badge.value.totalQuantityProblemNotDone,
                                  name: 'Sự cố',
                                  icon: "assets/icon_service/repair.svg",
                                  onTap: () {
                                    Get.to(() => ProblemScreen());
                                  }),
                            ),
                            optionProfile(
                                icon: "assets/favourite.svg",
                                name: 'Bài đăng yêu thích',
                                onTap: () {
                                  Get.to(() => const FavouriteScreen());
                                }),
                            optionProfile(
                                name: 'Dịch vụ',
                                icon: "assets/cutlery.svg",
                                onTap: () {
                                  Get.to(
                                    ProductUserScreen(),
                                  );
                                }),
                            optionProfile(
                                name: 'Đăng xuất',
                                icon: "assets/logout.svg",
                                onTap: () {
                                  SahaDialogApp.showDialogYesNo(
                                      mess:
                                          'Bạn chắc chắn muốn đăng xuất chứ ?',
                                      onClose: () {},
                                      onOK: () {
                                        UserInfo().logout();
                                      });
                                }),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "© 2022 GOHOMY JSC ${UserInfo().getIsRelease() == null ? "" : "(DEV)"}",
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    ),
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.only(
                          top: 5, right: 10, bottom: 20, left: 10),
                      child: Center(
                        child: Text(
                          "version ${dataAppController.packageInfo.value.version} - Build ${dataAppController.packageInfo.value.buildNumber}",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget adminProfile() {
    return CheckLoginWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  Container(
                    height: Get.height / 3,
                    width: Get.width,
                    decoration: const BoxDecoration(
                      // image: DecorationImage(
                      //     fit: BoxFit.cover,
                      //     image: AssetImage('assets/anh-nen.jpg')),
                      gradient: LinearGradient(
                          // begin: Alignment.bottomLeft,
                          // end: Alignment.topRight,
                          colors: <Color>[Colors.deepOrange, Colors.orange]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ConfigUserScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 3, bottom: 3, right: 10, left: 10),
                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            )),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Chuyển tài khoản',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              'assets/icon/refresh.svg',
                              height: 15,
                              width: 15,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => EditProfileUser(
                                    user: dataAppController.badge.value.user!,
                                  ));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Stack(
                                clipBehavior: Clip.hardEdge,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: CachedNetworkImage(
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                      imageUrl: dataAppController
                                              .badge.value.user?.avatarImage ??
                                          "",
                                      // placeholder: (context, url) =>
                                      //     SahaLoadingWidget(),
                                      errorWidget: (context, url, error) =>
                                          const SahaEmptyAvata(
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Xin chào',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        dataAppController
                                                .badge.value.user?.name ??
                                            "",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.to(() => const HelpScreen());
                                      },
                                      icon: const Icon(
                                        Icons.headset_mic_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    const Text(
                                      "Trợ giúp",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() =>
                        dataAppController.currentUser.value.decentralization ==
                                    null ||
                                (dataAppController.currentUser.value
                                            .decentralization?.viewBadge ??
                                        false) ==
                                    true
                            ? Container(
                                width: Get.width,
                                margin: const EdgeInsets.all(15),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              const Text(
                                                "Tổng số bài đăng",
                                              ),
                                              Text(
                                                "${dataAppController.badge.value.totalMoPostAdmin ?? ''}",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              const Text(
                                                "Tổng phòng",
                                              ),
                                              Text(
                                                "${dataAppController.badge.value.totalMotelAdmin ?? ''}",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              const Text("Tổng users chủ nhà"),
                                              Text(
                                                "${dataAppController.badge.value.totalHostAccountAdmin ?? ""}",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              const Text("Tổng Users"),
                                              Text(
                                                "${dataAppController.badge.value.totalUser ?? ''}",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              const Text(
                                                "Tổng đơn hàng trong tháng",
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                "${dataAppController.badge.value.totalOrderAdmin ?? ''}",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              const Text("Users có phòng"),
                                              Text(
                                                "${dataAppController.badge.value.totalRenterHasMotelAdmin}",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox()),
                    Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(1, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController.badge.value.user
                                          ?.decentralization?.manageMotel ??
                                      false,
                              child: optionProfile(
                                  name: 'Quản lý ví Renren',
                                  icon: ImageAssets.renren,
                                  onTap: () {
                                    Get.to(() =>
                                        WalletAdminManagerReviewHistory());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController.badge.value.user
                                          ?.decentralization?.manageMotel ??
                                      false,
                              child: optionProfile(
                                  name: 'Quản lý phòng trọ',
                                  icon: "assets/icon_host/quan-ly-phong.png",
                                  onTap: () {
                                    Get.to(() => AdminMotelScreen());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController.badge.value.user
                                          ?.decentralization?.manageMoPost ??
                                      false,
                              child: optionProfile(
                                  name: 'Quản lý bài đăng',
                                  icon: "assets/icon_host/quan-ly-bai-dang.png",
                                  onTap: () {
                                    Get.to(() => const PostAdminScreen());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController
                                          .badge
                                          .value
                                          .user
                                          ?.decentralization
                                          ?.manageReportStatistic ??
                                      false,
                              child: optionProfile(
                                  //badge: dataAppController.totalReport.value,
                                  name: 'Khách hàng tiềm năng',
                                  icon: "assets/icon_host/khach_tiem_nang.png",
                                  onTap: () {
                                    Get.to(() =>
                                        PotentialUserScreen(isAdmin: true));
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController
                                          .badge
                                          .value
                                          .user
                                          ?.decentralization
                                          ?.manageReportStatistic ??
                                      false,
                              child: optionProfile(
                                  name: 'Quản lý người thuê',
                                  icon:
                                      "assets/icon_host/quan-ly-khach-thue.png",
                                  onTap: () {
                                    Get.to(
                                        () => const RenterManageAdminScreen());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController.badge.value.user
                                          ?.decentralization?.manageContract ??
                                      false,
                              child: optionProfile(
                                  badgeAdmin: dataAppController
                                      .badge.value.totalContractPendingAdmin,
                                  badge: dataAppController
                                      .badge.value.totalContractPendingManage,
                                  name: 'Quản lý hợp đồng',
                                  icon: "assets/icon_host/quan-ly-hop-dong.png",
                                  onTap: () {
                                    Get.to(() => ContractAdminScreen(
                                          initTab: 1,
                                        ));
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController.badge.value.user
                                          ?.decentralization?.manageBill ??
                                      false,
                              child: optionProfile(
                                  badgeAdmin: dataAppController
                                      .badge.value.totalQuantityBillsAdmin,
                                  badge: dataAppController
                                      .badge.value.totalQuantityBillManage,
                                  name: 'Quản lý hoá đơn',
                                  icon: "assets/icon_host/quan-ly-hoa-don.png",
                                  onTap: () {
                                    Get.to(() => const BillAdminScreen());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController
                                          .badge
                                          .value
                                          .user
                                          ?.decentralization
                                          ?.manageReportProblem ??
                                      false,
                              child: optionProfile(
                                  badgeAdmin: dataAppController
                                      .badge.value.totalProblemNotDoneAdmin,
                                  badge: dataAppController
                                      .badge.value.totalProblemNotDoneManage,
                                  name: 'Quản lý sự cố',
                                  icon: "assets/icon_host/bao-cao-su-co.png",
                                  onTap: () {
                                    Get.to(() => ProblemAdminScreen());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController
                                          .badge
                                          .value
                                          .user
                                          ?.decentralization
                                          ?.manageMotelConsult ??
                                      false,
                              child: optionProfile(
                                  badgeAdmin: dataAppController.badge.value
                                      .totalFindFastMotelNotResolveAdmin,
                                  name: 'Liên hệ tư vấn phòng',
                                  icon:
                                      "assets/icon_admin/lien-he-tu-van-phong.png",
                                  onTap: () {
                                    Get.to(() => const FindFastMotelScreen());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController.badge.value.user
                                          ?.decentralization?.manageUser ??
                                      false,
                              child: optionProfile(
                                  name: 'Quản lý người dùng',
                                  icon:
                                      "assets/icon_admin/quan-ly-nguoi-dung.png",
                                  onTap: () {
                                    Get.to(() => const UserManageSceen());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController
                                          .badge
                                          .value
                                          .user
                                          ?.decentralization
                                          ?.manageServiceSell ??
                                      false,
                              child: optionProfile(
                                  icon: "assets/icon_admin/quan-ly-dich-vu.png",
                                  name: 'Quản lý dịch vụ',
                                  onTap: () {
                                    Get.to(() => ServicesSellScreen());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController
                                          .badge
                                          .value
                                          .user
                                          ?.decentralization
                                          ?.manageOrderServiceSell ??
                                      false,
                              child: optionProfile(
                                  badgeAdmin: dataAppController.badge.value
                                      .totalQuantityOrderProgressingAdmin,
                                  name: 'Quản lý đơn hàng dịch vụ',
                                  icon:
                                      "assets/icon_admin/quan-ly-don-hang-dich-vu.png",
                                  onTap: () {
                                    Get.to(() => OrdersAdminScreen());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController
                                          .badge
                                          .value
                                          .user
                                          ?.decentralization
                                          ?.manageNotification ??
                                      false,
                              child: optionProfile(
                                  name: 'Quản lý thông báo',
                                  icon:
                                      "assets/icon_admin/quan-ly-thong-bao.png",
                                  onTap: () {
                                    Get.to(() => const AdminNotification());
                                  }),
                            ),
                          ),
                          optionProfile(
                              name: 'Quản lý dịch vụ chung',
                              icon: "assets/icon_host/dich_vu_chung.png",
                              onTap: () {
                                Get.to(() => ServiceScreen());
                              }),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController
                                          .badge
                                          .value
                                          .user
                                          ?.decentralization
                                          ?.ableDecentralization ??
                                      false,
                              child: optionProfile(
                                  name: 'Quản lý phần quyền admin',
                                  icon:
                                      "assets/icon_admin/phan-quyen-admin.png",
                                  onTap: () {
                                    Get.to(() => DecentralizationScreen());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController.badge.value.user
                                          ?.decentralization?.manageMessage ??
                                      false,
                              child: optionProfile(
                                  name: 'Quản lý tin nhắn',
                                  icon:
                                      "assets/icon_admin/quan-ly-tin-nhan.png",
                                  onTap: () {
                                    Get.to(() => const ChooseHostScreen(
                                        isShowTab: false));
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController
                                          .badge
                                          .value
                                          .user
                                          ?.decentralization
                                          ?.manageReportStatistic ??
                                      false,
                              child: optionProfile(
                                  badge: dataAppController.totalReport.value,
                                  name: 'Báo cáo thống kê',
                                  icon: "assets/icon_host/bao-cao-thong-ke.png",
                                  onTap: () {
                                    Get.to(() => ReportTotal());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController.badge.value.user
                                          ?.decentralization?.settingBanner ??
                                      false,
                              child: optionProfile(
                                  name: 'Cài đặt giao diện',
                                  icon:
                                      "assets/icon_admin/quan-ly-giao-dien.png",
                                  onTap: () {
                                    Get.to(() => const UIManage());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController.badge.value.user
                                          ?.decentralization?.settingContact ??
                                      false,
                              child: optionProfile(
                                  name: 'Cài đặt liên hệ',
                                  icon: "assets/icon_admin/cai-dat-lien-he.png",
                                  onTap: () {
                                    Get.to(() => const AdminContactScreen());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController.badge.value.user
                                          ?.decentralization?.settingHelp ??
                                      false,
                              child: optionProfile(
                                  name: 'Cài đặt Trung tâm Trợ giúp/Hỗ trợ',
                                  icon:
                                      "assets/icon_admin/trung-tam-tro-giup-ho-tro.png",
                                  onTap: () {
                                    Get.to(() => const SupportScreen());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController
                                          .badge
                                          .value
                                          .user
                                          ?.decentralization
                                          ?.manageCollaborator ??
                                      false,
                              child: optionProfile(
                                  name: 'Cộng tác viên',
                                  icon: "assets/icon_admin/cong-tac-vien.png",
                                  onTap: () {
                                    Get.to(() => const ReferralManageScreen());
                                  }),
                            ),
                          ),
                          Obx(
                            () => DecentralizationWidget(
                              decent: dataAppController
                                          .badge.value.user?.decentralization ==
                                      null
                                  ? true
                                  : dataAppController
                                          .badge
                                          .value
                                          .user
                                          ?.decentralization
                                          ?.manageCollaborator ??
                                      false,
                              child: optionProfile(
                                  name: 'Phân quyền quản lý',
                                  icon:
                                      "assets/icon_admin/phan_quyen_quan_ly.png",
                                  onTap: () {
                                    Get.to(() => TowerManagerScreen());
                                  }),
                            ),
                          ),
                          optionProfile(
                              name: 'Đăng xuất',
                              icon: "assets/icon_host/dang-xuat.png",
                              onTap: () {
                                SahaDialogApp.showDialogYesNo(
                                    mess: 'Bạn chắc chắn muốn đăng xuất chứ ?',
                                    onClose: () {},
                                    onOK: () {
                                      UserInfo().logout();
                                    });
                              }),
                        ],
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          SahaDialogApp.showDialogYesNo(
                              mess:
                                  "Tài khoản của bạn sẽ được xoá sau khoảng thời gian 1 ngày, trong thời gian này bạn có thể huỷ kích hoạt xoá tài khoản bằng cách đăng nhập lại!",
                              onOK: () {
                                UserInfo().logout();
                              });
                        },
                        child: Text(
                          "Yêu cầu xoá tài khoản",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.grey[500]),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "© 2022 RENCITY JSC ${UserInfo().getIsRelease() == null ? "" : "(DEV)"}",
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    ),
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.only(
                          top: 5, right: 10, bottom: 20, left: 10),
                      child: Center(
                        child: Text(
                          "version ${dataAppController.packageInfo.value.version} - Build ${dataAppController.packageInfo.value.buildNumber}",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget hostProfile() {
    return CheckLoginWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  Container(
                    height: Get.height / 3,
                    width: Get.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: <Color>[Colors.deepOrange, Colors.orange]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              top: kycRegSuccessStatus == true ? 20 : 30,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: kycRegSuccessStatus == true ? 0 : 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ConfigUserScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 3, bottom: 3, right: 10, left: 10),
                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            )),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Chuyển tài khoản',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              'assets/icon/refresh.svg',
                              height: 15,
                              width: 15,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() => EditProfileUser(
                                          user: dataAppController
                                              .badge.value.user!,
                                        ));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: kycRegSuccessStatus == true
                                        ? Image.file(
                                            File(kycUserImage ?? ""),
                                            // dataAppController
                                            //         .badge.value.user?.avatarImage ??
                                            //     "",
                                            // placeholder: (context, url) =>
                                            //     SahaLoadingWidget(),
                                            // errorWidget: (context, url, error) =>
                                            //     const SahaEmptyAvata(
                                            //   height: 60,
                                            //   width: 60,
                                            // ),
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          )
                                        : CachedNetworkImage(
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                            imageUrl: dataAppController.badge
                                                    .value.user?.avatarImage ??
                                                "",
                                            // placeholder: (context, url) =>
                                            //     SahaLoadingWidget(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const SahaEmptyAvata(
                                              height: 60,
                                              width: 60,
                                            ),
                                          ),
                                  ),
                                ),
                                if (dataAppController
                                        .currentUser.value.hostRank ==
                                    2)
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: ClipRRect(
                                          child: Image.asset(
                                        'assets/vip.png',
                                        height: 35,
                                        width: 35,
                                      ))),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Xin chào',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        kycRegSuccessStatus == true
                                            ? kycUserName ?? ''
                                            : dataAppController
                                                    .badge.value.user?.name ??
                                                "",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      kycRegSuccessStatus == true
                                          ? SummaryTile(
                                              goldCoinText:
                                                  '${dataAppController.currentUser.value.goldenCoins} Xu vàng',
                                              silverCoinText:
                                                  '${dataAppController.currentUser.value.silverCoins} Xu bạc',
                                              onTap: () => Get.to(
                                                  () => DepositWithdrawPage(
                                                        silverCoins:
                                                            dataAppController
                                                                .currentUser
                                                                .value
                                                                .silverCoins,
                                                        goldenCoins:
                                                            dataAppController
                                                                .currentUser
                                                                .value
                                                                .goldenCoins,
                                                      )),
                                            )
                                          : ActivedButton(
                                              title: 'Kích hoạt',
                                              onTap: () => Get.to(() =>
                                                  const ProfileDetailsPage()),
                                            ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.to(() => const HelpScreen());
                                      },
                                      icon: const Icon(
                                        Icons.headset_mic_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    const Text(
                                      "Trợ giúp",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: kycRegSuccessStatus == true ? 0 : 10,
                    ),
                    Container(
                      width: Get.width,
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      "Số phòng",
                                    ),
                                    Text(
                                      "${dataAppController.badge.value.totalMotelManage}",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      "Số khách thuê",
                                    ),
                                    Text(
                                      "${dataAppController.badge.value.totalRenter}",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text("Số phòng đã cho thuê"),
                                    Text(
                                      "${dataAppController.badge.value.totalMotelRentedManage}",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text("Số phòng trống"),
                                    Text(
                                      "${dataAppController.badge.value.totalMotelAvailableManage}",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          runSpacing: 30,
                          children: [
                            option(
                              name: "Tạo toà nhà",
                              onTap: () {
                                Get.to(() => TowerScreen(
                                      isNext: true,
                                    ));
                              },
                              image: "assets/icon_host/tao_toa_nha.png",
                            ),
                            option(
                              name: "Tạo phòng",
                              onTap: () {
                                Get.to(() => ListMotelRoomScreen(
                                      isNext: true,
                                    ));
                              },
                              image: "assets/icon_host/them-phong.png",
                            ),
                            option(
                              name: "Tạo bài đăng",
                              onTap: () {
                                Get.to(() => ListPostManagementScreen(
                                      isNext: true,
                                    ));
                              },
                              image: "assets/icon_host/them-bai-dang.png",
                            ),

                            option(
                              name: "Thêm khách thuê",
                              onTap: () {
                                Get.to(() => RenterScreen(
                                      isNext: true,
                                    ));
                              },
                              image: "assets/icon_host/them-khach-thue.png",
                            ),
                            option(
                              name: "Tạo hợp đồng",
                              onTap: () {
                                Get.to(() => ContractScreen(
                                      isNext: true,
                                    ));
                              },
                              image: "assets/icon_host/tao-hop-dong.png",
                            ),
                            option(
                              name: "Tạo hoá đơn",
                              onTap: () {
                                Get.to(() => BillScreen(
                                      isNext: true,
                                    ));
                              },
                              image: "assets/icon_host/tao-hoa-don.png",
                            ),
                            // Obx(
                            //   () => option(
                            //     name: "Báo cáo sự cố",
                            //     badge: dataAppController
                            //         .badge.value.totalProblemNotDoneManage,
                            //     onTap: () {
                            //       Get.to(() => ProblemOwnerScreen());
                            //     },
                            //     image: "assets/icon_host/bao-cao-su-co.png",
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(
                                1, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          optionProfile(
                              name: 'Quản lý phòng trọ',
                              icon: "assets/icon_host/quan-ly-phong.png",
                              onTap: () {
                                Get.to(() => MotelRoomManageScreen());
                              }),
                          optionProfile(
                              name: 'Quản lý bài đăng',
                              icon: "assets/icon_host/quan-ly-bai-dang.png",
                              onTap: () {
                                Get.to(() => ListPostManagementScreen(
                                      initTab: 1,
                                    ));
                              }),
                          optionProfile(
                              name: 'Khách hàng tiềm năng',
                              icon: "assets/icon_host/khach_tiem_nang.png",
                              onTap: () {
                                Get.to(() => PotentialUserScreen());
                              }),
                          optionProfile(
                              name: 'Quản lý người thuê',
                              icon: "assets/icon_host/quan-ly-khach-thue.png",
                              onTap: () {
                                Get.to(() => RenterScreen());
                              }),
                          Obx(
                            () => optionProfile(
                                badge: dataAppController
                                    .badge.value.totalContractPendingManage,
                                name: 'Quản lý hợp đồng',
                                icon: "assets/icon_host/quan-ly-hop-dong.png",
                                onTap: () {
                                  Get.to(() => ContractScreen(
                                        initTab: 1,
                                      ));
                                }),
                          ),
                          optionProfile(
                              badge: dataAppController
                                  .badge.value.totalQuantityBillManage,
                              name: 'Quản lý hoá đơn',
                              icon: "assets/icon_host/quan-ly-hoa-don.png",
                              onTap: () {
                                Get.to(() => BillScreen());
                              }),
                          optionProfile(
                              name: 'Báo cáo thống kê',
                              icon: "assets/icon_host/bao-cao-thong-ke.png",
                              onTap: () {
                                Get.to(() => ReportScreenManage());
                              }),
                          optionProfile(
                              badge: dataAppController
                                  .badge.value.totalReservationMotelNotConsult,
                              icon: "assets/icon_host/giu-cho.png",
                              name: 'Giữ chỗ',
                              onTap: () {
                                Get.to(
                                    () => const ReservationMotelHostScreen());
                              }),
                          optionProfile(
                              name: 'Quản lý hoa hồng',
                              icon: "assets/icon_host/quan-ly-hoa-hong.png",
                              onTap: () {
                                Get.to(() => const CommissionManageScreen());
                              }),
                          optionProfile(
                              icon:
                                  "assets/icon_admin/quan-ly-don-hang-dich-vu.png",
                              name: "Quản lý đơn hàng dịch vụ",
                              onTap: () {
                                Get.to(() => OrdersScreen());
                              }),
                          optionProfile(
                              name: 'Báo cáo sự cố',
                              icon: "assets/icon_host/bao-cao-su-co.png",
                              badge: dataAppController
                                  .badge.value.totalProblemNotDoneManage,
                              onTap: () {
                                Get.to(() => ProblemOwnerScreen());
                              }),
                          optionProfile(
                              name: 'Quản lý dịch vụ chung',
                              icon: "assets/icon_host/dich_vu_chung.png",
                              onTap: () {
                                Get.to(() => ServiceScreen());
                              }),
                          optionProfile(
                              name: 'Phân quyền quản lý',
                              icon: "assets/icon_admin/phan_quyen_quan_ly.png",
                              onTap: () {
                                Get.to(() => TowerManagerScreen());
                              }),
                          optionProfile(
                              name: 'Đăng xuất',
                              icon: "assets/icon_host/dang-xuat.png",
                              onTap: () {
                                SahaDialogApp.showDialogYesNo(
                                    mess: 'Bạn chắc chắn muốn đăng xuất chứ ?',
                                    onClose: () {},
                                    onOK: () {
                                      UserInfo().logout();
                                    });
                              }),
                        ],
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          SahaDialogApp.showDialogYesNo(
                              mess:
                                  "Tài khoản của bạn sẽ được xoá sau khoảng thời gian 1 ngày, trong thời gian này bạn có thể huỷ kích hoạt xoá tài khoản bằng cách đăng nhập lại!",
                              onOK: () {
                                UserInfo().logout();
                              });
                        },
                        child: Text(
                          "Yêu cầu xoá tài khoản",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.grey[500]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "© 2022 GOHOMY JSC ${UserInfo().getIsRelease() == null ? "" : "(DEV)"}",
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    ),
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.only(
                          top: 5, right: 10, bottom: 20, left: 10),
                      child: Center(
                        child: Text(
                          "version ${dataAppController.packageInfo.value.version} - Build ${dataAppController.packageInfo.value.buildNumber}",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget option({
    required String image,
    required String name,
    required Function onTap,
    int? badge,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: Get.width / 3.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 5,
              ),
              //padding: EdgeInsets.all(10),
              child: b.Badge(
                showBadge: badge == null || badge == 0 ? false : true,
                badgeContent: Text(
                  badge.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                ),
                const SizedBox(
                  width: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget usersProfile() {
    return CheckLoginWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  Container(
                    height: Get.height / 2.9,
                    width: Get.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: <Color>[Colors.deepOrange, Colors.orange]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              top: 30,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ConfigUserScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 3, bottom: 3, right: 10, left: 10),
                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            )),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Chuyển tài khoản',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              'assets/icon/refresh.svg',
                              height: 15,
                              width: 15,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => EditProfileUser(
                                    user: dataAppController.badge.value.user!,
                                  ));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: CachedNetworkImage(
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                imageUrl: dataAppController
                                        .badge.value.user?.avatarImage ??
                                    "",
                                // placeholder: (context, url) =>
                                //     SahaLoadingWidget(),
                                errorWidget: (context, url, error) =>
                                    const SahaEmptyAvata(
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Xin chào',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            dataAppController
                                                    .badge.value.user?.name ??
                                                "",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 1,
                                          ),
                                          if (dataAppController.badge.value.user
                                                  ?.cmndNumber !=
                                              null)
                                            const Icon(Icons.check_circle,
                                                color: Colors.blueAccent)
                                        ],
                                      ),
                                      dataAppController.currentUser.value
                                                  .cmndNumber ==
                                              null
                                          ? Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                ActivedButton(
                                                  title: 'Kích hoạt',
                                                  onTap: () => Get.to(() =>
                                                      const ProfileDetailsPage()),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                              ],
                                            )
                                          : SummaryTile(
                                              goldCoinText:
                                                  '${dataAppController.currentUser.value.goldenCoins} Xu vàng',
                                              silverCoinText:
                                                  '${dataAppController.currentUser.value.silverCoins} Xu bạc',
                                              onTap: () => Get.to(
                                                  () => DepositWithdrawPage(
                                                        silverCoins:
                                                            dataAppController
                                                                .currentUser
                                                                .value
                                                                .silverCoins,
                                                        goldenCoins:
                                                            dataAppController
                                                                .currentUser
                                                                .value
                                                                .goldenCoins,
                                                      )),
                                            )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.to(() => const HelpScreen());
                                      },
                                      icon: const Icon(
                                        Icons.headset_mic_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    const Text(
                                      "Trợ giúp",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() => dataAppController.currentUser.value.accountRank ==
                            1
                        ? Container(
                            width: Get.width,
                            height: 135,
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...(homeController.homeApp.value
                                              .listCategoryServiceSell ??
                                          [])
                                      .map(
                                        (e) => InkWell(
                                          onTap: () {
                                            Get.to(() => ProductUserScreen(
                                                  categoryId: e.id,
                                                ));
                                            // Get.to(() =>
                                            //     ServiceSellUserScreen(
                                            //         id: e.id));
                                          },
                                          child: SizedBox(
                                            width: (Get.width - 20) / 4.5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  child: CachedNetworkImage(
                                                    height: 50,
                                                    width: 50,
                                                    fit: BoxFit.cover,
                                                    imageUrl: e.image ?? '',
                                                    placeholder:
                                                        (context, url) =>
                                                            SahaLoadingWidget(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const SahaEmptyImage(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5, right: 5),
                                                  child: Text(
                                                    e.name ?? '',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      height: 1.2,
                                                      letterSpacing: 0.1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox()),
                    Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(
                                1, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Obx(
                        () => Column(
                          children: [
                            optionProfile(
                                name: 'Quản lý bài đăng',
                                icon: "assets/icon_host/quan-ly-phong.png",
                                onTap: () {
                                  Get.to(() => CustomerPostScreen());
                                }),
                            optionProfile(
                                icon:
                                    "assets/icon_admin/quan-ly-don-hang-dich-vu.png",
                                name: "Quản lý đơn hàng dịch vụ",
                                onTap: () {
                                  Get.to(() => OrdersScreen());
                                }),
                            if (dataAppController
                                    .currentUser.value.accountRank ==
                                1)
                              optionProfile(
                                  name: 'Giỏ hàng',
                                  icon: "assets/icon_user/gio-hang.png",
                                  onTap: () {
                                    Get.to(() => CartScreen());
                                  }),
                            if (dataAppController
                                    .currentUser.value.accountRank ==
                                1)
                              optionProfile(
                                  badge: dataAppController
                                      .badge.value.totalQuantityProblemNotDone,
                                  name: 'Báo cáo sự cố',
                                  icon: "assets/icon_user/bao-cao-su-co.png",
                                  onTap: () {
                                    Get.to(() => ProblemScreen());
                                  }),
                            if (dataAppController
                                    .currentUser.value.accountRank ==
                                1)
                              optionProfile(
                                  badge: dataAppController
                                      .badge.value.totalQuantityBillsNeedPaid,
                                  name: 'Hoá đơn',
                                  icon: "assets/icon_user/hoa-don.png",
                                  onTap: () {
                                    Get.to(() => const UserBillScreen());
                                  }),
                            optionProfile(
                                badge: dataAppController
                                    .badge.value.totalQuantityContractPending,
                                name: 'Hợp đồng',
                                icon: "assets/icon_user/hop-dong.png",
                                onTap: () {
                                  Get.to(() => ContractUserScreen());
                                }),
                            optionProfile(
                                name: 'Bài đăng đã lưu',
                                icon: "assets/icon_user/bai-dang-da-luu.png",
                                onTap: () {
                                  Get.to(() => const FavouriteScreen());
                                }),
                            if (dataAppController
                                    .currentUser.value.accountRank ==
                                1)
                              optionProfile(
                                  name: 'Ví cộng tác viên',
                                  icon: "assets/icon_user/vi-cong-tac-vien.png",
                                  onTap: () {
                                    Get.to(() => const WalletHistoryScreen());
                                  }),
                            optionProfile(
                                name: 'Đăng xuất',
                                icon: "assets/icon_user/dang-xuat.png",
                                onTap: () {
                                  SahaDialogApp.showDialogYesNo(
                                      mess:
                                          'Bạn chắc chắn muốn đăng xuất chứ ?',
                                      onClose: () {},
                                      onOK: () {
                                        UserInfo().logout();
                                      });
                                }),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          SahaDialogApp.showDialogYesNo(
                              mess:
                                  "Tài khoản của bạn sẽ được xoá sau khoảng thời gian 1 ngày, trong thời gian này bạn có thể huỷ kích hoạt xoá tài khoản bằng cách đăng nhập lại!",
                              onOK: () {
                                UserInfo().logout();
                              });
                        },
                        child: Text(
                          "Yêu cầu xoá tài khoản",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.grey[500]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "© 2022 RENCITY JSC ${UserInfo().getIsRelease() == null ? "" : "(DEV)"}",
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    ),
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.only(
                          top: 5, right: 10, bottom: 20, left: 10),
                      child: Center(
                        child: Text(
                          "version ${dataAppController.packageInfo.value.version} - Build ${dataAppController.packageInfo.value.buildNumber}",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
