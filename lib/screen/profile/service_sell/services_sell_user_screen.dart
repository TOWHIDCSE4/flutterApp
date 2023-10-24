import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/screen/profile/service_sell/product_user_screen/product_user_screen.dart';
import 'package:gohomy/screen/profile/service_sell/services_sell_user_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/loading/loading_full_screen.dart';
import '../../../components/widget/check_customer_login/check_customer_login_screen.dart';
import '../../../model/category.dart';
import '../../data_app_controller.dart';
import 'cart/cart_screen.dart';
import 'orders/orders_screen.dart';

class ServicesSellUserLockScreen extends StatelessWidget {
  const ServicesSellUserLockScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(child: ServicesSellUserScreen());
  }
}

class ServicesSellUserScreen extends StatefulWidget {
  ServicesSellUserScreen({super.key});

  @override
  State<ServicesSellUserScreen> createState() => _ServicesSellUserScreenState();
}

class _ServicesSellUserScreenState extends State<ServicesSellUserScreen> {
  final ServicesSellUserController controller =
      Get.put(ServicesSellUserController());

  final RefreshController refreshController = RefreshController();

  final DataAppController dataAppController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dịch vụ bán"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
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
      body: Obx(() => controller.loadInit.value
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
                    body = Obx(() => controller.isLoading.value
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
                await controller.getAllCategory(isRefresh: true);
                refreshController.refreshCompleted();
              },
              onLoading: () async {
                await controller.getAllCategory();
                refreshController.loadComplete();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        ...controller.listCategory.map((e) => itemCategory(e))
                      ],
                    )
                  ],
                ),
              ))),
    );
  }

  Widget itemCategory(Category category) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductUserScreen(
              categoryId: category.id,
            ));
      },
      child: Container(
          width: Get.width / 2 - 24,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  imageUrl: category.image ?? '',
                  //placeholder: (context, url) => const SahaLoadingContainer(),
                  errorWidget: (context, url, error) => const SahaEmptyImage(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                category.name ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          )),
    );
  }
}
