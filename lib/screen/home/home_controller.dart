import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/home_app.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/utils/user_info.dart';

import '../../components/arlert/saha_alert.dart';
import '../../data/repository/repository_manager.dart';
import '../../model/admin_discover.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var loadInit = true.obs;
  var homeApp = HomeApp().obs;
  var adminDiscover = AdminDiscover().obs;
  var show = false.obs;
  var listNoRemoveCache = [];
  DataAppController dataAppController = Get.find();
  HomeController() {
   // getAllHomeApp();
  }

  ScrollController scrollController = ScrollController();

  void scrollTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
    getAllHomeApp();
  }

  Future<void> getAllHomeApp() async {
    try {
      isLoading.value = true;

      adminDiscover.value.province = UserInfo().getDiscoverDistrictId();

      var data = await RepositoryManager.homeAppRepository
          .getHomeApp(adminDiscover.value.province ?? 1);

      homeApp(data!.data!);
      listNoRemoveCache = (homeApp.value.listCategoryServiceSell ?? [])
          .map((e) => e.image ?? '')
          .toList();

      if ((homeApp.value.adminDiscover ?? []).isNotEmpty) {
        if (UserInfo().getDiscoverDistrictId() != null) {
          var index = homeApp.value.adminDiscover!.indexWhere(
              (e) => e.province == UserInfo().getDiscoverDistrictId());
          if (index != -1) {
            adminDiscover(homeApp.value.adminDiscover![index]);
          } else {
            UserInfo().clearDiscoverId();
          }
          isLoading.value = false;
          loadInit.value = false;
          return;
        } else {
          adminDiscover(homeApp.value.adminDiscover![0]);
        }
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
    loadInit.value = false;
  }
}
