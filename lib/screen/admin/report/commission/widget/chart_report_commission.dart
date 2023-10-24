import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/report/commission/report_commission_controller.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../utils/date_utils.dart';
import '../../../../../utils/string_utils.dart';

class ReportCommissionChart extends StatefulWidget {
  const ReportCommissionChart({super.key});

  @override
  State<ReportCommissionChart> createState() => _ReportCommissionChartState();
}

class _ReportCommissionChartState extends State<ReportCommissionChart> {
  ReportCommissionController reportCommissionController = Get.find();
  late List<Widget> listChart;
  @override
  Widget build(BuildContext context) {
    var checkLandscape = context.isLandscape;
    return Column(
      children: [
        checkLandscape == true
            ? Container()
            : Column(
                children: [
                  SizedBox(
                    height: 115,
                    width: Get.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            reportCommissionController.changeTypeChart(index);
                          },
                          child: Obx(
                            () => Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(4.0),
                                  padding: const EdgeInsets.all(4.0),
                                  width: (Get.width - 60) / 2,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: (reportCommissionController
                                                      .indexChart.value ==
                                                  index
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey[500])!),
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        titleReturn(index),
                                        style: TextStyle(
                                            color: (reportCommissionController
                                                        .indexChart.value ==
                                                    index
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey[500])!),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${SahaStringUtils().convertToMoney(moneyTitleReturn(index))} VND",
                                        style: TextStyle(
                                            color: (reportCommissionController
                                                        .indexChart.value ==
                                                    index
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey[500])!),
                                      ),
                                    ],
                                  ),
                                ),
                                reportCommissionController.indexChart.value ==
                                        index
                                    ? Positioned(
                                        height: 30,
                                        width: 30,
                                        top: 5,
                                        right: 5,
                                        child: SvgPicture.asset(
                                          "assets/icons/levels.svg",
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )
                                    : Container(),
                                reportCommissionController.indexChart.value ==
                                        index
                                    ? Positioned(
                                        height: 15,
                                        width: 15,
                                        top: 5,
                                        right: 5,
                                        child: Icon(
                                          Icons.check,
                                          size: 15,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .headline6!
                                              .color,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
        Obx(
          () => Container(
            padding: const EdgeInsets.all(5.0),
            height: 500,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              onTrackballPositionChanging: (TrackballArgs args) {
                args.chartPointInfo.header = DateFormat('H:m')
                    .format(args.chartPointInfo.chartDataPoint!.x);
              },
              title: ChartTitle(
                  text:
                      titleReturn(reportCommissionController.indexChart.value)),
              // Enable legend
              legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  toggleSeriesVisibility: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(
                enable: true,
              ),
              onTooltipRender: (TooltipArgs args) {
                var pointIndex = args.seriesIndex;
                if (pointIndex == 0) {
                  args.header = '';
                } else {
                  args.header = '';
                }
                // args.text = args.da taPoints[pointIndex].x.toString() +
                //     ' has value of: ' +
                //     args.dataPoints[pointIndex].y.toString();
              },
              primaryYAxis: NumericAxis(
                numberFormat: NumberFormat.compact(),
              ),
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                  legendItemText:
                      "${SahaDateUtils().getDDMM(reportCommissionController.fromDay.value)} Đến ${SahaDateUtils().getDDMM(reportCommissionController.toDay.value)}",
                  markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 4,
                      width: 4,
                      shape: DataMarkerType.circle,
                      borderWidth: 2,
                      borderColor: Colors.green),
                  dataSource: <SalesData>[
                    ...List.generate(
                      (reportCommissionController
                                  .reportCommission.value.charts ??
                              [])
                          .length,
                      (index) => SalesData(
                          reportCommissionController.reportCommission.value.typeChart == "month" ? reportCommissionController.listMonth[index] : reportCommissionController.reportCommission.value.typeChart == "hour" ? "${reportCommissionController.reportCommission.value.charts![index].time!.hour}h" : SahaDateUtils().getDDMM(reportCommissionController.reportCommission.value.charts![index].time!),
                          moneyReturn(index)),
                    )
                  ],
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
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
    );
  }

  String titleReturn(int index) {
    return index == 0
        ? 'Số tiền trả cộng tác viên'
        : index == 1
            ? 'Số tiền nhận được'
            : index == 2
                ? 'Lợi nhuận'
                : '';
  }

  double moneyReturn(int index) {
    return reportCommissionController.indexChart.value == 0
        ? ((reportCommissionController.reportCommission.value.charts ??
                        [])[index]
                    .totalMoneyCommissionAdminPaidCollaborator ??
                0)
            .toDouble()
        : reportCommissionController.indexChart.value == 1
            ? ((reportCommissionController.reportCommission.value.charts ??
                            [])[index]
                        .totalMoneyCommissionAdminReceived ??
                    0)
                .toDouble()
            : reportCommissionController.indexChart.value == 2
                ? ((reportCommissionController.reportCommission.value.charts ??
                                [])[index]
                            .totalMoneyCommissionAdminRevenue ??
                        0)
                    .toDouble()
                : 0;
  }

  double moneyTitleReturn(int index) {
    return index == 0
        ? (reportCommissionController.reportCommission.value
                    .totalMoneyCommissionAdminPaidCollaborator ??
                0)
            .toDouble()
        : index == 1
            ? (reportCommissionController.reportCommission.value
                        .totalMoneyCommissionAdminReceived ??
                    0)
                .toDouble()
            : index == 2
                ? (reportCommissionController.reportCommission.value
                            .totalMoneyCommissionAdminRevenue ??
                        0)
                    .toDouble()
                : 0;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
