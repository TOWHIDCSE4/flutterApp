import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';

import '../../../../components/empty/saha_empty_image.dart';
import '../../../../model/tower.dart';
import '../add_motel_manager/add_motel_manager_screen.dart';
import 'motel_manage_/motel_manage_screen.dart';
import 'tower_manager_detail_controller.dart';


class TowerManagerDetailScreen extends StatelessWidget {
   TowerManagerDetailScreen({super.key,required this.supportId}){
    controller = TowerManagerDetailController(supportId: supportId);
   }
  final int supportId;
  late TowerManagerDetailController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Toà nhà quản lý",
          actions: [
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Get.to(()=>AddMotelManagerScreen(supportId: supportId,))!.then((value) => controller.getSupportManageTower());
              }),
        ],
      ),
      body: Obx(
        ()=>controller.loadInit.value ? SahaLoadingFullScreen(): SingleChildScrollView(
          child: Column(
            children: [
              ...(controller.supportManageTower.value.towers ?? []).map((e) => itemTower(e))
            ],
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
            Get.to(()=>MotelManageScreen(
              supportId: supportId,
              tower: tower,
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
                      SizedBox(
                        width: Get.width/2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Tổng số phòng"),
                                  Text("${tower.totalMotel ?? 0}",style: TextStyle(color: Theme.of(Get.context!).primaryColor),)
                                ],
                              ),
                                Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Tổng số phòng trống"),
                                  Text("${tower.totalEmptyMotel ?? 0}",style: TextStyle(color: Theme.of(Get.context!).primaryColor,fontWeight: FontWeight.w700),)
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: IconButton(onPressed: (){
          SahaDialogApp.showDialogYesNo(
            mess: "Bạn có muốn xoá toà này khỏi quản lý của người này không",
            onOK: (){
              controller.deleteTowerSupportManage(towerId: tower.id!);
            }
          );
        }, icon:  Icon(Icons.delete_outline,color: Theme.of(Get.context!).primaryColor,)))
      ],
    );
  }
}