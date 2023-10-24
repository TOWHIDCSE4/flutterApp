import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/admin_discover.dart';
import 'package:gohomy/screen/admin/ui_mangage/discover_manage/add_discover/add_discover_screen.dart';
import 'package:gohomy/screen/admin/ui_mangage/discover_manage/discover_item/discover_details_screen.dart';
import 'package:gohomy/screen/admin/ui_mangage/discover_manage/update_admin_discover/udpate_admin_discover_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/dialog/dialog.dart';
import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../const/color.dart';
import 'discover_manage_controller.dart';

class DiscoverManageScreen extends StatefulWidget {
  const DiscoverManageScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverManageScreen> createState() => _DiscoverManageScreenState();
}

class _DiscoverManageScreenState extends State<DiscoverManageScreen> {
  DiscoverManageController discoverManageController =
      DiscoverManageController();
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý khám phá'),
      ),
      body: Obx(() => discoverManageController.loadInit.value
          ? SahaLoadingFullScreen()
          : SmartRefresher(
              controller: refreshController,
              header: const MaterialClassicHeader(),
              onRefresh: () async {
                await discoverManageController.getAllAdminDiscover(
                    isRefresh: true);
                refreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...discoverManageController.listAdminDiscover
                        .map((e) => adminItem(e))
                  ],
                ),
              ),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddDiscoverScreen())!.then((value) =>
              discoverManageController.getAllAdminDiscover(isRefresh: true));
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget adminItem(AdminDiscover adminDiscover) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Get.to(() => DiscoverItemScreen(
                  id: adminDiscover.id!,
                  adminDiscover: adminDiscover,
                ))!
            .then((value) =>
                discoverManageController.getAllAdminDiscover(isRefresh: true));
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
          child: Column(
            children: [
              Text(
                adminDiscover.provinceName!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        height: 150,
                        width: size.width / 2,
                        fit: BoxFit.cover,
                        imageUrl: adminDiscover.image ?? '',
                       // placeholder: (context, url) => SahaLoadingWidget(),
                        errorWidget: (context, url, error) => const SahaEmptyImage(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => UpdateAdminDiscoverScreen(
                                adminDiscover: adminDiscover))!
                            .then((value) => discoverManageController
                                .getAllAdminDiscover(isRefresh: true));
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.green),
                        child: const Center(
                            child: Text(
                          'Cập nhật',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogYesNo(
                            mess: "Bạn có chắc muốn xoá khám phá này",
                            onClose: () {},
                            onOK: () async {
                              await discoverManageController.deleteDiscover(
                                  id: adminDiscover.id!);

                              discoverManageController.getAllAdminDiscover(
                                  isRefresh: true);
                              // discoverManageController.listAdminDiscover
                              //     .refresh();
                            });
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.red),
                        child: const Center(
                            child: Text(
                          'Xoá',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
