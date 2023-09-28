import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/admin/post/post_details/post_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/remote/response-request/admin_manage/all_history_receive_commission_res.dart';
import '../../../utils/call.dart';
import '../../../utils/string_utils.dart';
import 'history_receive_commission_controller.dart';

class HistoryReceiveCommissionScreen extends StatelessWidget {
  HistoryReceiveCommissionScreen({super.key});

  HistoryReceiveCommissionController historyCommissionController =
      HistoryReceiveCommissionController();
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(titleText: 'Lịch sử nhận tiền hoa hồng'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => historyCommissionController.loadInit.value
              ? SahaLoadingFullScreen()
              : historyCommissionController.listHistoryReceive.isEmpty
                  ? const Center(
                      child: Text('Chưa có thông tin'),
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
                                historyCommissionController.isLoading.value
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
                      onRefresh: () async {
                        await historyCommissionController
                            .getAllHistoryReceiveCommission(isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await historyCommissionController
                            .getAllHistoryReceiveCommission();
                        refreshController.loadComplete();
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...historyCommissionController.listHistoryReceive
                                .map((element) => itemHistory(element))
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  Widget itemHistory(HistoryReceiveCommission historyReceiveCommission) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Tên chủ nhà : ${historyReceiveCommission.host?.name ?? ''}'),
                      Text(
                        ' + ${SahaStringUtils().convertToMoney(historyReceiveCommission.moneyCommissionAdmin ?? "0")} đ',
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Từ bài đăng : '),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.to(() => PostDetailsScreen(
                                  id: historyReceiveCommission.moPost!.id!,
                                ));
                          },
                          child: Text(
                            historyReceiveCommission.moPost?.title ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Số điện thoại: '),
                      const SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          Call.call(
                              historyReceiveCommission.moPost?.phoneNumber ??
                                  '');
                        },
                        child: Text(
                          historyReceiveCommission.moPost?.phoneNumber ??
                              'Chưa có thông tin',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Ngày nhận : '),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(DateFormat('dd-MM-yyyy')
                          .format(historyReceiveCommission.createdAt!)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
