import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../utils/date_utils.dart';
import 'report_controller.dart';

class ReportScreenManage extends StatefulWidget {
  @override
  State<ReportScreenManage> createState() => _ReportScreenManageState();
}

class _ReportScreenManageState extends State<ReportScreenManage>
    with SingleTickerProviderStateMixin {
  ReportController reportController = ReportController();

  late TabController _tabController;

  var listType = [
    'Doanh thu tổng',
    'Doanh thu tiền phòng',
    'Doanh thu dịch vụ',
    'Số tiền giảm giá'
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: const Text('Báo cáo'),
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
                    onTap: (v) {},
                    tabs: [
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Doanh thu',
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
                              'Chỉ số',
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
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                turnover(),
                summaryMotel(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget turnover() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
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
                                  if (v is PickerDateRange) {
                                    print('pick nhieu thang');
                                    reportController.startDate.value =
                                        v.startDate!;
                                    reportController.endDate.value =
                                        v.endDate ?? v.startDate!;
                                    reportController.getOverView();
                                    reportController.hasChooseTime.value = true;
                                  }

                                  Get.back();
                                },
                                showActionButtons: true,
                                allowViewNavigation: false,
                                //onSelectionChanged: chooseRangeTime,
                                view: DateRangePickerView.year,
                                selectionMode:
                                    DateRangePickerSelectionMode.range,
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
                        const Text("Tháng bắt đầu và kết thúc: "),
                        const Spacer(),
                        Obx(
                          () => reportController.hasChooseTime.value == false
                              ? Text(
                                  //'Từ đầu tháng đến ${SahaDateUtils().getDDMM(reportController.endDate.value)}'
                                  'Tháng ${reportController.endDate.value.month}')
                              : reportController.startDate.value.month ==
                                      reportController.endDate.value.month
                                  ? Text(
                                      'Tháng ${reportController.startDate.value.month.toString()}')
                                  : Text(
                                      "${SahaDateUtils().getDDMM(reportController.startDate.value)} đến ${SahaDateUtils().getDDMM(reportController.endDate.value)}"),
                        ),
                        const Icon(Icons.keyboard_arrow_down_rounded)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          SizedBox(
            height: 100,
            width: Get.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              itemCount: listType.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    reportController.indexChart.value = index;
                  },
                  child: Obx(
                    () => Container(
                      margin: const EdgeInsets.all(4.0),
                      padding: const EdgeInsets.all(4.0),
                      width: (Get.width - 60) / 2,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: (reportController.indexChart.value == index
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[500])!),
                          borderRadius: BorderRadius.circular(2)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            titleReturn(index),
                            style: TextStyle(
                                color:
                                    (reportController.indexChart.value == index
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey[500])!),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${SahaStringUtils().convertToMoney(moneyTitleReturn(index))} VNĐ",
                            style: TextStyle(
                                color:
                                    (reportController.indexChart.value == index
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey[500])!),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Obx(
            () => Container(
              padding: const EdgeInsets.all(5.0),
              height: 500,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                    labelIntersectAction: AxisLabelIntersectAction.wrap,
                    maximumLabelWidth: 200),
                primaryYAxis: NumericAxis(
                  numberFormat: NumberFormat.compact(),
                ),
                title: ChartTitle(
                    text: listType[reportController.indexChart.value]),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  header: "",
                ),
                series: <ColumnSeries<ProductReport, String>>[
                  ColumnSeries<ProductReport, String>(
                    width: 0.4,
                    legendItemText:
                        "${SahaDateUtils().getDDMM(reportController.startDate.value)} Đến ${SahaDateUtils().getDDMM(reportController.startDate.value)}",
                    markerSettings: MarkerSettings(
                        isVisible: true,
                        height: 4,
                        width: 4,
                        shape: DataMarkerType.circle,
                        borderWidth: 2,
                        borderColor: Theme.of(context).primaryColor),
                    dataSource: <ProductReport>[
                      ...List.generate(
                          (reportController.overView.value.charts ?? []).length,
                          (index) => ProductReport(
                              'Tháng ${(reportController.overView.value.charts ?? [])[index].month ?? 0}',
                              moneyReturn(index))),
                    ],
                    xValueMapper: (ProductReport sales, _) => sales.year,
                    yValueMapper: (ProductReport sales, _) => sales.sales,
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget summaryMotel() {
    return Column(
      children: [
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
                          reportController.dateWatch.value =
                              DateTime.parse("$v");
                          Get.back();
                        },
                        showActionButtons: true,
                        selectionMode: DateRangePickerSelectionMode.single,
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
                const Text("Ngày: "),
                const Spacer(),
                Obx(
                  () => Text(
                      SahaDateUtils().getDDMM(reportController.dateWatch.value)),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Tổng số phòng',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Text(
                        '${reportController.summaryMotel.value.totalMotel ?? 0}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Số phòng đã thuê',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Text(
                        '${reportController.summaryMotel.value.totalMotelRented ?? 0}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Số phòng còn trống',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Text(
                        '${reportController.summaryMotel.value.totalMotelAvailable ?? 0}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Số người đã thuê',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Text(
                        '${reportController.summaryMotel.value.totalrenterRented ?? 0}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }

  String titleReturn(int index) {
    return index == 0
        ? 'Tổng'
        : index == 1
            ? 'Phòng'
            : index == 2
                ? "Dịch vụ"
                : 'Giảm giá';
  }

  double moneyReturn(int index) {
    return reportController.indexChart.value == 0
        ? (reportController.overView.value.charts ?? [])[index].totalFinal ?? 0
        : reportController.indexChart.value == 1
            ? (reportController.overView.value.charts ?? [])[index]
                    .totalMoneyMotel ??
                0
            : reportController.indexChart.value == 2
                ? (reportController.overView.value.charts ?? [])[index]
                        .totalMoneyService ??
                    0
                : (reportController.overView.value.charts ?? [])[index]
                        .discount ??
                    0;
  }

  double moneyTitleReturn(int index) {
    return index == 0
        ? reportController.overView.value.totalFinal ?? 0
        : index == 1
            ? reportController.overView.value.totalMoneyMotel ?? 0
            : index == 2
                ? reportController.overView.value.totalMoneyService ?? 0
                : reportController.overView.value.totalDiscount ?? 0;
  }

  void chooseRangeTime(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      reportController.startDate.value = args.value.startDate;
      reportController.endDate.value =
          args.value.endDate ?? args.value.startDate;
    }
  }

  void chooseRangeTimeCP(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      // startDateCP = args.value.startDate;
      // endDateCP = args.value.endDate ?? args.value.startDate;
    }
  }
}

class ProductReport {
  ProductReport(this.year, this.sales);
  final String year;
  final double? sales;
}
