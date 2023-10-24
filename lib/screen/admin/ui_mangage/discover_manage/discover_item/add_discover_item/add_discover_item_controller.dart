import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/admin_discover_item.dart';

class AddDiscoverItemController extends GetxController {
  var linkUrl = "".obs;
  var adminDiscoverItem = AdminDiscoverItem().obs;
  var name = ''.obs;
  Future<void> addDiscoverItem() async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .addDiscoverItem(adminDiscoverItem: adminDiscoverItem.value);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
