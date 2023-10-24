import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../utils/date_utils.dart';
import '../over_view_controller.dart';

// ignore: must_be_immutable
class RenterChart extends StatefulWidget {
  @override
  _RenterChartState createState() => _RenterChartState();
}

class _RenterChartState extends State<RenterChart> {
  OverviewReportController saleReportController = Get.find();
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
                      titleReturn(saleReportController.indexChartRenter.value)),
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
                      (saleReportController.reportRenter.value.charts ?? [])
                          .length,
                      (index) => SalesData(
                          saleReportController.reportRenter.value.typeChart == "month" ? saleReportController.listMonth[index] : saleReportController.reportRenter.value.typeChart == "hour" ? "${saleReportController.reportRenter.value.charts![index].time!.hour}h" : SahaDateUtils().getDDMM(saleReportController.reportRenter.value.charts![index].time!),
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
    return 'Tổng số người thuê';
  }

  double moneyReturn(int index) {
    return ((saleReportController.reportRenter.value.charts ?? [])[index]
                .totalRenter ??
            0)
        .toDouble();
  }

  double moneyTitleReturn(int index) {
    return (saleReportController.reportRenter.value.totalRenter ?? 0)
        .toDouble();
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
