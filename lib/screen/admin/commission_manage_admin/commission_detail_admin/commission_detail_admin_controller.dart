import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/commission_manage.dart';
import '../../../../model/image_assset.dart';

class CommissionDetailAdminController extends GetxController {
  var commissionManage = CommissionManage().obs;
  var loadInit = true.obs;
  var listImages = RxList<ImageData>([]);
  int id;
  CommissionDetailAdminController({required this.id}) {
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
    loadInit.value = false;
  }

  Future<void> confirmCommissionAdmin({required int status}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .confirmCommissionAdmin(id: id, status: status);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
