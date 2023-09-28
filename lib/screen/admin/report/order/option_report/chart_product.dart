import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../utils/date_utils.dart';
import '../../../../../utils/string_utils.dart';
import '../order_report_controller.dart';

class ChartProduct extends StatefulWidget {
  @override
  _ChartProductState createState() => _ChartProductState();
}

class _ChartProductState extends State<ChartProduct> {
  OrderReportController saleReportController = Get.find();
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var checkLandscape = context.isLandscape;
    return Obx(
      () => Column(
        children: [
          checkLandscape == true
              ? Container()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          const Spacer(),
                          Icon(
                            Icons.read_more_outlined,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 115,
                      width: Get.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              saleReportController
                                  .changeChooseChartProduct(index);
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
                                                        .listChooseChartProduct[
                                                    index]
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey[500])!),
                                        borderRadius: BorderRadius.circular(2)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            saleReportController.listNameChartProduct[index]),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          saleReportController.listNameServiceTop[index],
                                          maxLines: 1,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                            SahaStringUtils().convertToMoney(saleReportController.listPropertiesTop[index].toDouble())),
                                      ],
                                    ),
                                  ),
                                  saleReportController
                                          .listChooseChartProduct[index]
                                      ? Positioned(
                                          height: 30,
                                          width: 30,
                                          top: 4,
                                          right: 4,
                                          child: SvgPicture.asset(
                                            "assets/icons/levels.svg",
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        )
                                      : Container(),
                                  saleReportController
                                          .listChooseChartProduct[index]
                                      ? Positioned(
                                          height: 15,
                                          width: 15,
                                          top: 4,
                                          right: 4,
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
          Container(
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
                    text:
                        saleReportController.listTopSellingService.isNotEmpty ? "" : "Lượt xem sản phẩm"),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  header: "",
                ),
                series: <ColumnSeries<ProductReport, String>>[
                  ColumnSeries<ProductReport, String>(
                    width: 0.4,
                    legendItemText:
                        "${SahaDateUtils().getDDMM(saleReportController.fromDay.value)} Đến ${SahaDateUtils().getDDMM(saleReportController.toDay.value)}",
                    markerSettings: MarkerSettings(
                        isVisible: true,
                        height: 4,
                        width: 4,
                        shape: DataMarkerType.circle,
                        borderWidth: 2,
                        borderColor: Theme.of(context).primaryColor),
                    dataSource: <ProductReport>[
                      ...List.generate(
                        saleReportController.indexTypeChart.value == 0
                            ? saleReportController.listTopSellingService.length
                            : saleReportController.listTopRevenueService.length,
                        (index) => ProductReport(
                          '${saleReportController.indexTypeChart.value == 0 ? saleReportController.listTopSellingService[index].serviceSell!.name : saleReportController.listTopRevenueService[index].serviceSell!.name}',
                          saleReportController.indexTypeChart.value == 0
                              ? (saleReportController
                                          .listTopSellingService[index]
                                          .quantity ??
                                      0)
                                  .toDouble()
                              : saleReportController
                                  .listTopRevenueService[index].totalPrice!,
                        ),
                      ),
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
                ]),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class ProductReport {
  ProductReport(this.year, this.sales);
  final String year;
  final double sales;
}
