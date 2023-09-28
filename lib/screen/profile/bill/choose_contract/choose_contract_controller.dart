import 'package:get/get.dart';
import 'package:gohomy/model/tower.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/contract.dart';

class ChooseContractController extends GetxController{
   var listContract = RxList<Contract>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var status = 2.obs;
  var isLoading = false.obs;
  var loadInit = true.obs;

  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  DateTime? fromDateOption;
  DateTime? toDateOption;
  var checkSelected = false.obs;
  String? dateFrom;
  String? dateTo;
  Contract? contractInput;
  Tower? towerChoose;
  var contractChoose = Contract().obs;
  ChooseContractController({this.contractInput}) {
    if(contractInput!=null){
      contractChoose.value = contractInput!;
    }
    getAllContract(isRefresh: true);
  }

  Future<void> getAllContract({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.manageRepository.getAllContract(
            search: textSearch,
            page: currentPage,
            status: status.value,
            towerId: towerChoose?.id,
            dateFrom: dateFrom,
            dateTo: dateTo);

        if (isRefresh == true) {
          listContract(data!.data!.data!);
        } else {
          listContract.addAll(data!.data!.data!);
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
}}