import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/divide/divide.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/tower.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../components/text_field/text_field_no_border.dart';
import '../../../../model/motel_room.dart';
import '../choose_tower/choose_tower_manage_screen.dart';
import 'add_motel_manager_controller.dart';

class AddMotelManagerScreen extends StatelessWidget {
  AddMotelManagerScreen({super.key,this.supportId}) {
    controller = AddMotelManagerController(supportId: supportId);
  }
  late AddMotelManagerController controller;
  final int? supportId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: SahaAppBar(
          titleText:supportId == null ? "Thêm quản lý" : "Cập nhật quản lý",
          actions: [
            if(supportId !=null)
            IconButton(onPressed: (){
              SahaDialogApp.showDialogYesNo(
                mess: "Bạn có chắc chắn muốn xoá",
                onOK: (){
                  controller.deleteSupportManageTower();
                }
              );
            }, icon: const Icon(Icons.delete))
          ],
        ),
        body: Obx(
          () => controller.loadInit.value
              ? SahaLoadingFullScreen()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SahaTextFieldNoBorder(
                        withAsterisk: true,
                        textInputType: TextInputType.text,
                        controller: controller.nameManager,
                        onChanged: (v) {
                          controller.supportManageTowerReq.value.name = v!;
                        },
                      
                        labelText: "Họ và tên quản lý",
                        hintText: "Nhập họ và tên",
                      ),
                      SahaTextFieldNoBorder(
                        withAsterisk: true,
                        textInputType: TextInputType.phone,
                        controller: controller.phoneNumber,
                        onChanged: (v) {
                          controller.supportManageTowerReq.value.phoneNumber = v!;
                        },
                       
                        labelText: "Số điện thoại",
                        hintText: "Nhập số điện thoại",
                      ),
                      SahaTextFieldNoBorder(
                       
                        textInputType: TextInputType.text,
                        controller: controller.email,
                        onChanged: (v) {
                          controller.supportManageTowerReq.value.email = v!;
                        },
                        labelText: "Email",
                        hintText: "Nhập email",
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Toà nhà quản lý",
                                style: const TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12)),
                            if (controller.supportManageTowerReq.value.towers!.isEmpty)
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => ChooseTowerManagerScreen(
                                         supportId: supportId,
                                            listTower: controller.supportManageTowerReq.value.towers ??[],
                                            isAdd: supportId == null ? true : false,
                                            onChooose: (int towerId,String towerName,

                                                List<MotelRoom> listMotelRoom) {
                                             var index = controller.supportManageTowerReq.value.towers!.indexWhere(
                                                    (e) => e.id == towerId);
                                            if (index ==
                                                -1) {
                                              if (listMotelRoom.isNotEmpty) {
                                               
                                                controller.supportManageTowerReq.value.towers!.add(Tower(
                                                    id: towerId,
                                                    towerName: towerName,
                                                    listMotelRoom:
                                                        listMotelRoom));
                                                controller.supportManageTowerReq.refresh();
                                                  
                                              }
                                            
                                            } else {
                                              if (listMotelRoom.isNotEmpty) {

                                               
                                                controller.supportManageTowerReq.value.towers![index].listMotelRoom = listMotelRoom;
                                           
                                                controller.supportManageTowerReq.refresh();
                                              } 
                                              else {
                                               controller.supportManageTowerReq.value.towers!.removeWhere(
                                                    (e) => e.id == towerId);
                                              
                                                 controller.supportManageTowerReq.refresh();

                                               
                                              }
                                            }
                                            },
                                          ));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Lựa chọn toà nhà quản lý",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Icon(Icons.keyboard_arrow_right),
                                      ],
                                    ),
                                  ),
                                  const Divider()
                                ],
                              ),
                            if (controller.supportManageTowerReq.value.towers!.isNotEmpty)
                              Obx(
                                () => Column(
                                  children: [
                                    ...(controller.supportManageTowerReq.value.towers ?? [])
                                        .map((e) => motelManage(e))
                                  ],
                                ),
                              ),
                            const SizedBox(
                              height: 8,
                            ),
                            if (controller.supportManageTowerReq.value.towers!.isNotEmpty)
                              InkWell(
                                  onTap: () {
                                    Get.to(() => ChooseTowerManagerScreen(
                                      supportId: supportId,
                                      isAdd: supportId == null ? true : false,
                                          listTower: controller.supportManageTowerReq.value.towers ??[],
                                          onChooose: (int towerId,String towerName,
                                              List<MotelRoom> listMotelRoom) {
                                                var index = controller.supportManageTowerReq.value.towers!.indexWhere(
                                                    (e) => e.id == towerId);
                                            if (index ==
                                                -1) {
                                              if (listMotelRoom.isNotEmpty) {
                                               
                                                controller.supportManageTowerReq.value.towers!.add(Tower(
                                                    id: towerId,
                                                    towerName: towerName,
                                                    listMotelRoom:
                                                        listMotelRoom));
                                                controller.supportManageTowerReq.refresh();
                                                  
                                              }
                                            
                                            } else {
                                              if (listMotelRoom.isNotEmpty) {

                                               
                                                controller.supportManageTowerReq.value.towers![index].listMotelRoom = listMotelRoom;
                                           
                                                controller.supportManageTowerReq.refresh();
                                              } 
                                              else {
                                               controller.supportManageTowerReq.value.towers!.removeWhere(
                                                    (e) => e.id == towerId);
                                              
                                                 controller.supportManageTowerReq.refresh();

                                               
                                              }
                                            }
                                          },
                                        ));
                                  },
                                  child: Text(
                                    "+ Thêm ...",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                                Text("Quản lý được thêm sẽ có quyền sử dụng các tính năng quản lý của chủ nhà đối với các phòng được phân công như gán phòng khi thêm người thuê, tạo hợp đồng, tạo hoá đơn, tiếp nhận và xử lý các sự cố, chỉnh sửa thông tin phòng/toà nhà",textAlign: TextAlign.center,style: TextStyle(color: Theme.of(context).primaryColor))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        bottomNavigationBar:  SizedBox(
                    height: 65,
                    child: Column(
                      children: [
                        SahaButtonFullParent(
                          color: 
                             Theme.of(context).primaryColor
                              ,
                          text:supportId == null ? 'Thêm quản lý' : "Cập nhật",
                          onPressed: () {
                            if(supportId == null){
                              controller.addSupportManageTower();
                            }else{
                              controller.updateSupportManageTower();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget motelManage(Tower tower) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tower.towerName ?? "",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: Theme.of(Get.context!).primaryColor),
        ),
        //if((tower.listMotelRoom ?? []).length > 6)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height:(tower.listMotelRoom ?? []).length > 6 ? 180 : null,
              child: SingleChildScrollView(
              physics:(tower.listMotelRoom ?? []).length > 6 ? null :const  NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...(tower.listMotelRoom ?? []).map((e) => SizedBox(height:30,child: Text("   ${e.motelName ?? ''}")))
                  ],
                ),
              ),
            ),
             SahaDivide()
          ],
           
        ),
  
      
      ],
    );
  }
}
