import 'package:badges/badges.dart' as b;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/profile/service_sell/orders/orders_screen.dart';
import 'package:gohomy/screen/profile/service_sell/product_user_detail/product_user_detail_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../components/widget/bottom_sheet/modal_bottom_option_buy_product.dart';
import '../../../../components/widget/post_item/service_sell_item.dart';
import '../../../../model/cart_item.dart';
import '../../../../model/service_sell.dart';
import '../cart/cart_screen.dart';
import '../confirm_immediate/confirm_immediate_controller.dart';
import '../confirm_immediate/confirm_immediate_screen.dart';
import 'product_user_controller.dart';





class ProductUserScreen extends StatefulWidget {
  ProductUserScreen({Key? key, this.id,this.categoryId}) : super(key: key){
    serviceSellController = ProductUserController(categoryId: categoryId);
  }
  int? id;
  int? categoryId;
    late ProductUserController serviceSellController;
  @override
  State<ProductUserScreen> createState() => _ProductUserScreenState();
}

class _ProductUserScreenState extends State<ProductUserScreen> {

  RefreshController refreshController = RefreshController();
  DataAppController dataAppController = Get.find();

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Get.to(() => ProductUserDetailScreen(id: widget.id!));
      });
    }
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
        title: const Text('Dịch vụ bán'),
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
          IconButton(
              onPressed: () {
                Get.to(() => OrdersScreen());
              },
              icon: const Icon(Icons.reorder))
        ],
      ),
      body: Obx(() => widget.serviceSellController.loadInit.value
          ? SahaLoadingFullScreen()
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: const MaterialClassicHeader(),
              controller: refreshController,
              footer: CustomFooter(
                builder: (
                  BuildContext context,
                  LoadStatus? mode,
                ) {
                  Widget body = Container();
                  if (mode == LoadStatus.idle) {
                    body = Obx(() => widget.serviceSellController.isLoading.value
                        ? const CupertinoActivityIndicator()
                        : Container());
                  } else if (mode == LoadStatus.loading) {
                    body = const CupertinoActivityIndicator();
                  }
                  return SizedBox(
                    height: 100,
                    child: Center(child: body),
                  );
                },
              ),
              onRefresh: () async {
                await widget.serviceSellController.getAllServiceSell(isRefresh: true);
                refreshController.refreshCompleted();
              },
              onLoading: () async {
                await widget.serviceSellController.getAllServiceSell();
                refreshController.loadComplete();
              },
              child: Obx(
                () => SingleChildScrollView(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ...widget.serviceSellController.listServiceSell.value
                          .map((item) => ServiceSellItem(
                                serviceSell: item,
                                width: (Get.width - 10) / 2,
                                onBuyNow: () {
                                  ModalBottomOptionBuyProduct.showModelOption(
                                    serviceSell: item,
                                    textButton: 'Mua ngay',
                                    onSubmit: (int quantity,
                                        ServiceSell serviceSell) {
                                          Get.to(()=>ConfirmImmediateScreen(cartItem: CartItem(serviceSell: serviceSell,quantity: quantity)));
                                           
                                    
                                    },
                                  );
                                },
                                onAddToCart: () {
                                  widget.serviceSellController.addItemToCart(
                                      cartItem: CartItem(
                                          quantity: 1,
                                          serviceSellId: item.id!));
                                },
                              ))
                    ],
                  ),
                ),
              ),
            )),
    );
  }
}
