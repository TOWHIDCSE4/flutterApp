import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/admin/find_fast_motel/find_fast_motel_detail/find_fast_motel_detail_controller.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../../../../components/dialog/dialog.dart';
import '../../../../utils/call.dart';
import '../../../chat/chat_list/chat_list_screen.dart';


class FindFastMotelDetailScreen extends StatelessWidget {
   FindFastMotelDetailScreen({super.key,required this.idFindFast}){
    controller = FindFastMotelDetailController(idFindFast: idFindFast);
   }
  final int idFindFast;
  late FindFastMotelDetailController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Tìm phòng nhanh",
      ),
      body: Obx(
        ()=>controller.loadInit.value ? SahaLoadingFullScreen(): SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                item(title:"Họ và tên", content: controller.findFastMotel.value.name ?? ''),
                item(title:"Số điện thoại", content: controller.findFastMotel.value.phoneNumber ?? ''),
                item(title:"Địa chỉ nơi cần tìm", content: "${controller.findFastMotel.value.wardsName ?? ''} ${controller.findFastMotel.value.districtName ?? ''} ${controller.findFastMotel.value.provinceName ?? ''}"),
                item(title:"Mức giá phòng cần tìm", content:controller.findFastMotel.value.price == null ?"Chưa có thông tin": SahaStringUtils().convertToUnit(controller.findFastMotel.value.price )),
                item(title:"Số lượng người ở", content:controller.findFastMotel.value.capacity == null ? "Chưa có thông tin" : controller.findFastMotel.value.capacity.toString()),
                Container(
                            width: Get.width,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/icon_host/tien-nghi.png',
                                  width: 120,
                                  fit: BoxFit.fill,
                                ),
                                Wrap(
                                  children: [
                                    if (controller
                                            .findFastMotel.value.hasWc ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/wc-khep-kin.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Khép kín",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasMezzanine ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/gac-xep.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Gác xép",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasBalcony ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/ban-cong.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Ban công",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasFingerprint ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/ra-vao-van-tay.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Ra vào vân tay",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasOwnOwner ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/khong-chung-chu.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Không chung chủ",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasPet ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/nuoi-pet.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Nuôi pet",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                           const Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            width: Get.width,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/icon_host/noi-that.png',
                                  width: 120,
                                ),
                                Wrap(
                                  children: [
                                    if (controller
                                            .findFastMotel.value.hasAirConditioner ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/dieu-hoa.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Điều hoà",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasWaterHeater ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/nong-lanh.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Nóng lạnh",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasKitchen ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/ke-bep.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Kệ bếp",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasFridge ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/tu-lanh.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Tủ lạnh",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasBed ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/giuong.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Giường ngủ",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasWashingMachine ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/may-giat.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Máy giặt",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasKitchenStuff ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/do-dung-bep.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Đồ dùng bếp",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasTable ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/ban-ghe.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Bàn ghế",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value
                                            .hasDecorativeLights ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/den-trang-tri.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Đèn trang trí",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasPicture ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/tranh-trang-tri.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Tranh trang trí",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasTree ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/cay-coi-trang-tri.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Cây cối trang trí",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasPillow ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/chan-ga-goi.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Chăn,ga gối",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasWardrobe ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/tu-quan-ao.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Tủ quần áo",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasMattress ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/nem.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Nệm",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasShoesRacks ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/ke-giay-dep.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Kệ giày dép",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasCurtain ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/rem.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Rèm",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasCeilingFans ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/quat-tran.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Quạt trần",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasMirror ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/guong.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Gương toàn thân",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (controller
                                            .findFastMotel.value.hasSofa ==
                                        true)
                                      SizedBox(
                                        width: (Get.width - 30) / 4,
                                        height: (Get.width - 30) / 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icon_images/sofa.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Sofa",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
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
      ),
      bottomNavigationBar: Obx(
        ()=>controller.loadInit.value?const SizedBox(): SizedBox(
          height: 65,
          child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
            InkWell(
              onTap: () {
                Call.call(controller.findFastMotel.value.phoneNumber ?? "");
              },
              child: Container(
                padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: const [
                    Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Gọi',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (controller.findFastMotel.value.user != null)
              InkWell(
                onTap: () {
                  Get.to(() => ChatListScreen(
                        toUser: controller.findFastMotel.value.user,
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(Get.context!).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.chat_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Chat',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            InkWell(
              onTap: () {
                if (controller.findFastMotel.value.status == 2) {
                  SahaDialogApp.showDialogYesNo(
                      mess: 'Bạn có chắc chắn muốn xoá thông tin này chứ ?',
                      onOK: () {
                        controller.deleteFindFastMotel(
                          findFastMotelId: idFindFast,
                        );
                      });
                } else {
                  controller.updateFindFastMotel(
                      findFastMotelId: idFindFast, status: 2);
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: controller.findFastMotel.value.status == 2
                        ? Colors.red
                        : Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(
                      controller.findFastMotel.value.status == 2
                          ? Icons.delete
                          : Icons.check,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      controller.findFastMotel.value.status == 2
                          ? "Xoá"
                          : 'Đã tư vấn',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
                ],
              )
          ]),
        ),
      ),
    );
  }
  Widget item({required String title,required String content}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(content),
        const Divider()
      ],
    );
  }
}