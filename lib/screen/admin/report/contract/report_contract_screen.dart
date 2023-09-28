import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/report/contract/report_contract_controller.dart';

import 'package:gohomy/screen/admin/report/potential/widget/chart_potential.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/loading/loading_full_screen.dart';
import '../../../../utils/date_utils.dart';
import '../choose_time/choose_time_screen.dart';
import 'widget/contract_chart.dart';

class ReportContractScreen extends StatelessWidget {
  DateTime? fromDate;
  DateTime? toDate;

  ReportContractScreen({
    this.fromDate,
    this.toDate,
  }) {
    controller = Get.put(
        ReportContractController(fromDateInput: fromDate, toDateInput: toDate));
    controller.getReportStaticContract();
  }

  final RefreshController _refreshController = RefreshController();

  late ReportContractController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: const Text('Thống kê hợp đồng'),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const MaterialClassicHeader(),
        controller: _refreshController,
        onRefresh: () async {
          await controller.refresh();
          _refreshController.refreshCompleted();
        },
        child: Obx(
          () => controller.isLoading.value
              ? SahaLoadingFullScreen()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 4,
                        color: Colors.grey[200],
                      ),
                      head(),
                      Container(
                        height: 4,
                        color: Colors.grey[200],
                      ),
                      Column(
                        children: [
                         ContractChart()

                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget head() {
    return InkWell(
      onTap: () {
        Get.to(() => ChooseTimeScreen(
                  isCompare: false,
                  hideCompare: true,
                  initTab: controller.indexTabTime,
                  fromDayInput: controller.fromDay.value,
                  toDayInput: controller.toDay.value,
                  initChoose: controller.indexChooseTime,
                  callback: (DateTime fromDate,
                      DateTime toDay,
                      DateTime fromDateCP,
                      DateTime toDayCP,
                      bool isCompare,
                      int? indexTab,
                      int? indexChoose) {
                    controller.fromDay.value = fromDate;
                    controller.toDay.value = toDay;

                    controller.indexTabTime = indexTab ?? 0;
                    controller.indexChooseTime = indexChoose ?? 0;
                  },
                ))!
            .then((value) => {
                  controller.getReportStaticContract(),
                });
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => !SahaDateUtils()
                    .getDate(controller.fromDay.value)
                    .isAtSameMomentAs(SahaDateUtils()
                        .getDate(controller.toDay.value))
                ? Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Từ: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  "${SahaDateUtils().getDDMMYY(controller.fromDay.value)} "),
                              Text(
                                "Đến: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  SahaDateUtils().getDDMMYY(controller.toDay.value)),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 21,
                        color: Theme.of(Get.context!).primaryColor,
                      )
                    ],
                  )
                : Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Ngày: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  "${SahaDateUtils().getDDMMYY(controller.fromDay.value)} "),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 21,
                        color: Theme.of(Get.context!).primaryColor,
                      )
                    ],
                  ),
          )),
    );
  }
}