import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/admin_discover.dart';

import '../../../../../components/arlert/saha_alert.dart';

class AddDiscoverController extends GetxController {
  var adminDiscover = AdminDiscover().obs;
  var name = ''.obs;
  var linkUrl = "".obs;
  Future<void> addDiscover() async {
    try {
      if (adminDiscover.value.province == null) {
        SahaAlert.showError(message: 'Chưa chọn địa điểm');
        return;
      }
      if (adminDiscover.value.image == null) {
        SahaAlert.showError(message: 'Chưa chọn ảnh');
        return;
      }
      var res = await RepositoryManager.adminManageRepository
          .addDiscover(adminDiscover: adminDiscover.value);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
