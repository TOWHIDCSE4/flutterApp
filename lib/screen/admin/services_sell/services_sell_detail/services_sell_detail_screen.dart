import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/screen/admin/services_sell/services_sell_detail/services_sell_detail_controller.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../model/category.dart';
import '../../../../model/service_sell.dart';
import 'add_product/add_product_screen.dart';
import 'detail_product/product_detail_screen.dart';

class ServicesSellDetailScreen extends StatelessWidget {
  ServicesSellDetailScreen({super.key, required this.category}) {
    controller = ServicesSellDetailController(categoryId: category.id);
  }

  Category category;
  late ServicesSellDetailController controller;
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: category.name ?? 'Dịch vụ',
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
                await controller.getAllServiceSell(isRefresh: true);
                refreshController.refreshCompleted();
              },
              onLoading: () async {
                await controller.getAllServiceSell();
                refreshController.loadComplete();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        ...controller.listServiceSell.map((e) => itemService(e))
                      ],
                    )
                  ],
                ),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.loadInit.value == true) {
            return;
          }
          Get.to(() => AddProductScreen(
                    categoryId: category.id!,
                  ))!
              .then((value) => controller.getAllServiceSell(isRefresh: true));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemService(ServiceSell serviceSell) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailScreen(
                  productId: serviceSell.id!,
                ))!
            .then((value) => controller.getAllServiceSell(isRefresh: true));
      },
      child: Container(
        width: Get.width / 2 - 28,
        constraints: const BoxConstraints(
          minHeight: 260,
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  height: 150,
                  width: 150,
                  fit: BoxFit.fill,
                  imageUrl: (serviceSell.images ?? []).isEmpty
                      ? ""
                      : serviceSell.images![0],
                  errorWidget: (context, url, error) => const SahaEmptyImage(),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  serviceSell.name ?? '',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                )
                // const SizedBox(
                //   height: 30,
                // )
              ],
            ),
            Positioned(
              bottom: 0,
              child: Text(
                '${SahaStringUtils().convertToUnit(serviceSell.price ?? 0)} VNĐ',
                style:
                TextStyle(color: Theme.of(Get.context!).primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
