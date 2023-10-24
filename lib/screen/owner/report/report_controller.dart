import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/remote/response-request/report/overview_res.dart';
import 'package:gohomy/data/remote/response-request/report/summary_motel_res.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

class ReportController extends GetxController {
  var overView = OverView().obs;
  var summaryMotel = SummaryMotel().obs;
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;
  var indexChart = 0.obs;
  var dateWatch = DateTime.now().obs;
  var hasChooseTime = false.obs;

  ReportController() {
    getOverView();
    getSummaryMotel();
  }

  Future<void> getOverView() async {
    try {
      var data = await RepositoryManager.reportRepository.getOverView(
        startDate: startDate.value,
        endDate: endDate.value,
      );
      overView(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getSummaryMotel() async {
    try {
      var data = await RepositoryManager.reportRepository.getSummaryMotel(
        startDate: dateWatch.value,
        endDate: dateWatch.value,
      );
      summaryMotel(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
