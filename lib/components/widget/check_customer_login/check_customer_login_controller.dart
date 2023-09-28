import 'package:get/get.dart';

import '../../../data/remote/response-request/account/all_noti_user_res.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../screen/data_app_controller.dart';
import '../../arlert/saha_alert.dart';

class CheckCustomerLoginController extends GetxController{
   DataAppController dataAppController = Get.find();
  var listNotiUser = RxList<NotiUser>();
  var listIdUser = <int>[];
  var loadInit = false.obs;
  CheckCustomerLoginController() {
    listIdUser = dataAppController.listUserLogin.map((e) => e.id!).toList();
    
     if(listIdUser.isNotEmpty){
       getAllNotiUser();
    }
  }
  Future<void> getAllNotiUser() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.accountRepository.getAllNotiUser(
          userIds: listIdUser.map((number) => number.toString()).join(","));
      listNotiUser.value = res!.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}