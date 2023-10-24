import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../model/order.dart';

class OrdersAdminController extends GetxController {
  var listOrder = RxList<Order>();
  int currentPage = 1;
  bool isEnd = false;
  var status = 0.obs;
  var loadInit = true.obs;
  var isLoading = false.obs;
  var isSearch = false.obs;
  var textSearch = '';
  var statusCurrent = 0;

  TextEditingController searchEdit = TextEditingController();

  OrdersAdminController() {
    getAllOrder(isRefresh: true);
  }

  Future<void> getAllOrder({bool? isRefresh}) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }
   

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.adminManageRepository
            .getAllOrderAdmin(
                page: currentPage,
                search: textSearch,
                orderStatus: status.value);

        if (isRefresh == true) {
          listOrder(data!.data!.data!);
        } else {
          listOrder.addAll(data!.data!.data!);
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
}
