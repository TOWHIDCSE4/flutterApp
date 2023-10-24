import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/report/post/widget/chart_post_find_room.dart';
import 'package:gohomy/screen/admin/report/post/widget/chart_post_roommate_res.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/loading/loading_full_screen.dart';
import '../../../../utils/date_utils.dart';
import '../choose_time/choose_time_screen.dart';
import 'post_report_controller.dart';
import 'widget/chart_post.dart';
import 'widget/chart_post_top.dart';

class PostReportScreen extends StatelessWidget {
  DateTime? fromDate;
  DateTime? toDate;

  PostReportScreen({
    this.fromDate,
    this.toDate,
  }) {
    postReportController = Get.put(
        PostReportController(fromDateInput: fromDate, toDateInput: toDate));
    postReportController.getReportPost();
  }

  final RefreshController _refreshController = RefreshController();

  late PostReportController postReportController;
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
        title: const Text('Thống kê bài đăng'),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const MaterialClassicHeader(),
        controller: _refreshController,
        onRefresh: () async {
          await postReportController.refresh();
          _refreshController.refreshCompleted();
        },
        child: Obx(
          () => postReportController.isLoading.value
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
                          PostChart(),
                          ChartPostTop(),
                          ChartPostFindRoom(),
                          ChartPostRoommate()

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
                  initTab: postReportController.indexTabTime,
                  fromDayInput: postReportController.fromDay.value,
                  toDayInput: postReportController.toDay.value,
                  initChoose: postReportController.indexChooseTime,
                  callback: (DateTime fromDate,
                      DateTime toDay,
                      DateTime fromDateCP,
                      DateTime toDayCP,
                      bool isCompare,
                      int? indexTab,
                      int? indexChoose) {
                    postReportController.fromDay.value = fromDate;
                    postReportController.toDay.value = toDay;

                    postReportController.indexTabTime = indexTab ?? 0;
                    postReportController.indexChooseTime = indexChoose ?? 0;
                  },
                ))!
            .then((value) => {
                  postReportController.getReportPost(),
                });
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => !SahaDateUtils()
                    .getDate(postReportController.fromDay.value)
                    .isAtSameMomentAs(SahaDateUtils()
                        .getDate(postReportController.toDay.value))
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
                                  "${SahaDateUtils().getDDMMYY(postReportController.fromDay.value)} "),
                              Text(
                                "Đến: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  SahaDateUtils().getDDMMYY(postReportController.toDay.value)),
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
                                  "${SahaDateUtils().getDDMMYY(postReportController.fromDay.value)} "),
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
