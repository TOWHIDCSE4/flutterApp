import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/empty/saha_empty_image.dart';
import 'package:gohomy/screen/admin/motel_room_admin/tower/add_tower/add_tower_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../model/tower.dart';
import '../list_motel_room_screen.dart';
import 'choose_tower_controller.dart';

class ChooseTowerScreen extends StatelessWidget {
  ChooseTowerScreen(
      {super.key, required this.onChoose, this.towerChoose, this.isFromPost}) {
    controller = ChooseTowerController(towerChoose: towerChoose);
  }

  late ChooseTowerController controller;
  RefreshController refreshController = RefreshController();
  Function onChoose;
  Tower? towerChoose;
  bool? isFromPost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Chọn toà nhà",
      ),
      body: Obx(
        () => controller.loadInit.value
            ? SahaLoadingFullScreen()
            : SmartRefresher(
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
                controller: refreshController,
                enablePullDown: true,
                enablePullUp: true,
                header: const MaterialClassicHeader(),
                onRefresh: () async {
                  await controller.getAllTower(isRefresh: true);
                  refreshController.refreshCompleted();
                },
                onLoading: () async {
                  await controller.getAllTower();
                  refreshController.loadComplete();
                },
                child: ListView.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemCount: controller.listTower.length,
                    itemBuilder: (BuildContext context, int index) {
                      return itemTower(controller.listTower[index]);
                    }),
              ),
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              color: Theme.of(context).primaryColor,
              text: 'Xác nhận',
              onPressed: () {
                if (isFromPost == true) {

                       var index = controller.listTower.indexWhere((e) => e.id == controller.towerSelected.value.id,);
                      if(index != -1){
                         controller.towerSelected.value = controller.listTower[index];
                      }
                   
                  onChoose(controller.towerSelected.value);
                  Get.back();
                  Get.back();
                } else {
                    var index = controller.listTower.indexWhere((e) => e.id == controller.towerSelected.value.id,);
                  if(index != -1){
                        controller.towerSelected.value = controller.listTower[index];
                      }
                    
                  onChoose(controller.towerSelected.value);
                  Get.back();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(()=>AddTowerScreen())!.then((value) => controller.getAllTower(isRefresh: true));
      },child: const Center(child: Icon(Icons.add),),),
    );
  }

  Widget itemTower(Tower tower) {
    return InkWell(
      onTap: (){
        Get.to(()=>ListMotelRoomScreen(
                    isTower: true,
                    towerId: tower.id,
                    tower: tower,
                  ))!.then((value) => controller.getAllTower(isRefresh: true));
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      ((tower.images ?? []).isNotEmpty ? tower.images![0] : "") +
                          "?reduce_file=true",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      // imageUrl:
                      //     (post.images ?? []).isNotEmpty ? post.images![0] : "",
                      //placeholder: (context, url) => const SahaLoadingContainer(),
                      errorBuilder: (context, url, error) => const SahaEmptyImage(
                        height: 120,
                        width: 130,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      tower.towerName ?? "Chưa có thông tin",
                      style: TextStyle(
                          color: Theme.of(Get.context!).primaryColor,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 5,
              child: Obx(
                () => Checkbox(
                    side: BorderSide(
                      color: Theme.of(Get.context!).primaryColor,
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    value: controller.towerSelected.value.id == tower.id,
                    onChanged: (v) {
                      if (v == true) {
                        controller.towerSelected.value = tower;
                        // controller.listTower.refresh();
                      } else {
                        controller.towerSelected.value = Tower();
                        // controller.listTower.refresh();
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    ); // Card(
    //   child: ListTile(
    //     leading: ClipOval(
    //       child: Image.network(
    //         (tower.images == null || tower.images!.isEmpty)
    //             ? ""
    //             : tower.images![0],
    //         fit: BoxFit.cover,
    //         height: 30,
    //         width: 30,
    //         errorBuilder: (context, error, stackTrace) {
    //           return const SahaEmptyImage(
    //             height: 30,
    //             width: 30,
    //           );
    //         },
    //       ),
    //     ),
    //     title: Text(tower.towerName ?? ''),
    //     trailing: Obx(
    //       () => Checkbox(
    //           value: controller.towerSelected.value.id == tower.id,
    //           onChanged: (v) {
    //             if (v == true) {
    //               controller.towerSelected.value = tower;
    //               // controller.listTower.refresh();
    //             } else {
    //               controller.towerSelected.value = Tower();
    //               // controller.listTower.refresh();
    //             }
    //           }),
    //     ),
    //   ),
    // );
  }
}
