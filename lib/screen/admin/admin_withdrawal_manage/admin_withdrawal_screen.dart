import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/screen/admin/admin_withdrawal_manage/admin_withdrawal_controller.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../components/loading/loading_full_screen.dart';
import '../../../model/request_withdrawals.dart';
import '../../../utils/string_utils.dart';
import 'admin_withdrawal_details/withdrawal_details_screen.dart';

class AdminWithdrawalScreen extends StatefulWidget {
  const AdminWithdrawalScreen({super.key});

  @override
  State<AdminWithdrawalScreen> createState() => _AdminWithdrawalScreenState();
}

class _AdminWithdrawalScreenState extends State<AdminWithdrawalScreen>
    with SingleTickerProviderStateMixin {
  AdminWithdrawalController adminWithdrawalController =
      AdminWithdrawalController();
  late TabController _tabController;
  RefreshController refreshController = RefreshController();
  late DateTime startDate;
  late DateTime endDate;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: 'Quản lý rút tiền',
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
                            adminWithdrawalController.onOkChooseTime(
                                startDate, endDate);

                            adminWithdrawalController.getAllWithdrawalAdmin(
                                isRefresh: true);
                          },
                          showActionButtons: true,
                          onSelectionChanged: chooseRangeTime,
                          selectionMode: DateRangePickerSelectionMode.range,
                          initialSelectedRange: PickerDateRange(
                            adminWithdrawalController.fromDateOption,
                            adminWithdrawalController.toDateOption,
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
                  adminWithdrawalController.status.value = v == 0
                      ? 0
                      : v == 1
                          ? 2
                          : 1;
                  adminWithdrawalController.getAllWithdrawalAdmin(
                      isRefresh: true);
                },
                tabs: [
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Chờ xác nhận ',
                          style: TextStyle(
                            color: Colors.green,
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
                          'Đã bị huỷ ',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                          ),
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
              () => adminWithdrawalController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : adminWithdrawalController.listWithdrawal.isEmpty
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
                                    adminWithdrawalController.isLoading.value
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
                            await adminWithdrawalController
                                .getAllWithdrawalAdmin(isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await adminWithdrawalController
                                .getAllWithdrawalAdmin();
                            refreshController.loadComplete();
                          },
                          child: ListView.builder(
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              itemCount: adminWithdrawalController
                                  .listWithdrawal.length,
                              itemBuilder: (BuildContext context, int index) {
                                return itemWithdrawal(adminWithdrawalController
                                    .listWithdrawal[index]);
                              }),
                        ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemWithdrawal(RequestWithdrawals requestWithdrawals) {
    return InkWell(
      onTap: () {
        Get.to(() => WithdrawalDetailsScreen(
                  id: requestWithdrawals.id!,
                ))!
            .then((value) => adminWithdrawalController.getAllWithdrawalAdmin(
                isRefresh: true));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
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
                    const Text('Tên người yêu cầu :'),
                    Text(requestWithdrawals.user?.name ?? 'Chưa có tên')
                  ],
                ),
              ),
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

  void chooseRangeTime(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDate = args.value.startDate;
      endDate = args.value.endDate ?? args.value.startDate;
    }
  }
}
