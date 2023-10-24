import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../components/loading/loading_full_screen.dart';
import '../../../model/commission_manage.dart';
import '../../../utils/string_utils.dart';
import 'commission_payment_controller.dart';
import 'commission_payment_detail/commission_payment_detail_screen.dart';

class CommissionPaymentScreen extends StatefulWidget {
  const CommissionPaymentScreen({super.key});

  @override
  State<CommissionPaymentScreen> createState() =>
      _CommissionPaymentScreenState();
}

class _CommissionPaymentScreenState extends State<CommissionPaymentScreen>
    with SingleTickerProviderStateMixin {
  RefreshController refreshController = RefreshController();
  late TabController _tabController;
  CommissionPaymentController commissionPaymentController =
      CommissionPaymentController();
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: 'Quản lý hoa hồng trả cho CTV',
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SizedBox(
                        width: Get.width * 0.9,
                        height: Get.height * 0.5,
                        child: SfDateRangePicker(
                          onCancel: () {
                            Get.back();
                          },
                          onSubmit: (v) {
                            commissionPaymentController.onOkChooseTime(
                                startDate, endDate);

                            commissionPaymentController.getAllCommissionPayUser(
                                isRefresh: true);
                          },
                          showActionButtons: true,
                          onSelectionChanged: chooseRangeTime,
                          selectionMode: DateRangePickerSelectionMode.range,
                          initialSelectedRange: PickerDateRange(
                            commissionPaymentController.fromDateOption,
                            commissionPaymentController.toDateOption,
                          ),
                          maxDate: DateTime.now(),
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              child: const Icon(
                FontAwesomeIcons.calendar,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 45,
            width: Get.width,
            child: ColoredBox(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                onTap: (v) {
                  commissionPaymentController.status.value = v == 0 ? 0 : 2;
                  commissionPaymentController.getAllCommissionPayUser(
                      isRefresh: true);
                },
                tabs: [
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Chờ xác nhận',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Đã xác nhận',
                          style: TextStyle(
                              color: Color.fromARGB(137, 13, 169, 75),
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          Expanded(
            child: Obx(
              () => commissionPaymentController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : commissionPaymentController.listCommission.isEmpty
                      ? const Center(
                          child: Text('Không có yêu cầu nào'),
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
                                    commissionPaymentController.isLoading.value
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
                            await commissionPaymentController
                                .getAllCommissionPayUser(isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await commissionPaymentController
                                .getAllCommissionPayUser();
                            refreshController.loadComplete();
                          },
                          child: ListView.builder(
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              itemCount: commissionPaymentController
                                  .listCommission.length,
                              itemBuilder: (BuildContext context, int index) {
                                return itemCommission(
                                    commissionPaymentController
                                        .listCommission[index]);
                              }),
                        ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemCommission(CommissionManage commissionManage) {
    return InkWell(
      onTap: () {
        Get.to(() => CommissionPaymentDetailScreen(
                  id: commissionManage.id!,
                ))!
            .then((value) => commissionPaymentController
                .getAllCommissionPayUser(isRefresh: true));
      },
      child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Người giới thiệu :'),
                  Text(commissionManage.user?.name ?? ''),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Người được giới thiệu :'),
                  Text(commissionManage.userReferral?.name ?? ''),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Số tiền trả mỗi CTV :'),
                  Text(
                    '${SahaStringUtils().convertToMoney(commissionManage.moneyCommissionUser ?? "0")} đ',
                    style: const TextStyle(),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tổng tiền trả CTV :'),
                  Text(
                    '${SahaStringUtils().convertToMoney((commissionManage.moneyCommissionUser ?? 0) * 2)} đ',
                    style: const TextStyle(),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Từ bài đăng :'),
                  Expanded(
                    child: Text(
                      commissionManage.moPost?.title ?? '',
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Ngày tạo :'),
                  Text(DateFormat('dd-MM-yyyy')
                      .format(commissionManage.createdAt!)),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          )),
    );
  }

  void chooseRangeTime(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDate = args.value.startDate;
      endDate = args.value.endDate ?? args.value.startDate;
    }
  }
}
