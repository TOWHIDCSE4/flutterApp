import 'package:get/get.dart';
import 'package:gohomy/model/report_post_violation.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class ReportPostViolationController extends GetxController {
  var listReportViolationPost = RxList<ReportPostViolation>();
  String? textSearch;
  var status = 0.obs;
  int currentPage = 1;
  var loadInit = false.obs;
  var isLoading = false.obs;
  bool isEnd = false;
  ReportPostViolationController() {
    getAllReportViolationPost(isRefresh: true);
  }
  Future<void> getAllReportViolationPost({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
      loadInit.value = true;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.adminManageRepository
            .getAllReportViolationPost(
          page: currentPage,
          search: textSearch,
          status: status.value,
        );

        if (isRefresh == true) {
          listReportViolationPost(data!.data!.data!);
          listReportViolationPost.refresh();
        } else {
          listReportViolationPost.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteReportPostViolation({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .deleteReportPostViolation(id: id);
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateReportPostViolation({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateReportPostViolation(id: id, status: 2);
      SahaAlert.showSuccess(message: 'Thành công');
      getAllReportViolationPost(isRefresh: true);
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
