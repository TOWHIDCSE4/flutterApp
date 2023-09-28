import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/contract.dart';
import 'package:gohomy/model/motel_room.dart';
import 'package:gohomy/model/renter.dart';
import 'package:gohomy/model/service.dart';
import 'package:gohomy/utils/date_utils.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/image_assset.dart';
import '../../../../model/tower.dart';
import '../../../../utils/string_utils.dart';

class AddContractController extends GetxController {
  TextEditingController rentalAgentEdit = TextEditingController();
  TextEditingController moneyRoomMonthAgentEdit = TextEditingController();
  TextEditingController depositMoneyMonthAgentEdit = TextEditingController();
  TextEditingController dateRangeEdit = TextEditingController();
  TextEditingController dateRangeToEdit = TextEditingController();
  TextEditingController dateBeginMoneyEdit = TextEditingController();
  TextEditingController noteEdit = TextEditingController();
  
  var representative = Renter().obs;
  var cmnd = TextEditingController();
 
  var motelChoose = MotelRoom().obs;
  var towerChoose = Tower().obs;
  var listRenterChoose = RxList<Renter>();
  var listServiceChoose = RxList<Service>();
  var contractReq = Contract().obs;
  var isLoadingUpdate = false.obs;
  var contractRes = Contract().obs;
  bool isEnd = false;
  var isLoading = false.obs;
  List<Service> moServicesSave = [];
  var listImages = RxList<ImageData>([]);
  int? contractId;
  MotelRoom? motelRoomInput;
  bool? ignoring;
  bool? isUser;
  var fromTime = DateTime.now();

  ////truyền thông tin tower,motel từ người thuê vào towerChoose,motelChoose
  Tower? tower;
 

  ////đi từ màn người thuê
  Renter? renterInput;

  var doneUploadImage = true.obs;

  AddContractController(
      {this.ignoring, this.isUser, this.contractId, this.motelRoomInput,this.renterInput,this.tower}) {
    contractReq.value.images = [];
    contractReq.value.moServicesReq = [];
    contractReq.value.listRenter = [];
    contractReq.value.furniture = [];
    if(tower != null){
      towerChoose.value = tower!;
      contractReq.value.towerId = tower?.id;
    }
   
    if(renterInput !=null){
      renterInput!.isRepresent = true;
      listRenterChoose.add(renterInput!);
    }
    if (motelRoomInput != null) {
      motelChoose.value = motelRoomInput!;
      convertRequest();
    }
    if (contractId != null) {
      getContract();
    }
  }

  Future<void> getContract() async {
    try {
      isLoading.value = true;

      var data = await RepositoryManager.manageRepository
          .getContract(contractId: contractId!);
      contractRes.value = data!.data!;
      contractReq.value = contractRes.value;
      contractReq.value.listRenter = contractRes.value.listRenter;
      listRenterChoose(contractRes.value.listRenter);
      motelChoose(MotelRoom(
          id: contractRes.value.motelId,
          motelName: contractRes.value.motelRoom?.motelName ?? ""));
     
      contractReq.value.images = contractRes.value.images ?? [];
      listImages((contractRes.value.images ?? [])
          .map((e) => ImageData(linkImage: e))
          .toList());

      contractReq.value.moServicesReq = contractRes.value.moServices ?? [];
      moServicesSave = contractRes.value.moServices ?? [];
      contractReq.value = contractRes.value;
      motelChoose.value = contractRes.value.motelRoom!;
      rentalAgentEdit.text = contractRes.value.rentalAgent ?? "";
      noteEdit.text = contractRes.value.note ?? "";
      moneyRoomMonthAgentEdit.text =
          SahaStringUtils().convertToUnit(contractRes.value.money);
      depositMoneyMonthAgentEdit.text =
          SahaStringUtils().convertToUnit(contractRes.value.depositMoney);
      dateRangeEdit.text = SahaDateUtils()
          .getDDMMYY(contractRes.value.rentFrom ?? DateTime.now());
      dateRangeToEdit.text =
          SahaDateUtils().getDDMMYY(contractRes.value.rentTo ?? DateTime.now());
      dateBeginMoneyEdit.text = SahaDateUtils()
          .getDDMMYY(contractRes.value.startDate ?? DateTime.now());
        if(contractRes.value.towerId!=null){
           towerChoose.value = contractRes.value.tower ?? Tower();
        }
        print("=====>${contractReq.value.cmndNumber}");
      cmnd.text = contractReq.value.cmndNumber ?? '';
      
      // getAllService();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  void convertRequest() {
    //contractReq.value.images = motelChoose.value.images ?? [];
    contractReq.value.moServicesReq = motelChoose.value.moServices ?? [];
    contractReq.value.motelId = motelChoose.value.id;

    contractReq.value.money = motelChoose.value.money;
    moneyRoomMonthAgentEdit.text =
        SahaStringUtils().convertToUnit(motelChoose.value.money ?? "0");

    contractReq.value.depositMoney = motelChoose.value.deposit;
    depositMoneyMonthAgentEdit.text =
        SahaStringUtils().convertToUnit(motelChoose.value.deposit ?? "0");
    contractReq.value.furniture = motelChoose.value.furniture ?? [];

    contractReq.refresh();
  }

  Future<void> addContract() async {
    try {
      contractReq.value.listRenter = listRenterChoose;
      if (!(contractReq.value.listRenter ?? [])
          .map((e) => e.isRepresent)
          .toList()
          .contains(true)) {
        SahaAlert.showError(message: "Chưa chọn người đại diện");
        return;
      }
      if (contractReq.value.paymentSpace == null) {
        SahaAlert.showError(message: "Chưa chọn kỳ hạn thanh toán");
        return;
      }
      if (contractReq.value.images!.isEmpty) {
        SahaAlert.showError(message: "Chưa chọn ảnh");
        return;
      }
      if (contractReq.value.rentFrom == null) {
        SahaAlert.showError(message: "Chưa nhập thời hạn");
        return;
      }
      if (contractReq.value.rentTo == null) {
        SahaAlert.showError(message: "Chưa nhập thời hạn");
        return;
      }
      if (contractReq.value.startDate == null) {
        SahaAlert.showError(message: "Chưa nhập ngày bắt đầu tính tiền");
        return;
      }
      if (contractReq.value.money == null) {
        SahaAlert.showError(message: "Chưa nhập tiền phòng");
        return;
      }
      if (contractReq.value.depositMoney == null) {
        SahaAlert.showError(message: "Chưa nhập tiền cọc");
        return;
      }

      var data = await RepositoryManager.manageRepository.addContract(
        contract: contractReq.value,
      );
      SahaAlert.showSuccess(message: "Thêm thành công");
      Get.back(result: 'create_success');
      if (motelRoomInput != null) {
        Get.back();
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateContract() async {
    isLoadingUpdate.value = true;
    contractReq.value.listRenter = listRenterChoose;
    try {
      if (!(contractReq.value.listRenter ?? [])
          .map((e) => e.isRepresent)
          .toList()
          .contains(true)) {
        SahaAlert.showError(message: "Chưa chọn người đại diện");
        return;
      }
      if (contractReq.value.paymentSpace == null) {
        SahaAlert.showError(message: "Chưa chọn kỳ hạn thanh toán");
        return;
      }
      if (contractReq.value.images!.isEmpty) {
        SahaAlert.showError(message: "Chưa chọn ảnh");
        return;
      }

      if (contractReq.value.rentFrom == null) {
        SahaAlert.showError(message: "Chưa nhập thời hạn");
        return;
      }
      if (contractReq.value.rentTo == null) {
        SahaAlert.showError(message: "Chưa nhập thời hạn");
        return;
      }
      if (contractReq.value.startDate == null) {
        SahaAlert.showError(message: "Chưa nhập ngày bắt đầu tính tiền");
        return;
      }
      if (contractReq.value.money == null) {
        SahaAlert.showError(message: "Chưa nhập tiền phòng");
        return;
      }
      if (contractReq.value.depositMoney == null) {
        SahaAlert.showError(message: "Chưa nhập tiền cọc");
        return;
      }
      var data = await RepositoryManager.manageRepository.updateContract(
        contractId: contractId!,
        contract: contractReq.value,
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
  }

  Future<void> confirmContract() async {
    isLoadingUpdate.value = true;
    contractReq.value.listRenter = listRenterChoose;
    try {
      var data =
          await RepositoryManager.userManageRepository.updateContractUser(
        contractId: contractId!,
        isConfirmed: true,
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
  }

  Future<void> deleteContract({required int contractId}) async {
    try {
      var data = await RepositoryManager.manageRepository
          .deleteContract(contractId: contractId);
      Get.back();
      SahaAlert.showSuccess(message: "Đã xoá hợp đồng");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }

  Future<void> confirmDeposit({required int id}) async {
    try {
      var data = await RepositoryManager.manageRepository
          .confirmDeposit(contractId: id, status: 2);
      Get.back();
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }

  Future<void> changeStatus({required int id, required int status}) async {
    try {
      var data = await RepositoryManager.manageRepository
          .confirmDeposit(contractId: id, status: status);
      Get.back();
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }
  void convertInfoFromRenter(Renter renter){
    towerChoose.value = Tower(id: renter.towerId,towerName: renter.nameTowerExpected);
    motelChoose.value = renter.motelRoom ?? MotelRoom();
    convertRequest();
  }
}
