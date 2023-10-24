import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_container.dart';
import 'package:gohomy/components/loading/loading_widget.dart';
import 'package:gohomy/screen/profile/wallet_admin_review/wallet_admin_review.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import './wallet_admin_controller.dart';

class WalletDepositHistory extends StatefulWidget {
  WalletDepositHistory({super.key}) {
    walletAdminController = Get.find<WalletAdminController>();
  }

  late WalletAdminController walletAdminController;

  @override
  State<WalletDepositHistory> createState() => _WalletDepositHistoryState();
}

class _WalletDepositHistoryState extends State<WalletDepositHistory> {
  bool isLoading = true;
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    getDepositInfo();
    super.initState();
  }

  Future<void> getDepositInfo() async {
    await widget.walletAdminController.getListDeposits(isRefresh: true);
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
              : widget.walletAdminController.listDeposits.isEmpty
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
                                widget.walletAdminController.isLoading.value
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
                            .getListDeposits(isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await widget.walletAdminController.getListDeposits();
                        refreshController.loadComplete();
                      },
                      child: ListView.separated(
                        clipBehavior: Clip.none,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(15),
                        itemCount:
                            widget.walletAdminController.listDeposits.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          return WalletHistoryCard(
                            amountStr: SahaStringUtils().convertToMoney(widget
                                    .walletAdminController
                                    .listDeposits[index]
                                    .depositAmount ??
                                0),
                            fromOrTo: widget
                                    .walletAdminController
                                    .listDeposits[index]
                                    .bankAccountHolderName ??
                                "",
                            content: widget.walletAdminController
                                    .listDeposits[index].depositContent ??
                                "",
                            dateTimeStr: widget.walletAdminController
                                    .listDeposits[index].depositDate ??
                                "",
                          );
                        },
                      ),
                    ),
        ),
      ],
    );
  }
}
