import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/profile/bill/add_bill/add_bill_screen.dart';
import 'package:gohomy/screen/profile/bill/bill_details/bill_details_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../components/loading/loading_full_screen.dart';
import '../../../model/bill.dart';
import '../../../utils/string_utils.dart';
import '../users/user_filter/user_filter_screen.dart';
import 'bill_admin_controller.dart';

class BillAdminScreen extends StatefulWidget {
  const BillAdminScreen({Key? key}) : super(key: key);

  @override
  State<BillAdminScreen> createState() => _BillAdminScreenState();
}

class _BillAdminScreenState extends State<BillAdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  BillAdminController billController = BillAdminController();
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
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: Obx(
          () => Text(billController.userChoose.value.id != null
              ? billController.userChoose.value.name ?? ''
              : 'Hóa đơn'),
        ),
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
                            billController.onOkChooseTime(startDate, endDate);

                            billController.getAllBill(isRefresh: true);
                          },
                          showActionButtons: true,
                          onSelectionChanged: chooseRangeTime,
                          selectionMode: DateRangePickerSelectionMode.range,
                          initialSelectedRange: PickerDateRange(
                            billController.fromDateOption,
                            billController.toDateOption,
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
          IconButton(
              onPressed: () {
                Get.to(() => UserFilterScreen(
                    isShowTab: false,
                    idChoose: billController.userChoose.value.id,
                    onChoose: (user) {
                      billController.userChoose.value = user;
                      billController.getAllBill(isRefresh: true);
                      Get.back();
                    }));
              },
              icon: Obx(() => Icon(
                  billController.userChoose.value.id != null
                      ? Icons.filter_alt
                      : Icons.filter_alt_outlined,
                  color: billController.userChoose.value.id != null
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
                  billController.status.value = v;
                  billController.getAllBill(isRefresh: true);
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
              () => billController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : billController.listBill.isEmpty
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
                                body = Obx(() => billController.isLoading.value
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
                            await billController.getAllBill(isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await billController.getAllBill();
                            refreshController.loadComplete();
                          },
                          child: ListView.builder(
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              itemCount: billController.listBill.length,
                              itemBuilder: (BuildContext context, int index) {
                                return itemBill(billController.listBill[index]);
                              }),
                        ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddBillScreen())!
              .then((value) => billController.getAllBill(isRefresh: true));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemBill(Bill bill) {
    return InkWell(
      onTap: () {
        Get.to(() => BillDetails(
                  billId: bill.id!,
                ))!
            .then((value) => billController.getAllBill(isRefresh: true));
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
                const Icon(CupertinoIcons.person),
                const SizedBox(
                  width: 4,
                ),
                Expanded(child: Text('Chủ nhà: ${bill.host?.name ?? ''}')),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            if(bill.motel?.towerId != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(CupertinoIcons.building_2_fill),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(child: Text('${bill.motel?.towerName}')),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
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
