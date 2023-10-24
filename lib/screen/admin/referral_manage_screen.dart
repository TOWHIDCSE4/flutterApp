import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/screen/admin/report/commission/report_commission_screen.dart';
import 'package:gohomy/screen/admin/users/referrals/referrals_screen.dart';

import 'admin_withdrawal_manage/admin_withdrawal_screen.dart';
import 'commission_manage_admin/commission_manage_admin_screen.dart';
import 'commission_payment.dart/commission_payment_screen.dart';

class ReferralManageScreen extends StatelessWidget {
  const ReferralManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(titleText: 'Cộng tác viên'),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text('Quản lý cộng tác viên'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Get.to(() => ReferralScreen());
              },
            ),
          ),
          // Card(
          //   child: ListTile(
          //     title: const Text('Lịch sử nhận hoa hồng từ chủ nhà'),
          //     trailing: const Icon(Icons.keyboard_arrow_right),
          //     onTap: () {
          //       Get.to(() => HistoryReceiveCommissionScreen());
          //     },
          //   ),
          // ),
          Card(
            child: ListTile(
              title: const Text('Thống kê thu chi hoa hồng'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Get.to(() => ReportCommissionScreen());
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Quản lý rút tiền cộng tác viên'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Get.to(() => const AdminWithdrawalScreen());
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Quản lý nhận hoa hồng từ chủ nhà'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Get.to(() => const CommissionManageAdminScreen());
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Quản lý trả tiền hoa hồng cho CTV'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Get.to(() => const CommissionPaymentScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
