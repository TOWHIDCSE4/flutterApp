import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gohomy/components/loading/loading_container.dart';
import 'package:gohomy/model/request_withdrawals.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/profile/e_wallet_histories/request_withdrawals_histories/withdrawal_detail/withdrawal_detail_screen.dart';
import 'package:gohomy/screen/profile/e_wallet_histories/request_withdrawals_histories/withdrawal_histories_controller.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../utils/string_utils.dart';

class WithdrawalHistoriesScreen extends StatelessWidget {
  WithdrawalHistoriesScreen({super.key});

  WithdrawalHistoriesController withdrawalHistoriesController =
      WithdrawalHistoriesController();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lịch sử rút tiền')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => withdrawalHistoriesController.loadInit.value
              ? const SahaLoadingContainer()
              : withdrawalHistoriesController.listWithdrawal.isEmpty
                  ? const Center(
                      child: Text('Chưa có lịch sử rút tiền'),
                    )
                  : SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const MaterialClassicHeader(),
                      footer: CustomFooter(
                        builder: (
                          BuildContext context,
                          LoadStatus? mode,
                        ) {
                          Widget body = Container();
                          if (mode == LoadStatus.idle) {
                            body = Obx(() =>
                                withdrawalHistoriesController.isLoading.value
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
                      onRefresh: () async {
                        await withdrawalHistoriesController
                            .getAllRequestWithdrawal(isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await withdrawalHistoriesController
                            .getAllRequestWithdrawal();
                        refreshController.loadComplete();
                      },
                      controller: refreshController,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...withdrawalHistoriesController.listWithdrawal
                                .map((element) => itemWithdrawal(element))
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  Widget itemWithdrawal(RequestWithdrawals requestWithdrawals) {
    return InkWell(
      onTap: () {
        Get.to(() => UserWithdrawalDetailScreen(
                  id: requestWithdrawals.id!,
                ))!
            .then((value) => withdrawalHistoriesController
                .getAllRequestWithdrawal(isRefresh: true));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: requestWithdrawals.status == 0
                      ? Colors.deepOrange
                      : requestWithdrawals.status == 1
                          ? Colors.grey
                          : Colors.green,
                ),
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Trạng thái yêu cầu : ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                        requestWithdrawals.status == 0
                            ? 'Chưa hoàn thành'
                            : requestWithdrawals.status == 1
                                ? 'Đã bị huỷ'
                                : 'Đã hoàn thành',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Số tiền yêu cầu thanh toán :'),
                    Text(
                        '${SahaStringUtils().convertToMoney(requestWithdrawals.amountMoney ?? '0')} đ')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Ngày yêu cầu :'),
                    Text(
                        DateFormat('dd-MM-yyyy').format(requestWithdrawals.createdAt!)),
                  ],
                ),
              ),
              if (requestWithdrawals.dateWithdrawalApproved != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Ngày xác nhận :'),
                      Text(
                          DateFormat('dd-MM-yyyy').format(requestWithdrawals.dateWithdrawalApproved!)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
