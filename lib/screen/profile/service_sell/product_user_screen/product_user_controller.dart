import 'package:get/get.dart';
import 'package:gohomy/model/cart_item.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/profile/service_sell/cart/cart_screen.dart';
import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/service_sell.dart';

class ProductUserController extends GetxController {
  var listServiceSell = RxList<ServiceSell>().obs;
  int? categoryId;
  int currentPage = 1;
  bool isEnd = false;

  var isLoading = false.obs;
  var loadInit = true.obs;

  DataAppController dataAppController = Get.find();

  ProductUserController({this.categoryId}) {
    getAllServiceSell(isRefresh: true);
  }
  Future<void> getAllServiceSell({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        //loadInit.value = true;
        isLoading.value = true;
        var data = await RepositoryManager.serviceSellRepository
            .getAllServiceSellUser(page: currentPage,idCategory: categoryId);

        if (isRefresh == true) {
          listServiceSell.value(data!.data!.data!);
          listServiceSell.refresh();
        } else {
          listServiceSell.value.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addItemToCart(
      {required CartItem cartItem, bool? isBuyNow}) async {
    try {
      var data = await RepositoryManager.serviceSellRepository
          .addItemToCart(cartItem: cartItem);
      dataAppController.getBadge();
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
