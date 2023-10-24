import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/find_room/find_room_post/post_find_room_controller.dart';
import 'package:gohomy/screen/find_room/find_room_post/report_post_find_room/report_post_find_room_screen.dart';
import 'package:gohomy/utils/map_navigation_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../components/appbar/saha_appbar.dart';
import '../../../components/arlert/saha_alert.dart';
import '../../../components/dialog/dialog.dart';
import '../../../components/empty/saha_empty_avatar.dart';
import '../../../components/loading/loading_container.dart';
import '../../../components/loading/loading_full_screen.dart';
import '../../../utils/call.dart';
import '../../../utils/share.dart';
import '../../../utils/string_utils.dart';
import '../../chat/chat_list/chat_list_screen.dart';
import '../../data_app_controller.dart';
import '../../home/home_controller.dart';
import '../../login/login_screen.dart';
import '../../profile/customer_post/customer_post_find_room/add_customer_post_find_room.dart/add_customer_post_find_room_screen.dart';
import 'list_find_room_post/list_find_room_post_screen.dart';

class PostFindRoomScreen extends StatelessWidget {
  PostFindRoomScreen({super.key, required this.postFindRoomId}) {
    controller = PostFindRoomController(postFindRoomId: postFindRoomId);
  }
  late PostFindRoomController controller;
  final int postFindRoomId;
  DataAppController dataAppController = Get.find();

  @override
  Widget build(BuildContext context) {
    String getAddress = '${controller.post.value.wardsName ?? ""} - '
        '${controller.post.value.districtName ?? ''} - '
        '${controller.post.value.provinceName ?? ''}';

    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Tìm phòng",
        actions: [
          if (dataAppController.currentUser.value.isAdmin == true)
            IconButton(
                onPressed: () {
                  Get.to(() => AddCustomerPostFindRoomScreen(
                            idPostFindRoom: postFindRoomId,
                            isAdmin: true,
                          ))!
                      .then((value) => controller.getPostFindRoom());
                },
                icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  builder: (BuildContext context) => SafeArea(
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await controller.buildLink();
                              if (controller.linkPost == null) {
                                SahaAlert.showError(
                                    message:
                                        "Có lỗi xảy ra, vui lòng thử lại sau");
                                return;
                              }
                              shareLink(controller.linkPost!);
                            },
                            child: const Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                'Chia sẻ link',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await controller.buildLink();
                              if (controller.linkPost == null) {
                                SahaAlert.showError(
                                    message:
                                        "Có lỗi xảy ra, vui lòng thử lại sau");
                                return;
                              }

                              shareQr(controller.linkPost!);
                            },
                            child: const Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                'Chia sẻ mã QR',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                'Đóng',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                // SharePost().sharePostImage(
                //     roomInformationController.roomPost.value.images ?? [],
                //     roomInformationController.roomPost.value.title ?? "");
              },
              icon: const Icon(Icons.share_rounded)),
        ],
      ),
      body: Obx(() => controller.loadInit.value
          ? SahaLoadingFullScreen()
          : SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    (controller.post.value.title ?? '').toUpperCase(),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Khu vực mong muốn",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              MapNavigationUtils().openGoogleMaps(getAddress);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    getAddress,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Khoảng giá phòng cần tìm",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                height: 40,
                                width: 40,
                                child: Icon(
                                  FontAwesomeIcons.dollar,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${SahaStringUtils().convertToUnit(controller.post.value.moneyFrom ?? 0)} - ${SahaStringUtils().convertToUnit(controller.post.value.moneyTo ?? 0)} VNĐ/Tháng",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Số lượng người ở",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                height: 40,
                                width: 40,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                controller.post.value.capacity == null
                                    ? "Chưa có thông tin"
                                    : controller.post.value.capacity.toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Giới tính",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                height: 40,
                                width: 40,
                                child: Icon(
                                  FontAwesomeIcons.marsAndVenus,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                controller.post.value.sex == 2
                                    ? "Nữ"
                                    : controller.post.value.sex == 1
                                        ? "Nam"
                                        : "Nam, Nữ",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 8,
                  color: Colors.grey[100],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 16),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => ListFindRoomPostScreen(
                            phoneNumber:
                                controller.post.value.user?.phoneNumber,
                          ));
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3000),
                          child: CachedNetworkImage(
                            imageUrl:
                                controller.post.value.user?.avatarImage ?? "",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const SahaLoadingContainer(
                              height: 40,
                              width: 30,
                            ),
                            errorWidget: (context, url, error) => const Padding(
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
                                controller.post.value.user?.name ?? "",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${controller.post.value.user?.totalPostFindMotel ?? "0"} Bài đăng",
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
                          if (controller.post.value.hasWc == true)
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
                          if (controller.post.value.hasMezzanine == true)
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
                          if (controller.post.value.hasBalcony == true)
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
                          if (controller.post.value.hasFingerPrint == true)
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
                          if (controller.post.value.hasOwnOwner == true)
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
                          if (controller.post.value.hasPet == true)
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
                          if (controller.post.value.hasAirConditioner == true)
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
                          if (controller.post.value.hasWaterHeater == true)
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
                          if (controller.post.value.hasKitchen == true)
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
                          if (controller.post.value.hasFridge == true)
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
                          if (controller.post.value.hasBed == true)
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
                          if (controller.post.value.hasWashingMachine == true)
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
                          if (controller.post.value.hasKitchenStuff == true)
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
                          if (controller.post.value.hasTable == true)
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
                          if (controller.post.value.hasDecorativeLights == true)
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
                          if (controller.post.value.hasPicture == true)
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
                          if (controller.post.value.hasTree == true)
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
                          if (controller.post.value.hasPillow == true)
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
                          if (controller.post.value.hasWardrobe == true)
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
                          if (controller.post.value.hasMattress == true)
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
                          if (controller.post.value.hasShoesRasks == true)
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
                          if (controller.post.value.hasCurtain == true)
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
                          if (controller.post.value.hasCeilingFans == true)
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
                          if (controller.post.value.hasMirror == true)
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
                          if (controller.post.value.hasSofa == true)
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
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => ChatListLockScreen(
                          toUser: controller.post.value.user,
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.chat_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Chat',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (dataAppController.badge.value.user != null) {
                      Call.call(controller.post.value.phoneNumber ?? "");
                      controller.callFindRoom();
                    } else {
                      Get.to(() => const LoginScreen(hasBack: true));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.deepOrange,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.phone,
                          color: Colors.deepOrange,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Gọi',
                          style: TextStyle(
                            color: Colors.deepOrange,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (dataAppController.badge.value.user != null) {
                      SahaDialogApp.showDialogReport(onChoose: (v) {
                        if (v == 0) {
                          Get.back();
                          Get.to(() => ReportPostFindRoomScreen(
                                idPostFindRoom: postFindRoomId,
                              ));
                        } else {
                          Get.back();
                          Call.call(Get.find<HomeController>()
                                  .homeApp
                                  .value
                                  .adminContact
                                  ?.phoneNumber ??
                              "");
                        }
                      });
                    } else {
                      Get.to(() => const LoginScreen(hasBack: true));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.report,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Báo cáo',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
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
    );
  }

  void shareLink(String link) {
    SharePost().shareLink(link);
  }

  void shareQr(String link) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        title: Center(
          child: Text(
            "Mã QR",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        ),
        content: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QrImageView(
                data: link,
                version: QrVersions.auto,
                size: Get.width / 1.5,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Huỷ'),
          ),
          TextButton(
            onPressed: () async {
              SharePost().shareQrCode(link);
            },
            child: const Text('Chia sẻ QR'),
          ),
        ],
      ),
    );
  }
}
