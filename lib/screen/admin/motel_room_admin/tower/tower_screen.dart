import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/empty/saha_empty_image.dart';
import 'package:gohomy/screen/admin/motel_room_admin/admin_motel_room_controller.dart';
import 'package:gohomy/screen/admin/users/user_filter/user_filter_screen.dart';
import 'package:gohomy/utils/debounce.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/loading/loading_full_screen.dart';
import '../../../../components/text_field/saha_text_field_search.dart';
import '../../../../model/tower.dart';
import '../../../owner/motel_room/list_motel_room_screen.dart';
import '../admin_motel_room_screen.dart';
import 'add_tower/add_tower_screen.dart';
import 'tower_controller.dart';

class TowerScreen extends StatefulWidget {
  TowerScreen({Key? key, this.isTower, this.isAdmin, this.isNext})
      : super(key: key) {
    controller = TowerController(isAdmin: isAdmin);
  }

  bool? isAdmin;
  bool? isNext;
  bool? isTower;
  late TowerController controller;

  @override
  State<TowerScreen> createState() => _TowerScreenState();
}

class _TowerScreenState extends State<TowerScreen> {
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    if (widget.isNext == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Get.to(() => AddTowerScreen())!
            .then((value) => widget.controller.getAllTower(isRefresh: true));
      });
    }

    super.initState();
  }

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
        title: Obx(() => Text(
              widget.controller.userChoose.value.id != null && widget.isAdmin == true
                  ? widget.controller.userChoose.value.name ?? ''
                  : "Tòa nhà",
            )),
        centerTitle: true,
        actions: [
          if (widget.isAdmin == true)
            IconButton(
                onPressed: () {
                  Get.to(() => UserFilterScreen(
                      isShowTab: false,
                      idChoose: widget.controller.userChoose.value.id,
                      onChoose: (user) {
                        widget.controller.userChoose.value = user;
                        widget.controller
                            .getAllTower(isRefresh: true, userId: user!.id);
                        Get.back();
                      }));
                },
                icon: Obx(() => Icon(
                    widget.controller.userChoose.value.id != null
                        ? Icons.filter_alt
                        : Icons.filter_alt_outlined,
                    color: widget.controller.userChoose.value.id != null
                        ? Colors.blue
                        : null))),
        ],
      ),
      body: Obx(
        () => widget.controller.loadInit.value
            ? SahaLoadingFullScreen()
            : widget.controller.listTower.isEmpty
                ? const Center(
                    child: Text('Không có toà nhà nào'),
                  )
                : SmartRefresher(
                    footer: CustomFooter(
                      builder: (
                        BuildContext context,
                        LoadStatus? mode,
                      ) {
                        Widget body = Container();
                        if (mode == LoadStatus.idle) {
                          body = Obx(() => widget.controller.isLoading.value
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
                    controller: refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const MaterialClassicHeader(),
                    onRefresh: () async {
                      await widget.controller.getAllTower(isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await widget.controller.getAllTower();
                      refreshController.loadComplete();
                    },
                    child: ListView.builder(
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemCount: widget.controller.listTower.length,
                        itemBuilder: (BuildContext context, int index) {
                          return itemTower(widget.controller.listTower[index]);
                        }),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Get.to(() => AddTowerScreen())!
              .then((value) => widget.controller.getAllTower(isRefresh: true));
        },
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget itemTower(Tower tower) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            if (widget.isAdmin == true) {
              Get.to(() => AdminMotelRoomScreen(
                    isSupportTower:
                        tower.isSupportManageTower == true ? true : null,
                    isTower: true,
                    tower: tower,
                    towerId: tower.id,
                    isFromTower: true,
                  ));
            } else {
              Get.to(() => ListMotelRoomScreen(
                    isSupportTower:
                        tower.isSupportManageTower == true ? true : null,
                    isTower: true,
                    towerId: tower.id,
                    tower: tower,
                  ));
            }
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
                  padding: const EdgeInsets.only(left: 10),
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.home_work_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Sơ đồ toà nhà",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => AddTowerScreen(
                                        towerId: tower.id,
                                      ))!
                                  .then((value) => widget.controller
                                      .getAllTower(isRefresh: true));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Chỉnh sửa",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (tower.isSupportManageTower != true)
          Positioned(
              top: 5,
              right: 5,
              child: Row(
                children: [
                  IconButton(
                    color: Theme.of(Get.context!).primaryColor,
                    onPressed: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: "Bạn chắc chắn muốn xoá không",
                          onOK: () {
                            widget.controller
                                .deleteTower(towerId: tower.id!)
                                .then((value) => widget.controller
                                    .getAllTower(isRefresh: true));
                          });
                    },
                    icon: Icon(
                      FontAwesomeIcons.trashCan,
                      color: Theme.of(Get.context!).primaryColor,
                    ),
                  ),
                ],
              ))
      ],
    );
  }
}
