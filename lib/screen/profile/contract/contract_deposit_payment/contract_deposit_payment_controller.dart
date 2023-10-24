import 'package:get/get.dart';
import 'package:gohomy/screen/profile/contract/contract_deposit_payment/payment_successful_screen.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/contract.dart';
import '../../../../model/image_assset.dart';

class ContractDepositPaymentController extends GetxController {
  var isLoadingUpdate = false.obs;
  var contractInput = Contract();

  ContractDepositPaymentController({required this.contractInput}) {
    listImages((contractInput.imagesDeposit ?? [])
        .map((e) => ImageData(linkImage: e))
        .toList());
    images = contractInput.imagesDeposit ?? [];
  }

  var listImages = RxList<ImageData>([]);
  var images = <String>[];

  Future<void> confirmContract({required int id}) async {
    isLoadingUpdate.value = true;
    try {
      var data = await RepositoryManager.userManageRepository
          .updateContractUser(
              contractId: id,
              isConfirmed: true,
              depositAmountpaid: contractInput.depositMoney,
              listImagepayment: images);
      if(data != null) {
        Get.to(() => const PaymentSuccessfulScreen());
      }

      // Get.back();
      // Get.back();
      // Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
  }
}
