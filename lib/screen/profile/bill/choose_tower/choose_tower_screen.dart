import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/empty/saha_empty_image.dart';
import 'package:gohomy/model/tower.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/profile/bill/choose_tower/choose_tower_controller.dart';
import 'package:gohomy/screen/profile/bill/choose_tower/choose_tower_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../model/user.dart';
import '../../../../utils/debounce.dart';

class TowerFilterScreen extends StatefulWidget {
  final bool? isShowTab;
  final Function onChoose;
  final int? idChoose;

  const TowerFilterScreen(
      {this.isShowTab = true, required this.onChoose, this.idChoose});

  @override
  State<TowerFilterScreen> createState() => _TowerFilterScreenState();
}

class _TowerFilterScreenState extends State<TowerFilterScreen>
    with SingleTickerProviderStateMixin {
  RefreshController refreshController = RefreshController();
  late TowerFilterController towerFilterController;

  @override
  void initState() {
    super.initState();
    towerFilterController = TowerFilterController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        title: const Text('Chọn tòa nhà'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Obx(
              () => towerFilterController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : SmartRefresher(
                      controller: refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () async {
                        await towerFilterController.getAllTowers(
                            isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await towerFilterController.getAllTowers();
                        refreshController.loadComplete();
                      },
                      footer: CustomFooter(
                        builder: (
                          BuildContext context,
                          LoadStatus? mode,
                        ) {
                          Widget body = Container();
                          if (mode == LoadStatus.idle) {
                            body = Obx(() =>
                                towerFilterController.isLoading.value
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...towerFilterController.listTower
                                .map((element) => towerItem(element))
                                .toList()
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget towerItem(Tower tower) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            widget.onChoose(tower);
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
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "${(tower.images ?? []).isNotEmpty ? tower.images![0] : ""}?reduce_file=true",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SahaEmptyImage(
                          height: 100,
                          width: 100,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tower.towerName ?? "Chưa có thông tin",
                        style: TextStyle(
                            color: Theme.of(Get.context!).primaryColor,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            child: Text(
                              "${tower.addressDetail} - ${tower.wardsName} - ${tower.districtName} - ${tower.provinceName}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                height: 1.2,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (tower.id == widget.idChoose)
          const Positioned(
              top: 20,
              right: 20,
              child: Icon(
                Icons.check,
                color: Colors.green,
              ))
      ],
    );
  }
}
