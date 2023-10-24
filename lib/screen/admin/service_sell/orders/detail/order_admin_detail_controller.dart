import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/order.dart';

import '../../../../../model/user.dart';

class OrderAdminDetailController extends GetxController {
  var order = Order().obs;
  int id;
  var loadInit = true.obs;
  OrderAdminDetailController({required this.id}) {
    getOrderAdmin(id: id);
  }

  Future<void> getOrderAdmin({required int id}) async {
    try {
      var res =
          await RepositoryManager.adminManageRepository.getOrderAdmin(id: id);
      order.value = res!.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<User?> getUserInfo({required int userId}) async {
    try {
      var res = await RepositoryManager.adminManageRepository.getUsers(userId: userId);
      return res!.data;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
    return null;
  }
}
