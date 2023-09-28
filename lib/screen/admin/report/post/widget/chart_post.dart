import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../utils/date_utils.dart';
import '../post_report_controller.dart';

// ignore: must_be_immutable
class PostChart extends StatefulWidget {
  @override
  _PostChartState createState() => _PostChartState();
}

class _PostChartState extends State<PostChart> {
  PostReportController saleReportController = Get.find();
  late List<Widget> listChart;

  @override
  void initState() {
    super.initState();
  }

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
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            saleReportController.changeTypeChart(index);
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
                                          color: (saleReportController
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
                                            color: (saleReportController
                                                        .indexChart.value ==
                                                    index
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey[500])!),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        SahaStringUtils().convertToMoney(moneyTitleReturn(index)),
                                        style: TextStyle(
                                            color: (saleReportController
                                                        .indexChart.value ==
                                                    index
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey[500])!),
                                      ),
                                    ],
                                  ),
                                ),
                                saleReportController.indexChart.value == index
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
                                saleReportController.indexChart.value == index
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
                      titleReturn(saleReportController.indexChart.value)),
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
                      "${SahaDateUtils().getDDMM(saleReportController.fromDay.value)} Đến ${SahaDateUtils().getDDMM(saleReportController.toDay.value)}",
                  markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 4,
                      width: 4,
                      shape: DataMarkerType.circle,
                      borderWidth: 2,
                      borderColor: Colors.green),
                  dataSource: <SalesData>[
                    ...List.generate(
                      (saleReportController.reportPost.value.charts ?? [])
                          .length,
                      (index) => SalesData(
                          saleReportController.reportPost.value.typeChart == "month" ? saleReportController.listMonth[index] : saleReportController.reportPost.value.typeChart == "hour" ? "${saleReportController.reportPost.value.charts![index].time!.hour}h" : SahaDateUtils().getDDMM(saleReportController.reportPost.value.charts![index].time!),
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
        ? 'Số bài đăng'
        : index == 1
            ? 'Số bài đăng xác nhận'
            : index == 2
                ? 'Số bài đăng chờ xác nhận'
                : index == 3
                    ? 'Số bài đăng huỷ'
                    : index == 4
                        ? 'Số bài đăng xác thực'
                        : 'Số bài đăng chưa xác thực';
  }

  double moneyReturn(int index) {
    return saleReportController.indexChart.value == 0
        ? ((saleReportController.reportPost.value.charts ?? [])[index]
                    .totalMoPost ??
                0)
            .toDouble()
        : saleReportController.indexChart.value == 1
            ? ((saleReportController.reportPost.value.charts ?? [])[index]
                        .totalMoPostApproved ??
                    0)
                .toDouble()
            : saleReportController.indexChart.value == 2
                ? ((saleReportController.reportPost.value.charts ?? [])[index]
                            .totalMoPostPending ??
                        0)
                    .toDouble()
                : saleReportController.indexChart.value == 3
                    ? ((saleReportController.reportPost.value.charts ??
                                    [])[index]
                                .totalMoPostCancel ??
                            0)
                        .toDouble()
                    : saleReportController.indexChart.value == 4
                        ? ((saleReportController.reportPost.value.charts ??
                                        [])[index]
                                    .totalMoPostVerified ??
                                0)
                            .toDouble()
                        : ((saleReportController.reportPost.value.charts ??
                                        [])[index]
                                    .totalMoPostUnverified ??
                                0)
                            .toDouble();
  }

  double moneyTitleReturn(int index) {
    return index == 0
        ? (saleReportController.reportPost.value.totalMoPost ?? 0).toDouble()
        : index == 1
            ? (saleReportController.reportPost.value.totalMoPostApproved ?? 0)
                .toDouble()
            : index == 2
                ? (saleReportController.reportPost.value.totalMoPostPending ??
                        0)
                    .toDouble()
                : index == 3
                    ? (saleReportController
                                .reportPost.value.totalMoPostCancel ??
                            0)
                        .toDouble()
                    : index == 4
                        ? (saleReportController
                                    .reportPost.value.totalMoPostVerified ??
                                0)
                            .toDouble()
                        : (saleReportController
                                    .reportPost.value.totalMoPostUnverified ??
                                0)
                            .toDouble();
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
