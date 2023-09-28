import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/admin_controller.dart';
import 'package:gohomy/screen/admin/contact/admin_contact_screen.dart';
import 'package:gohomy/screen/admin/motel_room_admin/admin_motel_room_screen.dart';
import 'package:gohomy/screen/admin/post/post_screen.dart';
import 'package:gohomy/screen/admin/report/report_screen.dart';
import 'package:gohomy/screen/admin/report_post_violation/report_post_violation_screen.dart';
import 'package:gohomy/screen/admin/service_sell/service_sell_screen.dart';
import 'package:gohomy/screen/admin/support/support_screen.dart';
import 'package:gohomy/screen/admin/ui_mangage/ui_manage_screen.dart';
import 'package:gohomy/screen/admin/users/users_manage_screen.dart';
import '../data_app_controller.dart';
import 'find_fast_motel/find_fast_motel_screen.dart';
import 'reservation_admin_motel/reservation_motel_admin_screen.dart';
import 'service_sell/orders/orders_admin_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  AdminController adminController = AdminController();
  DataAppController dataAppController = Get.find();

  @override
  void initState() {
    adminController.getAdminBadges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin')),
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
                                Text(
                                  "${adminController.adminBadges.value.totalMotel ?? ""}",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Số users",
                                ),
                                Text(
                                  "${adminController.adminBadges.value.totalUser ?? ""}",
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
                                const Text("Tổng số người thuê"),
                                Text(
                                  "${adminController.adminBadges.value.totalRenter ?? ""}",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text("Số hợp đồng còn hiệu lực"),
                                Text(
                                  "${adminController.adminBadges.value.totalContractActive ?? ""}",
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
                                const Text("Số hợp đồng chưa duyệt"),
                                Text(
                                  "${adminController.adminBadges.value.totalContractPending ?? ""}",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text("Số người thuê có phòng"),
                                Text(
                                  "${adminController.adminBadges.value.totalRenterHasMotel ?? ""}",
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
              Container(
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
                        Get.to(() => AdminMotelRoomScreen());
                      },
                      image: "assets/checklist.svg",
                    ),
                    option(
                      name: "Quản lý người dùng",
                      onTap: () {
                        Get.to(() => const UserManageSceen());
                      },
                      image: "assets/user.svg",
                    ),
                    option(
                      name: "Dịch vụ bán",
                      onTap: () {
                        Get.to(() => const ServiceSellScreen());
                      },
                      image: "assets/service_sell.svg",
                    ),
                    option(
                      name: "Đơn hàng",
                      onTap: () {
                        Get.to(() => OrdersAdminScreen());
                      },
                      image: "assets/ui_manage.svg",
                    ),
                    option(
                      name: "Quản lý bài đăng",
                      onTap: () {
                        Get.to(() => const PostScreen());
                      },
                      image: "assets/icon_service/social-media.svg",
                    ),
                    option(
                      name: "Quản lý giao diện",
                      onTap: () {
                        Get.to(() => const UIManage());
                      },
                      image: "assets/ui_manage.svg",
                    ),
                    option(
                      name: "Liên hệ",
                      onTap: () {
                        Get.to(() => const AdminContactScreen());
                      },
                      image: "assets/contact.svg",
                    ),
                    option(
                      name: "Bài viết hỗ trợ",
                      onTap: () {
                        Get.to(() => const SupportScreen());
                      },
                      image: "assets/support.svg",
                    ),
                    option(
                      name: "Hỗ trợ tìm phòng nhanh",
                      onTap: () {
                        Get.to(() => const FindFastMotelScreen());
                      },
                      image: "assets/support.svg",
                    ),
                    option(
                      name: "Giữ chỗ",
                      onTap: () {
                        Get.to(() => const ReservationMotelAdminScreen());
                      },
                      image: "assets/support.svg",
                    ),
                    option(
                      name: "Báo cáo vi phạm",
                      onTap: () {
                        Get.to(() => const ReportPostViolationScreen());
                      },
                      image: "assets/report.svg",
                    ),
                    option(
                      name: "Thống kê",
                      onTap: () {
                        Get.to(() => ReportScreen());
                      },
                      image: "assets/report.svg",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget option(
      {required String image, required String name, required Function onTap}) {
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
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                image,
                height: 40,
                width: 40,
              ),
            ),
            Text(
              name,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
