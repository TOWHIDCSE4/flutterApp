import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/commission_manage.dart';
import '../../../../model/image_assset.dart';

class CommissionPaymentDetailController extends GetxController {
  var commissionManage = CommissionManage().obs;
  var loadInit = true.obs;
  var listImages = RxList<ImageData>([]);
  int id;
  CommissionPaymentDetailController({required this.id}) {
    getCommissionAdmin(id: id);
  }

  Future<void> getCommissionAdmin({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .getCommissionAdmin(id: id);
      commissionManage.value = res!.data!;

      listImages((commissionManage.value.imagesHostPaid ?? [])
          .map((e) => ImageData(linkImage: e))
          .toList());
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> confirmCommissionUser({required int status}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .confirmCommissionUser(id: id, status: status);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
