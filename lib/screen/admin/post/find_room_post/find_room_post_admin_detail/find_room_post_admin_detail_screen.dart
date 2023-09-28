import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';

import '../../../../../components/appbar/saha_appbar.dart';

import '../../../../../components/dialog/dialog.dart';
import '../../../../../components/empty/saha_empty_avatar.dart';
import '../../../../../components/loading/loading_container.dart';
import '../../../../../utils/string_utils.dart';
import '../../../../find_room/find_room_post/list_find_room_post/list_find_room_post_screen.dart';
import '../../../../find_room/room_information/personal_information/personal_information_screen.dart';
import '../../../../profile/customer_post/customer_post_find_room/add_customer_post_find_room.dart/add_customer_post_find_room_screen.dart';
import 'find_room_post_admin_detail_controller.dart';

class FindRoomPostDetailAdminScreen extends StatelessWidget {
  FindRoomPostDetailAdminScreen({super.key, required this.postFindRoomId}) {
    controller =
        FindRoomPostAdminDetailController(postFindRoomId: postFindRoomId);
  }

  final int postFindRoomId;
  late FindRoomPostAdminDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Chi tiết bài đăng",
        actions: [
          
            IconButton(
                onPressed: () {
                  Get.to(()=>AddCustomerPostFindRoomScreen(idPostFindRoom: postFindRoomId,isAdmin: true,))!.then((value) => controller.getAdminPostFindRoom());
                },
                icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                SahaDialogApp.showDialogYesNo(
                    mess: "Bạn có chắc chắn muốn xoá bài đăng này ?",
                    onOK: () {
                      controller.deleteAdminPostFindRoom();
                    });
              },
              icon: const Icon(FontAwesomeIcons.trashCan))
        ],
      ),
      body: Obx(
        () => controller.loadInit.value
          ? SahaLoadingFullScreen()
          : SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    (controller.postRes.value.title ?? '').toUpperCase(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "KHOẢNG GIÁ PHÒNG CẦN TÌM",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(180, 0, 0, 0)),
                          ),
                          Text(
                            "${SahaStringUtils().convertToUnit(controller.postRes.value.moneyFrom ?? 0)} - ${SahaStringUtils().convertToUnit(controller.postRes.value.moneyTo ?? 0)} VNĐ/Tháng",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "SỐ LƯỢNG NGƯỜI Ở",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(180, 0, 0, 0)),
                          ),
                          Text(
                            controller.postRes.value.capacity == null
                                ? "Chưa có thông tin"
                                : controller.postRes.value.capacity.toString(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "GIỚI TÍNH",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(180, 0, 0, 0)),
                          ),
                          Text(
                            controller.postRes.value.sex == 2
                                ? "Nữ"
                                : controller.postRes.value.sex == 1
                                    ? "Nam"
                                    : "Nam,Nữ",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 8,
                  color: Colors.grey[100],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Image.asset(
                              "assets/icon_admin/location.png",
                              height: 35,
                              width: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${controller.postRes.value.wardsName ?? ""} - ${controller.postRes.value.districtName ?? ''} - ${controller.postRes.value.provinceName ?? ''}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Image.asset(
                              "assets/icon_admin/phone.png",
                              height: 35,
                              width: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            controller.postRes.value.phoneNumber ??
                                'Chưa có thông tin',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                            Get.to(() => ListFindRoomPostScreen(
                            phoneNumber:
                                controller.postRes.value.user?.phoneNumber,
                          ));
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3000),
                              child: CachedNetworkImage(
                                imageUrl: controller
                                        .postRes.value.user?.avatarImage ??
                                    "",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const SahaLoadingContainer(
                                  height: 40,
                                  width: 30,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: SahaEmptyAvata(),
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
                                    controller.postRes.value.user?.name ?? "",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${controller.postRes.value.user?.totalPostFindMotel ?? "0"} Bài đăng",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.navigate_next_rounded),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 8,
                  color: Colors.grey[100],
                ),
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
                          if (controller.postRes.value.hasWc == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasMezzanine == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasBalcony == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasFingerPrint == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasOwnOwner == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasPet == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasAirConditioner ==
                              true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasWaterHeater == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasKitchen == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasFridge == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasBed == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasWashingMachine ==
                              true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasKitchenStuff == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasTable == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasDecorativeLights ==
                              true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasPicture == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasTree == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasPillow == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasWardrobe == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasMattress == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasShoesRasks == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasCurtain == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasCeilingFans == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasMirror == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          if (controller.postRes.value.hasSofa == true)
                            SizedBox(
                              width: (Get.width - 30) / 4,
                              height: (Get.width - 30) / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
            ))),
      bottomNavigationBar: Obx(
        () => controller.loadInit.value
            ? const SizedBox()
            : SizedBox(
                height: 90,
                child: controller.postRes.value.status == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                SahaDialogApp.showDialogYesNo(
                                    mess: "Bạn có chắc muốn duyệt bài đăng này",
                                    onClose: () {},
                                    onOK: () async {
                                      controller.updateStatusAdminPostFindRoom(
                                          status: 2);
                                    });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).primaryColor),
                                child: const Center(
                                  child: Text(
                                    'Duyệt',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                SahaDialogApp.showDialogYesNo(
                                    mess: "Bạn có chắc muốn hủy bài đăng này",
                                    onClose: () {},
                                    onOK: () async {
                                      controller.updateStatusAdminPostFindRoom(
                                          status: 1);
                                    });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).primaryColor),
                                child: const Center(
                                  child: Text(
                                    'Huỷ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : controller.postRes.value.status == 2
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title:
                                            const Text('Xác nhận ẩn bài đăng'),
                                        content: const Text(
                                            'Bạn có chắc chắn muốn ẩn bài đăng này ?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              controller
                                                  .updateStatusAdminPostFindRoom(
                                                      status: 1);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 20),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).primaryColor),
                                    child: const Center(
                                      child: Text(
                                        'Ẩn bài đăng',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    SahaDialogApp.showDialogYesNo(
                                        mess:
                                            "Bạn có chắc muốn hiện lại bài đăng này",
                                        onClose: () {},
                                        onOK: () {
                                          controller
                                              .updateStatusAdminPostFindRoom(
                                                  status: 2);
                                        });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 20),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).primaryColor),
                                    child: const Center(
                                      child: Text(
                                        'Hiển thị',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
      ),
    );
  }
}
