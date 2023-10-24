import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/wallet_histories.dart';
import 'package:gohomy/screen/profile/e_wallet_histories/e_wallet_histories_controller.dart';
import 'package:gohomy/screen/profile/e_wallet_histories/request_withdrawals_histories/withdrawal_histories_screen.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/dialog/dialog.dart';
import '../../../utils/string_utils.dart';
import '../../data_app_controller.dart';

class WalletHistoryScreen extends StatefulWidget {
  const WalletHistoryScreen({super.key});

  @override
  State<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends State<WalletHistoryScreen> {
  ScrollController scrollController = ScrollController();
  bool isScroll = false;
  RefreshController refreshController = RefreshController();
  EWalletHistoriesController eWalletHistoriesController =
      EWalletHistoriesController();
  DataAppController dataAppController = Get.find();
  @override
  void initState() {
    scrollController.addListener(listenToScrollChange);
    super.initState();
  }

  void listenToScrollChange() {
    if (scrollController.offset >= 120) {
      eWalletHistoriesController.isScroll.value = true;
    } else {
      eWalletHistoriesController.isScroll.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => eWalletHistoriesController.loadInit.value
          ? SahaLoadingFullScreen()
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
                    body = Obx(() => eWalletHistoriesController.isLoading.value
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
                await eWalletHistoriesController.getAllWalletHistories(
                    isRefresh: true);
                refreshController.refreshCompleted();
              },
              onLoading: () async {
                await eWalletHistoriesController.getAllWalletHistories();
                refreshController.loadComplete();
              },
              controller: refreshController,
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: Get.height / 3.5,
                    elevation: 0,
                    stretch: true,
                    pinned: true,
                    toolbarHeight: 80,
                    backgroundColor: Colors.deepOrange,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                    title: AnimatedOpacity(
                      opacity:
                          eWalletHistoriesController.isScroll.value ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: Column(
                        children: [
                          Obx(
                            () => Text(
                              '\$ ${SahaStringUtils().convertToMoney(dataAppController.currentUser.value.eWalletCollaborator?.accountBalance ?? "0")} đ',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 4,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade800),
                          )
                        ],
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      title: AnimatedOpacity(
                        opacity:
                            eWalletHistoriesController.isScroll.value ? 0 : 1,
                        duration: const Duration(microseconds: 300),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            const Text(
                              'Tiền trong ví',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '\$',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey.shade50),
                                ),
                                Text(
                                  '${SahaStringUtils().convertToMoney(dataAppController.currentUser.value.eWalletCollaborator?.accountBalance ?? "0")} đ',
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            SahaDialogApp.showDialogInput(
                              isNumber: true,
                              onInput: (v) {
                                if (v == '') {
                                  SahaAlert.showError(
                                      message: 'Vui lòng nhập số tiền');
                                  return;
                                }

                                eWalletHistoriesController.money = double.parse(
                                    SahaStringUtils().convertFormatText(v));
                                eWalletHistoriesController.requestWithdrawal();
                              },
                              title: 'Nhập số tiền muốn rút',
                            );
                          },
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/cash-withdrawal.svg',
                                width: 50,
                                height: 50,
                              ),
                              const Text('Yêu cầu rút tiền')
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => WithdrawalHistoriesScreen());
                          },
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/cash-withdrawal.svg',
                                width: 50,
                                height: 50,
                              ),
                              const Text('Lịch sử rút tiền')
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.orange,
                                Colors.deepOrange,
                              ]),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Lịch sử giao dịch',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ])),
                  SliverFillRemaining(
                      child: Container(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ...eWalletHistoriesController.listWallet
                              .map((element) => itemHistory(element))
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
    ));
  }

  Widget itemHistory(WalletHistory walletHistory) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(8),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  walletHistory.title ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                if (walletHistory.createdAt != null)
                  Text(
                      DateFormat('dd-MM-yyyy').format(walletHistory.createdAt!))
              ],
            ),
            const Divider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text('Số tiền trước đó :'),
            //     Text(
            //         '${SahaStringUtils().convertToMoney(walletHistory.balanceOrigin ?? '0')} đ'),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Số tiền thay đổi :'),
                walletHistory.takeOutMoney == true
                    ? Text(
                        '- ${SahaStringUtils().convertToMoney(walletHistory.moneyChange ?? "0")} đ',
                        style: const TextStyle(color: Colors.red),
                      )
                    : Text(
                        '+ ${SahaStringUtils().convertToMoney(walletHistory.moneyChange ?? "0")} đ',
                        style: const TextStyle(color: Colors.green)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tổng tiền sau cùng :'),
                Text(
                  '${SahaStringUtils().convertToMoney(walletHistory.accountBalanceChanged ?? "0")} đ',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                )
              ],
            ),
            if (walletHistory.userReferral != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(walletHistory.typeMoneyfrom == 0
                      ? 'Tên người được giới thiệu :'
                      : 'Tên người giới thiệu'),
                  Text(walletHistory.userReferral?.name ?? ''),
                ],
              ),
            if (walletHistory.userReferred != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(walletHistory.typeMoneyfrom == 0
                      ? 'Tên người được giới thiệu :'
                      : 'Tên người giới thiệu'),
                  Text(walletHistory.userReferred?.name ?? ''),
                ],
              ),
            const SizedBox(
              height: 4,
            ),
            Text(
              walletHistory.description ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
