import 'package:get/get.dart';
import 'package:gohomy/model/decentralization.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/user.dart';

class AdminDetailController extends GetxController {
  var admin = User().obs;
  var isLoading = true.obs;
  int id;
  var decentralizationChoose = Decentralization().obs;
  AdminDetailController({required this.id}) {
    getUser(userId: id);
  }
  Future<void> getUser({required int userId}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .getUsers(userId: userId);
      admin.value = res!.data!;
      isLoading.value = false;
      decentralizationChoose.value =
          admin.value.decentralization ?? Decentralization();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> decentralizationAdmin() async {
    if (decentralizationChoose.value.id == null) {
      SahaAlert.showError(message: 'Bạn chưa phân quyền cho admin này');
      return;
    }
    try {
      var res = await RepositoryManager.adminManageRepository
          .decentralizationAdmin(
              userId: id, decentralizationId: decentralizationChoose.value.id!);
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateUser({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateUser(userId: id, user: admin.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
