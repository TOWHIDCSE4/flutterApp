import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/report_post_violation.dart';
import 'package:gohomy/screen/admin/report_post_violation/report_post_violation_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/dialog/dialog.dart';
import '../../../components/loading/loading_full_screen.dart';
import '../../../components/text_field/saha_text_field_search.dart';
import '../../../utils/call.dart';
import '../../../utils/debounce.dart';
import '../../chat/chat_list/chat_list_screen.dart';
import '../../find_room/room_information/room_information_screen.dart';

class ReportPostViolationScreen extends StatefulWidget {
  const ReportPostViolationScreen({Key? key}) : super(key: key);

  @override
  State<ReportPostViolationScreen> createState() =>
      _ReportPostViolationScreenState();
}

class _ReportPostViolationScreenState extends State<ReportPostViolationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  RefreshController refreshController = RefreshController();
  ReportPostViolationController reportPostViolationController =
      ReportPostViolationController();
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Báo cáo vi phạm",
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // begin: Alignment.bottomLeft,
                  // end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 45,
                  width: Get.width,
                  child: ColoredBox(
                    color: Colors.white,
                    child: TabBar(
                      controller: _tabController,
                      onTap: (v) {
                        reportPostViolationController.status.value =
                            v == 0 ? 0 : 2;
                        reportPostViolationController.getAllReportViolationPost(
                            isRefresh: true);
                      },
                      tabs: [
                        Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Chưa xử lý',
                                style: TextStyle(
                                  color: Colors.blue,
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
                                'Đã xử lý',
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
              ],
            ),
            SahaTextFieldSearch(
              hintText: "Tìm kiếm",
              onChanged: (va) {
                EasyDebounce.debounce(
                    'list_motel_room', const Duration(milliseconds: 300), () {
                  reportPostViolationController.textSearch = va;
                  reportPostViolationController.getAllReportViolationPost(
                      isRefresh: true);
                });
              },
              onClose: () {
                reportPostViolationController.textSearch = "";
                reportPostViolationController.getAllReportViolationPost(
                    isRefresh: true);
              },
            ),
            Expanded(
              child: Obx(
                () => reportPostViolationController.loadInit.value
                    ? SahaLoadingFullScreen()
                    : SmartRefresher(
                        footer: CustomFooter(
                          builder: (
                            BuildContext context,
                            LoadStatus? mode,
                          ) {
                            Widget body = Container();
                            if (mode == LoadStatus.idle) {
                              body = Obx(() =>
                                  reportPostViolationController.isLoading.value
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
                        enablePullDown: true,
                        enablePullUp: true,
                        header: const MaterialClassicHeader(),
                        onRefresh: () async {
                          await reportPostViolationController
                              .getAllReportViolationPost(isRefresh: true);
                          refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await reportPostViolationController
                              .getAllReportViolationPost();
                          refreshController.loadComplete();
                        },
                        child: ListView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemCount: reportPostViolationController
                                .listReportViolationPost.length,
                            itemBuilder: (BuildContext context, int index) {
                              return reportViolationItem(
                                  reportPostViolation:
                                      reportPostViolationController
                                          .listReportViolationPost[index],
                                  context: context);
                            }),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reportViolationItem(
      {required ReportPostViolation reportPostViolation, context}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            if (reportPostViolation.user != null)
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(reportPostViolation.user?.name ?? ""),
                ],
              ),
            const SizedBox(
              height: 5,
            ),
            if (reportPostViolation.user != null)
              Row(
                children: [
                  Icon(Icons.phone, color: Theme.of(context).primaryColor),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(reportPostViolation.user?.phoneNumber ?? ""),
                ],
              ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.report, color: Theme.of(context).primaryColor),
                const SizedBox(
                  width: 10,
                ),
                Expanded(child: Text(reportPostViolation.description ?? "...")),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.podcasts_sharp,
                    color: Theme.of(context).primaryColor),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Get.to(() => RoomInformationScreen(
                          roomPostId: reportPostViolation.moPostId,
                          isWatch: true,
                        ));
                  },
                  child: Text(
                    "Bài đăng: ${reportPostViolation.motelPost?.title ?? "..."}",
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Call.call(reportPostViolation.user?.phoneNumber ?? "");
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Gọi',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (reportPostViolation.user != null)
                  InkWell(
                    onTap: () {
                      Get.to(() => ChatListScreen(
                            toUser: reportPostViolation.user,
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.chat_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Chat',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                InkWell(
                  onTap: () {
                    if (reportPostViolationController.status.value == 2) {
                      SahaDialogApp.showDialogYesNo(
                          mess: 'Bạn có chắc chắn muốn xoá thông tin này chứ ?',
                          onOK: () {
                            reportPostViolationController
                                .deleteReportPostViolation(
                                    id: reportPostViolation.id!);
                          });
                    } else {
                      reportPostViolationController.updateReportPostViolation(
                          id: reportPostViolation.id!);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: reportPostViolationController.status.value == 2
                            ? Colors.red
                            : Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          reportPostViolationController.status.value == 2
                              ? Icons.delete
                              : Icons.check,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          reportPostViolationController.status.value == 2
                              ? "Xoá"
                              : 'Đã xử lý',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
