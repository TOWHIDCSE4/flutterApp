import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/report/commission/report_commission_screen.dart';
import 'package:gohomy/screen/admin/report/report_screen.dart';
import 'package:gohomy/screen/admin/report_post_violation/report_post_violation_screen.dart';
import 'package:gohomy/screen/admin/reservation_admin_motel/reservation_motel_admin_screen.dart';
import 'package:gohomy/screen/data_app_controller.dart';

import '../owner/report/report_screen.dart';

class ReportTotal extends StatelessWidget {
  ReportTotal({Key? key}) : super(key: key);
  DataAppController dataAppController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // begin: Alignment.bottomLeft,
                  // end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
          title: const Text('Báo cáo thống kê')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          option(
              badgeAdmin: dataAppController
                  .badge.value.totalReservationMotelNotConsultAdmin,
              badge:
                  dataAppController.badge.value.totalReservationMotelNotConsult,
              image: 'assets/icon_host/bao-cao-thong-ke.png',
              name: 'Giữ chỗ',
              onTap: () {
                Get.to(() => const ReservationMotelAdminScreen());
              }),
          option(
              badge: dataAppController
                  .badge.value.totalQuantityReportViolationPostProgressingAdmin,
              image: 'assets/icon_host/bao-cao-thong-ke.png',
              name: 'Báo cáo vi phạm',
              onTap: () {
                Get.to(() => const ReportPostViolationScreen());
              }),
          option(
              image: 'assets/icon_host/bao-cao-thong-ke.png',
              name: 'Thống kê',
              onTap: () {
                Get.to(() => ReportScreen());
              }),
          option(
              image: 'assets/icon_host/bao-cao-thong-ke.png',
              name: 'Thống kê (bản thân)',
              onTap: () {
                Get.to(() => ReportScreenManage());
              }),
          option(
              image: 'assets/icon_host/bao-cao-thong-ke.png',
              name: 'Thống kê thu chi hoa hồng',
              onTap: () {
                Get.to(() => ReportCommissionScreen());
              }),
        ],
      ),
    );
  }

  Widget option(
      {required String image,
      required String name,
      required Function onTap,
      int? badge,
      int? badgeAdmin}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          SizedBox(
            width: Get.width,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    image,
                    height: 40,
                    width: 40,
                  ),
                ),
                Text(
                  name,
                  textAlign: TextAlign.center,
                ),
                if (badge != null && badge != 0)
                  Text(
                    '($badge)',
                    style: const TextStyle(color: Colors.green),
                  ),
                if (badgeAdmin != null && badgeAdmin != 0)
                  Text(
                    '($badgeAdmin)',
                    style: const TextStyle(color: Colors.deepOrange),
                  )
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
