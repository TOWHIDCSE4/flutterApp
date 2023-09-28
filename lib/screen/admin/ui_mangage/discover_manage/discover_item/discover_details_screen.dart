import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/admin_discover.dart';
import 'package:gohomy/screen/admin/ui_mangage/discover_manage/discover_item/add_discover_item/add_discover_item_screen.dart';
import 'package:gohomy/screen/admin/ui_mangage/discover_manage/discover_item/discover_details_controller.dart';
import 'package:gohomy/screen/admin/ui_mangage/discover_manage/discover_item/update_discover_item/update_discover_item_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../components/dialog/dialog.dart';
import '../../../../../components/empty/saha_empty_image.dart';
import '../../../../../components/loading/loading_widget.dart';
import '../../../../../model/admin_discover_item.dart';

class DiscoverItemScreen extends StatefulWidget {
  DiscoverItemScreen({Key? key, required this.id, this.adminDiscover})
      : super(key: key);
  AdminDiscover? adminDiscover;
  int id;
  @override
  State<DiscoverItemScreen> createState() => _DiscoverItemScreenState();
}

class _DiscoverItemScreenState extends State<DiscoverItemScreen> {
  DiscoverItemController discoverItemController = DiscoverItemController();
  RefreshController refreshController = RefreshController();

  get primaryColor => null;
  @override
  void initState() {
    super.initState();
    discoverItemController.id = widget.id;
    discoverItemController.getAllAdminDiscoverItem(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.adminDiscover!.provinceName ?? ''),
        actions: [
          GestureDetector(
            onTap: () {
              SahaDialogApp.showDialogYesNo(
                  mess: "Bạn có chắc muốn xoá khám phá này",
                  onClose: () {},
                  onOK: () {
                    discoverItemController.deleteDiscover(id: widget.id);
                  });
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              child: const Icon(
                FontAwesomeIcons.trashCan,
              ),
            ),
          )
        ],
      ),
      body: Obx(
        () => discoverItemController.loadInit.value
            ? SahaLoadingFullScreen()
            : discoverItemController.listAdminDiscoverItem.isEmpty
                ? const Center(
                    child: Text('Chưa có quận/huyện nào'),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: SmartRefresher(
                          controller: refreshController,
                          header: const MaterialClassicHeader(),
                          onRefresh: () async {
                            await discoverItemController
                                .getAllAdminDiscoverItem(isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ...discoverItemController.listAdminDiscoverItem
                                    .map((element) => discoverItem(element))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddDiscoverItemScreen(
                    adminDiscover: widget.adminDiscover,
                  ))!
              .then((value) => discoverItemController.getAllAdminDiscoverItem(
                  isRefresh: true));
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget discoverItem(AdminDiscoverItem adminDiscoverItem) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Get.to(() => UpdateDiscoverItemScreen(
                  id: adminDiscoverItem.id,
                ))!
            .then((value) => discoverItemController.getAllAdminDiscoverItem(
                isRefresh: true));
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
                adminDiscoverItem.districtName ?? '',
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
                        imageUrl: adminDiscoverItem.image ?? '',
                       // placeholder: (context, url) => SahaLoadingWidget(),
                        errorWidget: (context, url, error) => const SahaEmptyImage(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
