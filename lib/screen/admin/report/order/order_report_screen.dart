import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/loading/loading_full_screen.dart';
import '../../../../utils/date_utils.dart';
import '../choose_time/choose_time_screen.dart';
import 'option_report/chart_business.dart';
import 'option_report/chart_product.dart';
import 'order_report_controller.dart';

// ignore: must_be_immutable
class OrderReportScreen extends StatelessWidget {
  DateTime? fromDate;
  DateTime? toDate;

  OrderReportScreen({
    this.fromDate,
    this.toDate,
  }) {
    orderReportController = Get.put(
        OrderReportController(fromDateInput: fromDate, toDateInput: toDate));
    orderReportController.getReports();
  }

  final RefreshController _refreshController = RefreshController();

  late OrderReportController orderReportController;
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
        title: const Text('Thống kê đơn hàng'),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const MaterialClassicHeader(),
        controller: _refreshController,
        onRefresh: () async {
          await orderReportController.refresh();
          _refreshController.refreshCompleted();
        },
        child: Obx(
          () => orderReportController.isLoading.value
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
                          BusinessChart(),
                          ChartProduct(),
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
                  initTab: orderReportController.indexTabTime,
                  fromDayInput: orderReportController.fromDay.value,
                  toDayInput: orderReportController.toDay.value,
                  initChoose: orderReportController.indexChooseTime,
                  callback: (DateTime fromDate,
                      DateTime toDay,
                      DateTime fromDateCP,
                      DateTime toDayCP,
                      bool isCompare,
                      int? indexTab,
                      int? indexChoose) {
                    orderReportController.fromDay.value = fromDate;
                    orderReportController.toDay.value = toDay;

                    orderReportController.indexTabTime = indexTab ?? 0;
                    orderReportController.indexChooseTime = indexChoose ?? 0;
                  },
                ))!
            .then((value) => {
                  orderReportController.getReports(),
                });
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => !SahaDateUtils()
                    .getDate(orderReportController.fromDay.value)
                    .isAtSameMomentAs(SahaDateUtils()
                        .getDate(orderReportController.toDay.value))
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
                                  "${SahaDateUtils().getDDMMYY(orderReportController.fromDay.value)} "),
                              Text(
                                "Đến: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  SahaDateUtils().getDDMMYY(orderReportController.toDay.value)),
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
                                  "${SahaDateUtils().getDDMMYY(orderReportController.fromDay.value)} "),
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
