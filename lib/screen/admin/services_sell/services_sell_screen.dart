import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/screen/admin/services_sell/services_sell_controller.dart';
import 'package:gohomy/screen/admin/services_sell/services_sell_detail/services_sell_detail_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/loading/loading_full_screen.dart';
import '../../../model/category.dart';
import 'add_services_sell/add_services_sell_screen.dart';

class ServicesSellScreen extends StatelessWidget {
  ServicesSellScreen({super.key});
  ServicesSellController controller = ServicesSellController();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Dịch vụ bán",
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
                await controller.getAllAdminCategory(isRefresh: true);
                refreshController.refreshCompleted();
              },
              onLoading: () async {
                await controller.getAllAdminCategory();
                refreshController.loadComplete();
              },
              child: ListView.builder(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  itemCount: controller.listCategory.length,
                  itemBuilder: (BuildContext context, int index) {
                    return categoryItem(controller.listCategory[index]);
                  }),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddServicesSellScreen())!
              .then((value) => controller.getAllAdminCategory(isRefresh: true));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget categoryItem(Category category) {
    return InkWell(
      onTap: () {
        Get.to(() => ServicesSellDetailScreen(category: category));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  imageUrl: category.image ?? '',
                  errorWidget: (context, url, error) => const SahaEmptyImage(),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  category.name ?? '',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => AddServicesSellScreen(
                            categoryId: category.id,
                          ))!.then((value) => controller.getAllAdminCategory(isRefresh: true));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(children: const [
                        Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Sửa',
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      controller.deleteAdminCategory(idCategory: category.id!);
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(children: const [
                        Icon(
                          FontAwesomeIcons.trashCan,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Xoá',
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
