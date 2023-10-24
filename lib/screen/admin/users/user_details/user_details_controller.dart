import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../model/user.dart';

class UserDetailsController extends GetxController {
  var user = User().obs;
  var isLoading = true.obs;
  var onTapInfoBank = false.obs;

  Future<void> getUser(int userId) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .getUsers(userId: userId);
      user.value = res!.data!;
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteUser({required int id}) async {
    try {
      var res =
          await RepositoryManager.adminManageRepository.deleteUsers(id: id);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateUser({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateUser(userId: id, user: user.value);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
