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
import 'commission_detail_admin/commission_detail_admin_screen.dart';
import 'commission_manage_admin_controller.dart';

class CommissionManageAdminScreen extends StatefulWidget {
  const CommissionManageAdminScreen({super.key});

  @override
  State<CommissionManageAdminScreen> createState() =>
      _CommissionManageAdminScreenState();
}

class _CommissionManageAdminScreenState
    extends State<CommissionManageAdminScreen>
    with SingleTickerProviderStateMixin {
  RefreshController refreshController = RefreshController();
  late TabController _tabController;
  CommissionManageAdminController commissionManageAdminController =
      CommissionManageAdminController();
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
        titleText: "Quản lý hoa hồng chủ nhà",
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
                            commissionManageAdminController.onOkChooseTime(
                                startDate, endDate);

                            commissionManageAdminController
                                .getAllCommissionAdmin(isRefresh: true);
                          },
                          showActionButtons: true,
                          onSelectionChanged: chooseRangeTime,
                          selectionMode: DateRangePickerSelectionMode.range,
                          initialSelectedRange: PickerDateRange(
                            commissionManageAdminController.fromDateOption,
                            commissionManageAdminController.toDateOption,
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
                  commissionManageAdminController.status.value = v == 0
                      ? 0
                      : v == 1
                          ? 3
                          : 2;
                  commissionManageAdminController.getAllCommissionAdmin(
                      isRefresh: true);
                },
                tabs: [
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Chờ thanh toán',
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
                          'Đã thanh toán',
                          style: TextStyle(color: Colors.black54, fontSize: 12),
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
              () => commissionManageAdminController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : commissionManageAdminController.listCommission.isEmpty
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
                                body = Obx(() => commissionManageAdminController
                                        .isLoading.value
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
                            await commissionManageAdminController
                                .getAllCommissionAdmin(isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await commissionManageAdminController
                                .getAllCommissionAdmin();
                            refreshController.loadComplete();
                          },
                          child: ListView.builder(
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              itemCount: commissionManageAdminController
                                  .listCommission.length,
                              itemBuilder: (BuildContext context, int index) {
                                return itemCommission(
                                    commissionManageAdminController
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
        Get.to(() => CommissionDetailAdminScreen(
              id: commissionManage.id!,
            ));
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
                  const Text('Chủ nhà :'),
                  Text(commissionManage.host?.name ?? ''),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Số tiền hoa hồng cần thanh toán :'),
                  Text(
                      '${SahaStringUtils().convertToMoney(commissionManage.moneyCommissionAdmin ?? "0")} đ'),
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
              if (commissionManage.status == 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Ngày được admin xác nhận :'),
                    Text(DateFormat('dd-MM-yyyy')
                        .format(commissionManage.dateReferSuccess!)),
                  ],
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
