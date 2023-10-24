import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';

import 'package:gohomy/screen/admin/ui_mangage/banner_manage/add_banner/add_banner_screen.dart';
import 'package:gohomy/screen/admin/ui_mangage/banner_manage/banner_manage_controller.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/ui_mangage/banner_manage/update_banner/update_banner_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_widget.dart';

import '../../../../model/banners.dart';

class BannerManageScreen extends StatefulWidget {
  const BannerManageScreen({Key? key}) : super(key: key);

  @override
  State<BannerManageScreen> createState() => _BannerManageScreenState();
}

class _BannerManageScreenState extends State<BannerManageScreen> {
  BannerManageController bannerManageController = BannerManageController();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // begin: Alignment.bottomLeft,
                  // end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
          title: const Text('Quản lý banner')),
      body: Obx(
        () => bannerManageController.loadInit.value
            ? SahaLoadingFullScreen()
            : SmartRefresher(
                controller: refreshController,
                //enablePullDown: true,
                //enablePullUp: true,
                header: const MaterialClassicHeader(),
                onRefresh: () async {
                  await bannerManageController.getAllBanner(isRefresh: true);
                  refreshController.refreshCompleted();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...bannerManageController.listBanner
                          .map((element) => bannerItem(element))
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddBannerScreen())!.then(
              (value) => bannerManageController.getAllBanner(isRefresh: true));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget bannerItem(Banners banner) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Get.to(() => UpdateBannerScreen(
                  id: banner.id!,
                ))!
            .then((value) =>
                bannerManageController.getAllBanner(isRefresh: true));
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
                banner.title!,
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
                        imageUrl: banner.imageUrl ?? '',
                        //placeholder: (context, url) => SahaLoadingWidget(),
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
