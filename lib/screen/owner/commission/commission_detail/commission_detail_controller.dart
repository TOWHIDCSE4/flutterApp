import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/commission_manage.dart';

import '../../../../model/image_assset.dart';

class CommissionDetailManageController extends GetxController {
  var commissionManage = CommissionManage().obs;
  var loadInit = true.obs;
  var listImages = RxList<ImageData>([]);
  int id;
  CommissionDetailManageController({required this.id}) {
    getCommissionManage(id: id);
  }

  Future<void> getCommissionManage({required int id}) async {
    try {
      var res =
          await RepositoryManager.manageRepository.getCommissionManage(id: id);
      commissionManage.value = res!.data!;
      listImages((commissionManage.value.imagesHostPaid ?? [])
          .map((e) => ImageData(linkImage: e))
          .toList());
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> confirmCommissionManage({required int id}) async {
    try {
      var res = await RepositoryManager.manageRepository
          .confirmCommissionManage(
              id: id, commissionManage: commissionManage.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
