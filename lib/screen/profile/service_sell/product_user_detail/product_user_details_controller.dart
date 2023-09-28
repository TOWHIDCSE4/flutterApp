import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/service_sell.dart';
import 'package:gohomy/screen/data_app_controller.dart';

import '../../../../model/cart_item.dart';
import '../cart/cart_screen.dart';

class ProductUserDetailController extends GetxController {
  var serviceSell = ServiceSell().obs;
  var loadInit = true.obs;

  Future<void> getServiceSellUser({required int id}) async {
    try {
      var res = await RepositoryManager.serviceSellRepository
          .getServiceSellUser(id: id);
      serviceSell.value = res!.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
    Future<void> addItemToCart(
      {required CartItem cartItem, bool? isBuyNow}) async {
    try {
      var data = await RepositoryManager.serviceSellRepository
          .addItemToCart(cartItem: cartItem);
      Get.find<DataAppController>().getBadge();
      if (isBuyNow == true) {
        Get.to(() => CartScreen());
      } else {
        SahaAlert.showSuccess(message: 'Đã thêm vào giỏ hàng');
      }
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }
}
