import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/empty/saha_empty_avatar.dart';
import 'package:gohomy/model/support_manage_tower.dart';
import 'package:gohomy/model/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/loading/loading_full_screen.dart';
import '../../../utils/call.dart';
import '../../../utils/debounce.dart';
import '../../chat/chat_detail/chat_detail_screen.dart';
import '../post_management/list_post_management_controller.dart';
import 'add_motel_manager/add_motel_manager_screen.dart';
import 'tower_manager_controller.dart';
import 'tower_manager_detail/tower_manager_detail_screen.dart';

class TowerManagerScreen extends StatefulWidget {
  TowerManagerScreen({Key? key}) : super(key: key);

  @override
  State<TowerManagerScreen> createState() =>
      _TowerManagerScreenState();
}

class _TowerManagerScreenState extends State<TowerManagerScreen>
    with SingleTickerProviderStateMixin {
  TowerManagerController controller =
      TowerManagerController();
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // begin: Alignment.bottomLeft,
                  // end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
          title: Obx(
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
                      onFieldSubmitted: (value) {
                     
                      },
                      //controller: chatListController.searchEdit,
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
                            // chatListController.searchEdit.clear();
                            // chatListController.listBoxChatSearch([]);
                            // chatListController.textSearch = '';
                            // chatListController.getChatAdminHelper();
                            // FocusScope.of(context).unfocus();

                            // chatListController.isSearch.value = false;
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 15,
                          ),
                        ),
                      ),
                      onChanged: (v) {
                        // EasyDebounce.debounce('debounce_timer_chatlist_search',
                        //     const Duration(milliseconds: 500), () {
                        //   chatListController.textSearch = v;
                        //   chatListController.getChatAdminHelper();

                        //   // if (v == '') {
                        //   //   chatListController.listBoxChatSearch([]);
                        //   // } else {
                        //   //   chatListController.textSearch = v;
                        //   //   chatListController.getAllBoxChat(isRefresh: true);
                        //   // }
                        // });
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
        floatingActionButton: FloatingActionButton(
          heroTag: 'post_navi',
          onPressed: () {
            Get.to(()=>AddMotelManagerScreen())!.then((value) => controller.getAllSupportManageTower(isRefresh: true));
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
        ),
        body: Obx(
          () => controller.loadInit.value
              ? SahaLoadingFullScreen()
              : controller.listSupportManager.isEmpty
                  ? const Center(
                      child: Text('Không có quản lý nào'),
                    )
                  : SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const MaterialClassicHeader(),
                      footer: CustomFooter(
                        builder: (
                          BuildContext context,
                          LoadStatus? mode,
                        ) {
                          Widget body = Container();
                          if (mode == LoadStatus.idle) {
                            body = Obx(() =>
                                controller.isLoading.value
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
                      onRefresh: () async {
                        await controller.getAllSupportManageTower(
                            isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await controller.getAllSupportManageTower();
                        refreshController.loadComplete();
                      },
                      child: ListView.builder(
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          itemCount: controller.listSupportManager.length,
                          itemBuilder: (BuildContext context, int index) {
                            return manager(controller.listSupportManager[index]);
                          }),
                    ),
        ),
      ),
    );
  }

  Widget manager(SupportManageTower supportManageTower) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Get.to(()=>TowerManagerDetailScreen(supportId: supportManageTower.id!,))!.then((value) => controller.getAllSupportManageTower(isRefresh: true));
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
            padding: const EdgeInsets.all(10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipOval(
                child: Image.network(
                  '',
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                  errorBuilder: (context, error, stackTrace) {
                    return const SahaEmptyAvata(
                      height: 40,
                      width: 40,
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      supportManageTower.name ?? '',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                     supportManageTower.phoneNumber ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                    item(title: "Số toà nhà đang quản lý", subTitle: "${supportManageTower.totalTowerManage ?? ''}"),
                    item(title: "Số phòng đang quản lý", subTitle: "${supportManageTower.totalMotelManage ?? ''}"),
                    item(title: "Số phòng đang trống", subTitle: "${supportManageTower.totalEmptyMotel ?? ''}"),
                    item(title: "Số hợp đồng đang quản lý", subTitle: "${supportManageTower.totalContract ?? ''}"),
                    

                   
                  ],
                ),
              )
            ]),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.call,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Call.call(supportManageTower.phoneNumber??'');
                },
              ),
              IconButton(
                icon: Icon(Icons.chat, color: Theme.of(context).primaryColor),
                onPressed: () {
                  Get.to(() => ChatDetailScreen(
                        toUser: supportManageTower.user ?? User()
                      ));
                },
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget item({required String title,required String subTitle}){
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(fontSize: 16),),
          Text(subTitle,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 16),)
        ],
      ),
    );
  }
}
