import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/users_bill/user_bill_controller.dart';
import 'package:gohomy/screen/users_bill/user_bill_details/user_bill_details_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../components/loading/loading_full_screen.dart';
import '../../model/bill.dart';
import '../../utils/string_utils.dart';

class UserBillScreen extends StatefulWidget {
  const UserBillScreen({Key? key}) : super(key: key);

  @override
  State<UserBillScreen> createState() => _UserBillScreenState();
}

class _UserBillScreenState extends State<UserBillScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  UserBillController userBillController = UserBillController();
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
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: const Text('Hóa đơn'),
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
                            userBillController.onOkChooseTime(
                                startDate, endDate);

                            userBillController.getUserAllBill(isRefresh: true);
                          },
                          showActionButtons: true,
                          onSelectionChanged: chooseRangeTime,
                          selectionMode: DateRangePickerSelectionMode.range,
                          initialSelectedRange: PickerDateRange(
                            userBillController.fromDateOption,
                            userBillController.toDateOption,
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
          )
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
                  userBillController.status.value = v;
                  userBillController.getUserAllBill(isRefresh: true);
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
              () => userBillController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : userBillController.listBill.isEmpty
                      ? const Center(
                          child: Text('Không có hóa đơn'),
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
                                    userBillController.isLoading.value
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
                            await userBillController.getUserAllBill(
                                isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await userBillController.getUserAllBill();
                            refreshController.loadComplete();
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: userBillController.listBill
                                  .map((e) => itemBill(e, _tabController))
                                  .toList(),
                            ),
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBill(Bill bill, TabController tabController) {
    return InkWell(
      onTap: () {
        Get.to(() => UserBillDetailsScreen(
                  billId: bill.id!,
                ))!
            .then((value) => {
                  if (value == 'pay_success')
                    {
                      tabController.animateTo(1),
                      userBillController.status.value = 1,
                    },
                  userBillController.getUserAllBill(isRefresh: true),
                });
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
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(CupertinoIcons.home),
                const SizedBox(
                  width: 4,
                ),
                Expanded(child: Text('${bill.motel?.motelName}')),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tiền phòng :',
                ),
                Text(
                  '${SahaStringUtils().convertToMoney(bill.totalMoneyMotel ?? "0")} đ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tiền dịch vụ :',
                ),
                Text(
                  '${SahaStringUtils().convertToMoney(bill.totalMoneyService ?? "0")} đ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tổng thanh toán :'),
                Text(
                  '${SahaStringUtils().convertToMoney(bill.totalFinal ?? "0")} đ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),
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
