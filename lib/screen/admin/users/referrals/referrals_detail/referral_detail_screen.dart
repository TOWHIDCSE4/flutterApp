import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';

import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/user.dart';

import 'package:gohomy/screen/admin/users/referrals/referrals_detail/referral_detail_controller.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../components/empty/saha_empty_avatar.dart';
import '../../../../../components/loading/loading_widget.dart';
import '../../../../../model/wallet_histories.dart';
import '../../../../../utils/string_utils.dart';
import '../../user_details/user_details_screen.dart';

class ReferralDetailScreen extends StatefulWidget {
  ReferralDetailScreen({super.key, required this.user});
  User user;
  @override
  State<ReferralDetailScreen> createState() => _ReferralDetailScreenState();
}

class _ReferralDetailScreenState extends State<ReferralDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ReferralDetailController referralDetailController =
      ReferralDetailController();

  RefreshController refreshController = RefreshController();
  RefreshController refreshController1 = RefreshController();
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    referralDetailController.getAllHistoriesCollaborator(
        isRefresh: true, id: widget.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(titleText: 'Chi tiết cộng tác viên'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => UserDetailsScreen(
                      userId: widget.user.id!,
                    ));
              },
              child: Container(
                decoration: const BoxDecoration(),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: CachedNetworkImage(
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                        imageUrl: widget.user.avatarImage == null
                            ? ''
                            : widget.user.avatarImage!,
                        //placeholder: (context, url) => SahaLoadingWidget(),
                        errorWidget: (context, url, error) =>
                            const SahaEmptyAvata(
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.user.name ?? ''),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              color: Colors.deepOrange,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(widget.user.phoneNumber ?? ''),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.email,
                              color: Colors.deepOrange,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(widget.user.email ?? ''),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.money_off,
                              color: Colors.deepOrange,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Tổng tiền : ${SahaStringUtils().convertToMoney(widget.user.balanceAccount ?? "0")} đ',
                            )
                          ],
                        ),
                        const Divider(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 40,
                  width: Get.width - 16,
                  child: TabBar(
                    onTap: (v) {
                      if (v == 1) {
                        referralDetailController.getAllUserReferral(
                            isRefresh: true,
                            code: widget.user.selfReferralCode!);
                      }
                      if (v == 0) {
                        referralDetailController.getAllHistoriesCollaborator(
                            isRefresh: true, id: widget.user.id);
                      }
                    },
                    controller: _tabController,
                    tabs: const [
                      Tab(
                          child: Text('Lịch sử tiền ra vào',
                              style: TextStyle(color: Colors.black))),
                      Tab(
                          child: Text('Danh sách đã giới thiệu',
                              style: TextStyle(color: Colors.black))),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              height: 1,
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                Obx(
                  () => referralDetailController.loadInit1.value
                      ? SahaLoadingFullScreen()
                      : referralDetailController.listWallet.isEmpty
                          ? const Center(
                              child: Text('Chưa có giao dịch'),
                            )
                          : SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: true,
                              header: const MaterialClassicHeader(),
                              onRefresh: () {
                                referralDetailController
                                    .getAllHistoriesCollaborator(
                                        isRefresh: true, id: widget.user.id);
                                refreshController.refreshCompleted();
                              },
                              onLoading: () async {
                                referralDetailController
                                    .getAllHistoriesCollaborator(
                                        id: widget.user.id);
                                refreshController.loadComplete();
                              },
                              footer: CustomFooter(
                                builder: (
                                  BuildContext context,
                                  LoadStatus? mode,
                                ) {
                                  Widget body = Container();
                                  if (mode == LoadStatus.idle) {
                                    body = Obx(() =>
                                        referralDetailController.isLoading.value
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
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ...referralDetailController.listWallet
                                        .map((element) => itemHistory(element))
                                  ],
                                ),
                              ),
                            ),
                ),
                Obx(
                  () => referralDetailController.loadInit.value
                      ? SahaLoadingFullScreen()
                      : referralDetailController.listReferral.isEmpty
                          ? const Center(
                              child: Text('Chưa có người nào'),
                            )
                          : SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: true,
                              header: const MaterialClassicHeader(),
                              onRefresh: () {
                                referralDetailController.getAllUserReferral(
                                    isRefresh: true,
                                    code: widget.user.selfReferralCode!);
                                refreshController1.refreshCompleted();
                              },
                              onLoading: () async {
                                referralDetailController.getAllUserReferral(
                                    code: widget.user.selfReferralCode!);
                                refreshController1.loadComplete();
                              },
                              footer: CustomFooter(
                                builder: (
                                  BuildContext context,
                                  LoadStatus? mode,
                                ) {
                                  Widget body = Container();
                                  if (mode == LoadStatus.idle) {
                                    body = Obx(() =>
                                        referralDetailController.isLoading.value
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
                              controller: refreshController1,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ...referralDetailController.listReferral
                                        .map((element) => referralItem(element))
                                  ],
                                ),
                              ),
                            ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget referralItem(User user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.to(() => ReferralDetailScreen(
                user: user,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: CachedNetworkImage(
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                    imageUrl: user.avatarImage == null ? '' : user.avatarImage!,
                    //placeholder: (context, url) => SahaLoadingWidget(),
                    errorWidget: (context, url, error) => const SahaEmptyAvata(
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      user.name ?? 'Chưa có tên',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.orange[700]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      user.phoneNumber ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                  style: const TextStyle(fontWeight: FontWeight.w600),
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
                    '${SahaStringUtils().convertToMoney(walletHistory.accountBalanceChanged ?? "0")} đ'),
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
