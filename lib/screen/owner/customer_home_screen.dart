import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/profile/bill/bill_screen.dart';
import '../../model/motel_post.dart';
import '../data_app_controller.dart';
import '../find_room/room_information/room_information_screen.dart';
import 'contract/contract_screen.dart';
import 'motel_room/list_motel_room_screen.dart';
import 'post_management/list_post_management_screen.dart';
import 'problem_owner/problem_owner_screen.dart';
import 'report/report_screen.dart';
import 'reservation_motel/reservation_motel_host_screen.dart';
import 'service/service_screen.dart';
import 'renters/renter_screen.dart';
import 'customer_home_controller.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);
  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  CustormerHomeController custormerHomeController = CustormerHomeController();

  DataAppController dataAppController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Obx(
                  () => Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Số phòng",
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${custormerHomeController.summary.value.totalMotel ?? ""}",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Số phòng đã thuê",
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${custormerHomeController.summary.value.totalMotelRented ?? ""}",
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
                                const Text("Số người thuê"),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${custormerHomeController.summary.value.totalRenter ?? ""}",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text("Số phòng trống"),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${custormerHomeController.summary.value.totalMotelAvailable ?? ""}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 5,
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runSpacing: 30,
                    children: [
                      option(
                        name: "Quản lý phòng",
                        onTap: () {
                          Get.to(() => ListMotelRoomScreen())!.then(
                              (value) => custormerHomeController.getSummary());
                        },
                        image: "assets/checklist.svg",
                      ),
                      option(
                        badge: dataAppController
                            .badge.value.totalContractPendingManage,
                        name: "Hợp đồng",
                        onTap: () {
                          Get.to(() => ContractScreen());
                        },
                        image: "assets/contract.svg",
                      ),
                      option(
                        badge: dataAppController
                            .badge.value.totalProblemNotDoneManage,
                        name: "Báo cáo sự cố",
                        onTap: () {
                          Get.to(() => ProblemOwnerScreen());
                        },
                        image: "assets/service.svg",
                      ),
                      option(
                        badge: dataAppController
                            .badge.value.totalQuantityBillManage,
                        name: "Hoá đơn",
                        onTap: () {
                          Get.to(() => BillScreen());
                        },
                        image: "assets/bill.svg",
                      ),
                      option(
                        name: "Dịch vụ",
                        onTap: () {
                          Get.to(() => ServiceScreen());
                        },
                        image: "assets/cutlery.svg",
                      ),
                      option(
                        name: "Người thuê",
                        onTap: () {
                          Get.to(() => RenterScreen())!.then(
                              (value) => custormerHomeController.getSummary());
                        },
                        image: "assets/renter.svg",
                      ),
                      option(
                        name: "Quản lý bài đăng",
                        onTap: () {
                          Get.to(() => ListPostManagementScreen())!
                              .then((value) => {
                                    custormerHomeController
                                        .getAllRoomPost(isRefresh: true)
                                        .then((value) => custormerHomeController
                                            .getSummary())
                                  });
                        },
                        image: "assets/icon_service/social-media.svg",
                      ),
                      option(
                        name: "Thống kê",
                        onTap: () {
                          Get.to(() => ReportScreenManage());
                        },
                        image: "assets/icon_service/social-media.svg",
                      ),
                      option(
                        name: "Giữ chỗ",
                        onTap: () {
                          Get.to(() => const ReservationMotelHostScreen());
                        },
                        image: "assets/support.svg",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget option(
      {required String image,
      required String name,
      required Function onTap,
      int? badge}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: Get.width / 3.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            b.Badge(
              showBadge: badge == null || badge == 0 ? false : true,
              badgeContent: Text(
                '$badge',
                style: const TextStyle(color: Colors.white),
              ),
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 5,
                ),
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  image,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            Text(
              name,
            )
          ],
        ),
      ),
    );
  }

  Widget roomPost({required MotelPost motelPost}) {
    return InkWell(
      onTap: () {
        Get.to(
          () => RoomInformationScreen(
            roomPostId: motelPost.id,
          ),
        );
      },
      child: Container(
        width: Get.width / 1.5,
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Image.network(
                "https://image-us.eva.vn/upload/4-2021/images/2021-10-28/image1-1635408805-678-width600height400.jpg",
                fit: BoxFit.cover,
                width: Get.width,
                height: 150,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                motelPost.title ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5, bottom: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.place_rounded,
                    color: Colors.grey,
                  ),
                  Text(
                    motelPost.addressDetail ?? "",
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.emoji_people_rounded,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Text(
                        motelPost.capacity.toString(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.venusMars,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          motelPost.sex == 0
                              ? "Nam,Nữ"
                              : motelPost.sex == 1
                                  ? "Nam"
                                  : "Nữ",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 5,
                        ),
                        child: Icon(
                          FontAwesomeIcons.unity,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                      Text("${motelPost.area ?? ""} m²"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                motelPost.money.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
