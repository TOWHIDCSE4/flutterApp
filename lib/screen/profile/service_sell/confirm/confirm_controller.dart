import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/remote/response-request/service_sell/info_order_req.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/address_order.dart';
import '../../../../model/cart_item.dart';
import '../../../data_app_controller.dart';

class ConfirmController extends GetxController {
  var infoOrder = InfoOrderReq().obs;
  var loading = false.obs;

  var listAddressOrder = RxList<AddressOrder>();
  DataAppController dataAppController = Get.find();

  ConfirmController() {
    convertAddress();
    getAllAddressOrder();
    
  }
  Future<void> order({required Function onSuccess}) async {
    if (infoOrder.value.addressDetail == null ||
        infoOrder.value.addressDetail == "") {
      SahaAlert.showError(message: 'Chưa chọn địa chỉ');
      return;
    }
    if (infoOrder.value.name == null || infoOrder.value.name == "") {
      SahaAlert.showError(message: 'Chưa có thông tin người nhận');
      return;
    }
    if (infoOrder.value.phoneNumber == null ||
        infoOrder.value.phoneNumber == "") {
      SahaAlert.showError(message: 'Chưa có thông tin người nhận');
      return;
    }
    loading.value = true;

    try {
      var data = await RepositoryManager.serviceSellRepository
          .order(infoOrderReq: infoOrder.value);
      onSuccess(data!.data!);
      dataAppController.getBadge();
      loading.value = false;
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }

  void convertAddress() {
    infoOrder.value.name = dataAppController.currentUser.value.name ?? '';
    infoOrder.value.phoneNumber =
        dataAppController.currentUser.value.phoneNumber;
    // if ((dataAppController.currentUser.value.listMotelRented ?? [])
    //     .isNotEmpty) {
    //   infoOrder.value.addressDetail =
    //       dataAppController.currentUser.value.listMotelRented![0].addressDetail;
    //   infoOrder.value.districtName =
    //       dataAppController.currentUser.value.listMotelRented![0].districtName;
    //   infoOrder.value.provinceName =
    //       dataAppController.currentUser.value.listMotelRented![0].provinceName;
    //   infoOrder.value.wardsName =
    //       dataAppController.currentUser.value.listMotelRented![0].wardsName;
    //   infoOrder.value.wards =
    //       dataAppController.currentUser.value.listMotelRented![0].wards;
    //   infoOrder.value.district =
    //       dataAppController.currentUser.value.listMotelRented![0].district;
    //   infoOrder.value.province =
    //       dataAppController.currentUser.value.listMotelRented![0].province;
    // }
  }

    Future<void> getAllAddressOrder() async {
    try {
      var res = await RepositoryManager.serviceSellRepository
          .getAllAddressOrder(page: 1);
      listAddressOrder.value = res!.data!.data!;
      if(listAddressOrder.isNotEmpty){
        
         infoOrder.value.addressDetail =
         listAddressOrder[0].addressDetail;
      infoOrder.value.districtName =
         listAddressOrder[0].districtName;
      infoOrder.value.provinceName =
         listAddressOrder[0].provinceName;
      infoOrder.value.wardsName =
         listAddressOrder[0].wardsName;
      infoOrder.value.wards =
         listAddressOrder[0].wards;
      infoOrder.value.district =
          listAddressOrder[0].district;
      infoOrder.value.province =
          listAddressOrder[0].province;
          infoOrder.refresh();
      }
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
