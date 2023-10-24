import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/user_manage/old_bill_res.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/bill.dart';
import '../../../../model/contract.dart';
import '../../../../model/motel_room.dart';

class AddBillController extends GetxController {
  TextEditingController dateEdit = TextEditingController();
  TextEditingController payDate = TextEditingController();
  TextEditingController payToDate = TextEditingController();
  TextEditingController noteTextEditingController = TextEditingController();
  var contractChoose = Contract().obs;
  var isUseDepositMoney = false.obs;
  var motelChoose = MotelRoom().obs;
  var isLoading = false.obs;
  var bill = OldBill().obs;

  var billReq = Bill().obs;
  Contract? contractInput;
  Bill? billInput;

  AddBillController({this.billInput,this.contractInput}) {
    if (billInput != null) {
      if (billInput?.totalMoneyHasPaidByDeposit != null &&
          billInput!.totalMoneyHasPaidByDeposit != 0) {
        isUseDepositMoney.value = true;
      }
      billReq.value = billInput!;
      dateEdit.text = billInput?.content ?? "";
      billReq.value.moService = [];
      billReq.value.moService!
          .addAll(billInput?.serviceClose?.listServiceCloseItems ?? []);
      noteTextEditingController.text = billInput?.note ?? "";
      contractChoose.value = Contract(id: billInput?.contractId);
    }
    if(contractInput != null){
      contractChoose.value = contractInput!;
      getBillRoom(contractChoose.value.motelId!);
    }
  }

  Future<void> getBillRoom(int roomId) async {
    billReq.value.moService = [];

    try {
      isLoading.value = true;
      var res = await RepositoryManager.userManageRepository
          .getBillRoom(roomId: roomId);
      bill.value = res!.data!;

      billReq.value.totalMoneyService = bill.value.bills?.totalMoneyService;
      billReq.value.totalMoneyMotel = bill.value.contracts?.money;
      billReq.value.totalFinal = bill.value.bills?.totalFinal;
      billReq.value.contractId = bill.value.contracts?.id;

      for (var e in (bill.value.bills?.serviceClose?.listServiceCloseItems ?? [])) {
        var service = e;
        service.oldQuantity = e.oldQuantity;
        service.quantity = 0;

        billReq.value.moService!.add(service);
      }

      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addBill() async {
    if (billReq.value.content == null) {
      SahaAlert.showError(message: 'Chưa chọn tháng hoá đơn');
      return;
    }
    if (contractChoose.value.id == null) {
      SahaAlert.showError(message: 'Chưa chọn hợp đồng');
      return;
    }
    try {
      var res =
          await RepositoryManager.manageRepository.addBill(bill: billReq.value);
      SahaAlert.showSuccess(message: "Đã lên đơn");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateBill() async {
      if (billReq.value.content == null) {
      SahaAlert.showError(message: 'Chưa chọn tháng hoá đơn');
      return;
    }
    if (contractChoose.value.id == null) {
      SahaAlert.showError(message: 'Chưa chọn hợp đồng');
      return;
    }
    try {
      var res = await RepositoryManager.manageRepository
          .updateBill(billId: billReq.value.id!, bill: billReq.value);
      SahaAlert.showSuccess(message: "Đã sửa thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
