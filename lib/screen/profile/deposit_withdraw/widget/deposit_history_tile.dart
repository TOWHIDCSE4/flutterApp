import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_container.dart';
import 'package:gohomy/components/loading/loading_widget.dart';
import 'package:gohomy/model/deposit.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/deposit_withdraw_controller.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'history_card_tile.dart';
import '../data/deposit_withdraw_repository.dart';

class DepositHistoryTile extends StatefulWidget {
  const DepositHistoryTile({
    super.key,
  });

  @override
  State<DepositHistoryTile> createState() => _DepositHistoryTileState();
}

class _DepositHistoryTileState extends State<DepositHistoryTile> {
  bool isLoading = true;
  DepositWithdrawController depositWithdrawController = Get.find<DepositWithdrawController>();

  @override
  void initState() {
    depositWithdrawController.getListDeposits(isRefresh: true);
    setState(() {
      isLoading = false;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SahaLoadingWidget()
        : Obx(() => ListView.builder(
            itemCount: depositWithdrawController.listDeposits.value.length ?? 0,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              var deposit = depositWithdrawController.listDeposits.value?[index];
              return HistoryCardTile(
                amount: SahaStringUtils().convertToMoney(deposit?.depositAmount ?? 0),
                from: 'Từ: ${deposit?.accountNumber}',
                content: 'ND: ${deposit?.depositContent} ',
                // subContent: deposit?.accountNumber ?? "",
                dateTime: deposit?.depositDate ?? "",
              );
            },
          )
    );
  }
}
