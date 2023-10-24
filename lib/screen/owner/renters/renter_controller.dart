import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/renter.dart';

class ListTenantsController extends GetxController {
  var listTenantsSelected = RxList<Renter>();
  var listTenants = RxList<Renter>();
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  List<Renter>? listTenantsInput;
  String? textSearch;
  var status = 2;
  var loadInit = true.obs;
  bool isRented = true;
  

  ////
  DateTime? fromDate;
  DateTime? toDate;
  var fromDateController = TextEditingController();
  var toDateController = TextEditingController();
  var isSearch = false.obs;

  ListTenantsController({this.listTenantsInput}) {
    if (listTenantsInput != null) {
      listTenantsSelected(listTenantsInput);
    }
    getAllTenants(isRefresh: true);
  }

  Future<void> getAllTenants({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    /// status = 0 chua co phong, 2 la da thue phong
    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.manageRepository.getAllRenter(
            page: currentPage,
            search: textSearch,
           // isRenter: isRented,
            renterStatus: status,
            fromDate: fromDate,
            toDate: toDate);

        if (isRefresh == true) {
          listTenants(data!.data!.data!);
          listTenants.refresh();
        } else {
          listTenants.addAll(data!.data!.data!);
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

  Future<void> deleteTenants({required int tenantsId}) async {
    try {
      var data = await RepositoryManager.manageRepository
          .deleteRenter(renterId: tenantsId);
      listTenants.removeWhere((element) => tenantsId == element.id);
      Get.back();
      SahaAlert.showSuccess(message: "Đã xoá thành công");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }
}
