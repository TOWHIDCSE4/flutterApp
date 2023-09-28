import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/button/saha_button.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/components/widget/cart/item_service_sell.dart';
import 'package:gohomy/model/cart_item.dart';

import '../../../../model/service_sell.dart';
import '../confirm/confirm_screen.dart';
import 'cart_controller.dart';

class CartScreen extends StatelessWidget {
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: const Text('Giỏ hàng'),
      ),
      body: Obx(
        () => cartController.loading.value
            ? SahaLoadingFullScreen()
            : cartController.listCartItem.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.remove_shopping_cart,
                          color: Colors.grey,
                          size: 50,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Giỏ hàng trống',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: cartController.listCartItem.length,
                      itemBuilder: (context, index) =>
                          ItemServiceSellInCartWidget(
                        cartItem: cartController.listCartItem[index],
                        onDismissed: () {
                          cartController.updateItemToCart(
                              cartItem: CartItem(
                                  id: cartController.listCartItem[index].id!,
                                  quantity: 0));
                        },
                        onRemoveItem: () {
                          cartController.updateItemToCart(
                              cartItem: CartItem(
                                  id: cartController.listCartItem[index].id!,
                                  quantity: 0));
                          cartController.listCartItem.removeAt(index);
                        },
                        onDecreaseItem: () {
                          cartController.listQuantity[index] =
                              cartController.listQuantity[index] - 1;
                          cartController.listCartItem.refresh();
                          cartController.updateItemToCart(
                              cartItem: CartItem(
                                  id: cartController.listCartItem[index].id!,
                                  quantity:
                                      cartController.listQuantity[index]));
                          if (cartController.listQuantity[index] == 0) {
                            cartController.listCartItem.removeAt(index);
                          }
                        },
                        onIncreaseItem: () {
                          cartController.listQuantity[index] =
                              cartController.listQuantity[index] + 1;
                          cartController.listCartItem.refresh();
                          cartController.updateItemToCart(
                              cartItem: CartItem(
                                  id: cartController.listCartItem[index].id!,
                                  quantity:
                                      cartController.listQuantity[index]));
                        },
                        onUpdateServiceSell:
                            (quantity, ServiceSell serviceSell) {},
                        quantity: cartController.listQuantity[index],
                      ),
                    ),
                  ),
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              color: Theme.of(context).primaryColor,
              text: 'Đặt hàng',
              onPressed: () {
                if (cartController.listCartItem.isEmpty) {
                  SahaAlert.showError(
                      message: "Bạn chưa có sản phẩm nào trong giỏ hàng");
                      return;
                }
                Get.to(() => ConfirmScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
