import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/cart.dart';
import 'package:gohomy/model/cart_item.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/utils/debounce.dart';

class CartController extends GetxController {
  var listCartItem = RxList<CartItem>();
  var listQuantity = RxList<int>();
  var cart = Cart().obs;
  var loading = false.obs;
  

  DataAppController dataAppController = Get.find();

  CartController() {
   
       getCartInfo();
    
   
  }

  Future<void> getCartInfo() async {
    loading.value = true;
    try {
      List<int> list = [];
      var data = await RepositoryManager.serviceSellRepository.getCartInfo();
      cart(data!.data);
      listCartItem(data.data!.cartItems!);
      for (var e in listCartItem) {
        list.add(e.quantity ?? 1);
      }
      listQuantity(list);
      dataAppController.getBadge();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<void> updateItemToCart({required CartItem cartItem}) async {
    EasyDebounce.debounce('cart', const Duration(milliseconds: 300), () async {
      List<int> list = [];
      try {
        var data = await RepositoryManager.serviceSellRepository
            .updateItemToCart(cartItem: cartItem);
        cart(data!.data);
        listCartItem(data.data!.cartItems!);

        for (var e in listCartItem) {
          list.add(e.quantity ?? 1);
        }
        listQuantity(list);
        dataAppController.getBadge();
      } catch (err) {
        SahaAlert.showToastMiddle(message: err.toString());
      }
    });
  }
}
