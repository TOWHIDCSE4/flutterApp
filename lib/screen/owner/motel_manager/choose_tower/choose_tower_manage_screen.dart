import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/appbar/saha_appbar.dart';

import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../model/tower.dart';
import '../../../../utils/debounce.dart';
import 'choose_room_manage/choose_room_manage_screen.dart';
import 'choose_tower_manage_controller.dart';



class ChooseTowerManagerScreen extends StatelessWidget {
  ChooseTowerManagerScreen({
    super.key,
    required this.onChooose,
   required this.listTower,required this.isAdd,this.supportId
  }) {
    controller = ChooseTowerManageController();
  }

  late ChooseTowerManageController controller;
  RefreshController refreshController = RefreshController();
  Function onChooose;
  List<Tower> listTower;
  bool isAdd;
  int? supportId;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
       titleChild: Obx(
          () => controller.isSearch.value == true
              ? Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      
                      controller: controller.searchEdit,
                      autofocus:
                          controller.isSearch.value ? true : false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                            right: 15, top: 20, bottom: 5),
                        border: InputBorder.none,
                        hintText: "Tìm kiếm",
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.searchEdit.clear();
                            controller.listTower([]);
                            controller.textSearch = null;
                           controller.getAllTower(isRefresh: true);
                            FocusScope.of(context).unfocus();

                            controller.isSearch.value = false;
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 15,
                          ),
                        ),
                      ),
                      onChanged: (v) {
                        EasyDebounce.debounce('debounce_timer_chatlist_search',
                            const Duration(milliseconds: 500), () {
                          controller.textSearch = v;
                          controller.getAllTower(isRefresh: true);

                          // if (v == '') {
                          //   chatListController.listBoxChatSearch([]);
                          // } else {
                          //   chatListController.textSearch = v;
                          //   chatListController.getAllBoxChat(isRefresh: true);
                          // }
                        });
                      },
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                )
              : const Text('Phân quyền quản lý'),
        ),
            actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (controller.isSearch.value == false) {
                  controller.isSearch.value = true;
                } else {
                  controller.isSearch.value = false;
                }
              }),
        ],
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
    );
  }

  Widget itemTower(Tower tower) {
    return tower.isSupportManageTower == true ? const SizedBox(): InkWell(
      onTap: () {
        Get.to(()=>ChooseRoomManageScreen(
          supportId: supportId,
          isAdd: isAdd,
          tower: tower,
          towerId: tower.id!,
          
          onChoose: onChooose,
          listMotelInput: listTower.indexWhere((e) => e.id == tower.id) == -1 ? [] : listTower.firstWhere((e) =>  e.id == tower.id).listMotelRoom ?? [],
        ));
      },
      child: Container(
         width: Get.width,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tower.towerName ?? "Chưa có thông tin",
                    style: TextStyle(
                        color: Theme.of(Get.context!).primaryColor,
                        fontSize: 18),
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
    );
  }
}
