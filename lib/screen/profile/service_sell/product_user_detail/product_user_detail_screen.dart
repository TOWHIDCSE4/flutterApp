import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart' as b;
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/profile/service_sell/product_user_detail/product_user_details_controller.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/widget/bottom_sheet/modal_bottom_option_buy_product.dart';
import '../../../../components/widget/image/product_image.dart';
import '../../../../model/cart_item.dart';
import '../../../../model/service_sell.dart';
import '../../../../utils/string_utils.dart';
import '../../../admin/services_sell/add_services_sell/add_services_sell_screen.dart';
import '../../../data_app_controller.dart';
import '../cart/cart_screen.dart';
import '../confirm_immediate/confirm_immediate_screen.dart';
import '../product_user_screen/product_user_controller.dart';

class ProductUserDetailScreen extends StatefulWidget {
  ProductUserDetailScreen({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  State<ProductUserDetailScreen> createState() =>
      _ProductUserDetailScreenScreenState();
}

class _ProductUserDetailScreenScreenState
    extends State<ProductUserDetailScreen> {
  ProductUserDetailController controller = ProductUserDetailController();
  //ProductUserController serviceSellController = ProductUserController();
  DataAppController dataAppController = Get.find();
  @override
  void initState() {
    super.initState();
    controller.getServiceSellUser(id: widget.id);
  }

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
        title: const Text('Chi tiết sản phẩm'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CartScreen());
              },
              icon: Obx(
                () => b.Badge(
                    badgeColor: Colors.red,
                    showBadge: dataAppController.badge.value.totalCart == 0
                        ? false
                        : true,
                    badgeContent: Text(
                      '${dataAppController.badge.value.totalCart}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: const Icon(Icons.shopping_cart)),
              )),
      
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => controller.loadInit.value
              ? SahaLoadingFullScreen()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImage(
                          listImageUrl: controller.serviceSell.value.images),
                      const Divider(),
                      Text(
                        controller.serviceSell.value.name ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Text(
                        '${SahaStringUtils().convertToUnit(controller.serviceSell.value.price ?? 0)} VNĐ',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      // Text("Đã bán: ${controller.serviceSell.value.sold ?? 0}"),
                      Text("Đã bán: ${Random().nextInt(300) + 42}"),
                      Container(
                        height: 8,
                        color: Colors.grey[100],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                   ModalBottomOptionBuyProduct.showModelOption(
                                    serviceSell: controller.serviceSell.value,
                                    textButton: 'Mua ngay',
                                    onSubmit: (int quantity,
                                        ServiceSell serviceSell) {
                                          Get.to(()=>ConfirmImmediateScreen(cartItem: CartItem(serviceSell: serviceSell,quantity: quantity)));
                                           
                                    
                                    },
                                  );
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Mua ngay',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: () {
                                controller.addItemToCart(
                                    cartItem: CartItem(
                                        quantity: 1,
                                        serviceSellId:
                                            controller.serviceSell.value.id!));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.add_shopping_cart_rounded,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Thêm vào giỏ hàng',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 8,
                        color: Colors.grey[100],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Mô tả sản phẩm",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(controller.serviceSell.value.description ?? ''),
                      // Container(
                      //   height: 8,
                      //   color: Colors.grey[100],
                      // ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // Text(
                      //   "Đánh giá sản phẩm",
                      //   style: TextStyle(
                      //       color: Theme.of(context).primaryColor,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      // Row(
                      //   children: [
                      //     RatingBarIndicator(
                      //       itemSize: 20,
                      //       rating: 4.5,
                      //       direction: Axis.horizontal,
                      //       itemCount: 5,
                      //       itemPadding:
                      //           const EdgeInsets.symmetric(horizontal: 4.0),
                      //       itemBuilder: (context, _) => const Icon(
                      //         Icons.star,
                      //         color: Colors.amber,
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text(
                      //       "4.6/5",
                      //       style: TextStyle(
                      //           color: Theme.of(context).primaryColor),
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     const Text(
                      //       "(15 đánh giá)",
                      //       style: TextStyle(color: Colors.grey),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     comment(),
                      //   ],
                      // )
                    ],
                  ),
                ),
        ),
      ),
      // bottomNavigationBar: SizedBox(
      //   height: 65,
      //   child: Column(
      //     children: [
      //       SahaButtonFullParent(
      //         color: Theme.of(context).primaryColor,
      //         text: 'Mua sản phẩm này',
      //         onPressed: () {
      //           ModalBottomOptionBuyProduct.showModelOption(
      //             serviceSell: serviceSellDetailController.serviceSell.value,
      //             textButton: 'Mua ngay',
      //             onSubmit: (int quantity, ServiceSell serviceSell) {
      //               serviceSellController.addItemToCart(
      //                   isBuyNow: true,
      //                   cartItem: CartItem(
      //                       quantity: quantity,
      //                       serviceSellId: serviceSell.id!));
      //               Get.back();
      //             },
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget comment() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.network(
            '',
            fit: BoxFit.cover,
            width: 40,
            height: 40,
            errorBuilder: (context, error, stackTrace) {
              return const SahaEmptyAvata(
                height: 40,
                width: 40,
              );
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 235, 235),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phạm Huyền Trang",
                style: TextStyle(
                    color: Theme.of(Get.context!).primaryColor, fontSize: 16),
              ),
              RatingBarIndicator(
                itemSize: 20,
                rating: 4,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
              Text(
                  "Sản phẩm tốt ship nhanh ,dùng hết rồi quay lại đánh gia thật là tuyệt vời"),
            ],
          ),
        ))
      ],
    );
  }
}
