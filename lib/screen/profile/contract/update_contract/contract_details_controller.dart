import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/contract.dart';

import 'package:gohomy/utils/date_utils.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/image_assset.dart';
import '../../../../utils/string_utils.dart';

class UpdateContractController extends GetxController {
  TextEditingController rentalAgentEdit = TextEditingController();
  TextEditingController moneyRoomMonthAgentEdit = TextEditingController();
  TextEditingController depositMoneyMonthAgentEdit = TextEditingController();
  TextEditingController dateRangeEdit = TextEditingController();
  TextEditingController dateRangeToEdit = TextEditingController();
  TextEditingController dateBeginMoneyEdit = TextEditingController();
  TextEditingController noteEdit = TextEditingController();
  var noteEditRequest = TextEditingController();
  var contractRes = Contract().obs;

  var isLoading = false.obs;

  var listImages = RxList<ImageData>([]);

  bool? isUser;
  int? contractId;
  UpdateContractController({this.isUser, this.contractId}) {
    getContract();
  }

  Future<void> getContract() async {
    try {
      isLoading.value = true;

      var data = await RepositoryManager.userManageRepository
          .getContractUser(contractId: contractId!);

      contractRes.value = data!.data!;

      listImages((contractRes.value.images ?? [])
          .map((e) => ImageData(linkImage: e))
          .toList());

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

      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
