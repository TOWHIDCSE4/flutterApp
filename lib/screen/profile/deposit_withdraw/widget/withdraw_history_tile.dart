import 'package:flutter/material.dart';
import 'package:gohomy/components/loading/loading_widget.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/model/withdraw.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/deposit_withdraw_controller.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:get/get.dart';

import '../data/deposit_withdraw_repository.dart';
import 'history_card_tile.dart';

class WithdrawHistoryTile extends StatefulWidget {
  const WithdrawHistoryTile({
    super.key,
  });
  @override
  State<WithdrawHistoryTile> createState() => _WithdrawHistoryTileState();
}

class _WithdrawHistoryTileState extends State<WithdrawHistoryTile> {
  bool isLoading = true;
  DepositWithdrawController depositWithdrawController = Get.find<DepositWithdrawController>();

  @override
  void initState() {
    depositWithdrawController.getListWithdraws(isRefresh: true);
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
            itemCount: depositWithdrawController.listWithdraws.value.length ?? 0,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              var withdraw = depositWithdrawController.listWithdraws.value?[index];
              return HistoryCardTile(
                amount: SahaStringUtils().convertToMoney(withdraw?.withdrawAmount ?? 0),
                amountColor: AppColor.red,
                from: 'Từ: ${withdraw?.bankAccountHolderName}',
                content: 'ND: ${withdraw?.withdrawContent}',
                dateTime: withdraw?.withdrawDate ?? "",
              );
            },
          ));
  }
}
