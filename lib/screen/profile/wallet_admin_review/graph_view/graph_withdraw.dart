import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gohomy/screen/profile/wallet_admin_review/graph_view/graph_controller.dart';
import 'package:gohomy/screen/profile/wallet_admin_review/wallet_admin_review.dart';

class GraphWithdraw extends StatefulWidget {
  const GraphWithdraw({super.key});

  @override
  State<GraphWithdraw> createState() => _GraphWithdrawState();
}

class _GraphWithdrawState extends State<GraphWithdraw> {
  GraphController graphController = GraphController(
    type: 'withdraw'
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quản lý ví Renren'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_today_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Obx(() => Column(
          children: [
            const Text(
              'Graph of withdraw',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF3F3F3F),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 1.06,
                letterSpacing: -0.50,
              ),
            ),
            YearDropdownMenuBar(
              selectedYear: graphController.selectedYear,
              onSelectYear: graphController.changeYear,
            ),
            LimitedBox(
              maxHeight: 300,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: DataChart(
                    type: DataChartType.withdraw,
                    dataGraph: graphController.dataGraph.toList()),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
