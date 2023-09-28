import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/problem.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../utils/date_utils.dart';
import '../../owner/problem_owner/add_problem/add_problem_owner_screen.dart';
import '../../profile/problem/add_problem/add_problem_screen.dart';
import '../users/user_filter/user_filter_screen.dart';
import 'problem_admin_controller.dart';

class ProblemAdminScreen extends StatefulWidget {
  @override
  State<ProblemAdminScreen> createState() => _ProblemAdminScreenState();
}

class _ProblemAdminScreenState extends State<ProblemAdminScreen>
    with SingleTickerProviderStateMixin {
  ProblemAdminController problemController = ProblemAdminController();

  RefreshController refreshController = RefreshController();

  late TabController _tabController;
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        title: Obx(
          () => Text(problemController.userChoose.value.id != null
              ? problemController.userChoose.value.name ?? ''
              : 'Báo cáo sự cố'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => UserFilterScreen(
                    isShowTab: false,
                    idChoose: problemController.userChoose.value.id,
                    onChoose: (user) {
                      problemController.userChoose.value = user;
                      problemController.getAllProblemAdmin(isRefresh: true);
                      Get.back();
                    }));
              },
              icon: Obx(() => Icon(
                  problemController.userChoose.value.id != null
                      ? Icons.filter_alt
                      : Icons.filter_alt_outlined,
                  color: problemController.userChoose.value.id != null
                      ? Colors.blue
                      : null))),
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
                  problemController.status.value = v == 0 ? 0 : 2;
                  problemController.getAllProblemAdmin(isRefresh: true);
                },
                tabs: const [
                  Tab(
                    child: Text(
                      'Đang yêu cầu',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Đã hoàn thành',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          // SahaTextFieldSearch(
          //   hintText: "Tìm kiếm sản phẩm",
          //   onChanged: (v) {
          //     EasyDebounce.debounce(
          //         'debounce_search_problem', Duration(milliseconds: 300), () {
          //       problemController.textSearch = v;
          //       problemController.getAllProblemAdmin(isRefresh: true);
          //     });
          //   },
          //   onClose: () {
          //     problemController.textSearch = "";
          //     problemController.getAllProblemAdmin(isRefresh: true);
          //   },
          // ),
          InkWell(
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
                            problemController.onOkChooseTime(
                                startDate, endDate);
                            problemController.getAllProblemAdmin(
                                isRefresh: true);
                          },
                          showActionButtons: true,
                          onSelectionChanged: chooseRangeTime,
                          selectionMode: DateRangePickerSelectionMode.range,
                          initialSelectedRange: PickerDateRange(
                            problemController.fromDateOption,
                            problemController.toDateOption,
                          ),
                          maxDate: DateTime.now(),
                        ),
                      ),
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Obx(() => problemController.checkSelected.value
                      ? Text(
                          "Từ: ${SahaDateUtils().getDDMMYY4(problemController.fromDay.value)} đến ${SahaDateUtils().getDDMMYY4(problemController.toDay.value)}")
                      : const Text('Chọn khoảng thời gian')),
                  const Spacer(),
                  const Icon(Icons.keyboard_arrow_down_rounded)
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => problemController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : problemController.listProblem.isEmpty
                      ? const Center(
                          child: Text('Không có sự cố'),
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
                                    problemController.isLoading.value
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
                            await problemController.getAllProblemAdmin(
                                isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await problemController.getAllProblemAdmin();
                            refreshController.loadComplete();
                          },
                          child: ListView.builder(
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              itemCount: problemController.listProblem.length,
                              itemBuilder: (BuildContext context, int index) {
                                return itemProblem(
                                    problemController.listProblem[index]);
                              }),
                        ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddProblemScreen())!.then((value) =>
              {problemController.getAllProblemAdmin(isRefresh: true)});
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemProblem(Problem problem) {
    return InkWell(
      onTap: () {
        Get.to(() => AddProblemOwnerScreen(
                  problemId: problem.id,
                ))!
            .then((value) =>
                problemController.getAllProblemAdmin(isRefresh: true));
      },
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.warning_rounded,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    problem.reason ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: (problem.severity ?? 0) == 0
                        ? Colors.red
                        : problem.severity == 1
                            ? Theme.of(context).primaryColor
                            : Colors.amber,
                  ),
                  child: Text(
                    (problem.severity ?? 0) == 0
                        ? 'Cao'
                        : problem.severity == 1
                            ? 'Trung bình'
                            : 'Thấp',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    problem.motel?.motelName ?? "",
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    '${problem.motel?.addressDetail ?? ""}${problem.motel?.addressDetail == null ? "" : ", "}${problem.motel?.wardsName ?? ""}${problem.motel?.wardsName != null ? ", " : ""}${problem.motel?.districtName ?? ""}${problem.motel?.districtName != null ? ", " : ""}${problem.motel?.provinceName ?? ""}',
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    problem.user?.name ?? "",
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    '${SahaDateUtils().getDDMMYY(problem.createdAt ?? DateTime.now())}   ${SahaDateUtils().getHHMM(problem.createdAt ?? DateTime.now())}',
                    maxLines: 2,
                  ),
                ),
              ],
            )
          ],
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
