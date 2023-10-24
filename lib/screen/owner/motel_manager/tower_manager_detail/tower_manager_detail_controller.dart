import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/support_manage_tower.dart';

class TowerManagerDetailController extends GetxController {
  var supportManageTower = SupportManageTower().obs;
  int supportId;
  var loadInit = false.obs;

  TowerManagerDetailController({required this.supportId}){
    getSupportManageTower();
  }
  Future<void> getSupportManageTower() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.manageRepository
          .getSupportManageTower(supportId: supportId);
      supportManageTower.value = res!.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
    Future<void> deleteTowerSupportManage({required int towerId}) async {
    
    try {
      var res = await RepositoryManager.manageRepository
          .deleteTowerSupportManage(supportId: supportId,towerId:towerId );
      SahaAlert.showSuccess(message: "Thành công");
      getSupportManageTower();
    
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
