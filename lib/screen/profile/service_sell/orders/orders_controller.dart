import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../model/order.dart';

class OrdersController extends GetxController {

  var listOrder = RxList<Order>();
  int currentPage = 1;
  bool isEnd = false;
  var loadInit = true.obs;
  var isLoading = false.obs;
  var isSearch = false.obs;
  var textSearch = '';
  var statusCurrent = 0;
  var status = 0.obs;

  TextEditingController searchEdit = TextEditingController();

  OrdersController() {
    getAllOrder(isRefresh: true);
  }

  Future<void> getAllOrder({
    bool? isRefresh,
    
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }
   
    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.serviceSellRepository
            .getAllOrder(page:currentPage, search: textSearch, orderStatus: status.value);

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