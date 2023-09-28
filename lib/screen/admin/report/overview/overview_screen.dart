import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/report/overview/widget/chart_renter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/loading/loading_full_screen.dart';
import '../../../../utils/date_utils.dart';
import '../choose_time/choose_time_screen.dart';
import 'over_view_controller.dart';
import 'widget/chart_find_fast_motel.dart';
import 'widget/chart_motel.dart';
import 'widget/chart_reservation_motel.dart';

class OverviewReportScreen extends StatelessWidget {
  DateTime? fromDate;
  DateTime? toDate;

  OverviewReportScreen({
    this.fromDate,
    this.toDate,
  }) {
    overviewReportController = Get.put(
        OverviewReportController(fromDateInput: fromDate, toDateInput: toDate));
    overviewReportController.getReportMotel();
    overviewReportController.getReportRenter();
    overviewReportController.getReportFindFastMotel();
    overviewReportController.getReportReservationMotel();
  }

  final RefreshController _refreshController = RefreshController();

  late OverviewReportController overviewReportController;

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
        title: const Text('Thống kê '),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const MaterialClassicHeader(),
        controller: _refreshController,
        onRefresh: () async {
          await overviewReportController.refresh();
          _refreshController.refreshCompleted();
        },
        child: Obx(
          () => overviewReportController.isLoading.value
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
                          RenterChart(),
                          MotelChart(),
                          ReservationMotelChart(),
                          FindFastMotelChart(),
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
                  initTab: overviewReportController.indexTabTime,
                  fromDayInput: overviewReportController.fromDay.value,
                  toDayInput: overviewReportController.toDay.value,
                  initChoose: overviewReportController.indexChooseTime,
                  callback: (DateTime fromDate,
                      DateTime toDay,
                      DateTime fromDateCP,
                      DateTime toDayCP,
                      bool isCompare,
                      int? indexTab,
                      int? indexChoose) {
                    overviewReportController.fromDay.value = fromDate;
                    overviewReportController.toDay.value = toDay;

                    overviewReportController.indexTabTime = indexTab ?? 0;
                    overviewReportController.indexChooseTime = indexChoose ?? 0;
                  },
                ))!
            .then((value) => {
                  overviewReportController.getReportFindFastMotel(),
                  overviewReportController.getReportReservationMotel(),
                  overviewReportController.getReportRenter(),
                  overviewReportController.getReportMotel(),
                });
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => !SahaDateUtils()
                    .getDate(overviewReportController.fromDay.value)
                    .isAtSameMomentAs(SahaDateUtils()
                        .getDate(overviewReportController.toDay.value))
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
                                  "${SahaDateUtils().getDDMMYY(overviewReportController.fromDay.value)} "),
                              Text(
                                "Đến: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  SahaDateUtils().getDDMMYY(overviewReportController.toDay.value)),
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
                                  "${SahaDateUtils().getDDMMYY(overviewReportController.fromDay.value)} "),
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
