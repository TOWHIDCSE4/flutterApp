import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_widget.dart';
import 'package:gohomy/screen/profile/wallet_admin_review/wallet_admin_review.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import './wallet_admin_controller.dart';

class WalletWithdrawHistory extends StatefulWidget {
  WalletWithdrawHistory({super.key}) {
    walletAdminController = Get.find<WalletAdminController>();
  }

  late WalletAdminController walletAdminController;

  @override
  State<WalletWithdrawHistory> createState() => _WalletWithdrawHistoryState();
}

class _WalletWithdrawHistoryState extends State<WalletWithdrawHistory> {
  bool isLoading = true;
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    getWithdrawInfo();
    super.initState();
  }

  Future<void> getWithdrawInfo() async {
    await widget.walletAdminController.getListWithdraws(isRefresh: true);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: isLoading
              ? SahaLoadingWidget()
              : widget.walletAdminController.listWithdraws.isEmpty
                  ? const Center(
                      child: Text('Chưa có giao dịch nào'),
                    )
                  : SmartRefresher(
                      header: const MaterialClassicHeader(),
                      footer: CustomFooter(
                        builder: (
                          BuildContext context,
                          LoadStatus? mode,
                        ) {
                          Widget body = Container();
                          if (mode == LoadStatus.idle) {
                            body = Obx(() =>
                                widget.walletAdminController.isLoadingWithdraw.value
                                    ? const CupertinoActivityIndicator()
                                    : Container());
                          } else if (mode == LoadStatus.loading) {
                            body = const CupertinoActivityIndicator();
                          }
                          return SizedBox(
                            height: 100,
                            child: Center(child: body),
                          );
                        },
                      ),
                      controller: refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () async {
                        await widget.walletAdminController
                            .getListWithdraws(isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await widget.walletAdminController.getListWithdraws();
                        refreshController.loadComplete();
                      },
                      child: ListView.separated(
                        clipBehavior: Clip.none,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(15),
                        itemCount:
                            widget.walletAdminController.listWithdraws.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          return WalletHistoryCard(
                            transactionId: widget.walletAdminController.listWithdraws[index].id,
                            amountStr: SahaStringUtils().convertToMoney(widget
                                    .walletAdminController
                                    .listWithdraws[index]
                                    .withdrawAmount ??
                                0),
                            bankAccountNumber: widget.walletAdminController
                                .listWithdraws[index]?.accountNumber,
                            bankName: widget.walletAdminController
                                .listWithdraws[index]?.bankName,
                            fromOrTo: widget
                                    .walletAdminController
                                    .listWithdraws[index]
                                    ?.bankAccountHolderName ??
                                "",
                            content: widget.walletAdminController
                                    .listWithdraws[index]?.withdrawContent ??
                                "",
                            dateTimeStr: widget.walletAdminController
                                    .listWithdraws[index]?.withdrawDate ??
                                "",
                            isDeposit: false,
                            status: widget.walletAdminController
                                .listWithdraws[index]?.status,
                            completed: widget.walletAdminController
                                .listWithdraws[index]?.status != 'PROGRESSING',
                          );
                        },
                      ),
                    ),
        ),
      ],
    );
  }
}
