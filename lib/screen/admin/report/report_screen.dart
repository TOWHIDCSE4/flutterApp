import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/report/post/post_report_screen.dart';
import 'package:gohomy/screen/admin/report/potential_to_renter/report_potential_to_renter_screen.dart';
import 'package:gohomy/screen/admin/report/renter_has_motel/report_renter_has_motel_screen.dart';
import 'package:gohomy/screen/admin/report/user_did_kyc/user_did_kyc_screen.dart';

import 'bill/report_bill_screen.dart';
import 'contract/report_contract_screen.dart';
import 'order/order_report_screen.dart';
import 'overview/overview_screen.dart';
import 'potential/report_potential_screen.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        title: const Text('Thống kê'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Thống kê dịch vụ bán'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => OrderReportScreen());
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Thống kê bài đăng'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => PostReportScreen());
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text(
                    'Thống kê người thuê, phòng, giữ chỗ, tìm phòng nhanh'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => OverviewReportScreen());
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Thống kê khách hàng tiềm năng'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => ReportPotentialScreen());
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Thống kê hợp đồng'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => ReportContractScreen());
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Thống kê hoá đơn'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => ReportBillScreen());
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text(
                    'Thống kê người thuê tiềm năng thành người thuê'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => ReportPotentialToRenterScreen());
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Thống kê người thuê được gán phòng'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => ReportRenterHasMotelScreen());
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Thống kê người đã xác minh danh tính'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => ReportUserDidKycScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
