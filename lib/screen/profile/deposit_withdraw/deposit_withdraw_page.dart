import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/deposit/deposit_entry_page.dart';

import 'widget/banner_tile.dart';
import 'widget/paginator.dart';
import 'widget/tabbar_tile.dart';
import 'widget/transaction_entry_navigation_tile.dart';
import 'withdraw/withdraw_entry_page.dart';

class DepositWithdrawPage extends StatelessWidget {
  DepositWithdrawPage({
    super.key,
    this.initialIndex = 0,
    this.goldenCoins,
    this.silverCoins,
  });
  final int initialIndex;
  final num? goldenCoins;
  final num? silverCoins;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            BannerTile(
              goldenCoins: goldenCoins,
              silverCoins: silverCoins,
            ),
            TransactionEntryNavigationTile(
              onTapDeposit: () => Get.to(() => const DepositEntryPage()),
              onTapWithdraw: () => Get.to(() => WithdrawEntryPage()),
            ),
            const SizedBox(height: 16),
            TabbarTile(
              initialIndex: initialIndex,
            ),
          ],
        ),
      ),
    );
  }
}