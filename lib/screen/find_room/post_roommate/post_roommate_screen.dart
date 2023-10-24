import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/find_room/post_roommate/post_roommate_controller.dart';
import 'package:gohomy/screen/find_room/post_roommate/report_post_roommate/report_post_roommate_screen.dart';
import 'package:gohomy/utils/map_navigation_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../components/dialog/dialog.dart';
import '../../../components/empty/saha_empty_avatar.dart';
import '../../../components/loading/loading_container.dart';
import '../../../components/loading/loading_full_screen.dart';
import '../../../components/widget/image/images.dart';
import '../../../const/motel_type.dart';
import '../../../model/service.dart';
import '../../../utils/call.dart';
import '../../../utils/share.dart';
import '../../../utils/string_utils.dart';
import '../../chat/chat_list/chat_list_screen.dart';
import '../../home/home_controller.dart';
import '../../login/login_screen.dart';
import 'list_post_roommate/list_post_roommate_screen.dart';

class PostRoommateScreen extends StatelessWidget {
  PostRoommateScreen({super.key, required this.postRoommateId}) {
    controller = PostRoommateController(postRoommateId: postRoommateId);
  }
  final int postRoommateId;
  late PostRoommateController controller;
  DataAppController dataAppController = Get.find();

  @override
  Widget build(BuildContext context) {
    String getAddress =
        '${controller.post.value.addressDetail ?? ""}${controller.post.value.addressDetail == null ? "" : ", "}${controller.post.value.wardsName ?? ""}${controller.post.value.wardsName != null ? ", " : ""}${controller.post.value.districtName ?? ""}${controller.post.value.districtName != null ? ", " : ""}${controller.post.value.provinceName ?? ""}';

    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Tìm người ở ghép",
        actions: [
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
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              sharePostImage();
                            },
                            child: const Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                'Chia sẻ ảnh',
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
              },
              icon: const Icon(Icons.share_rounded)),
        ],
      ),
      body: Obx(
        () => controller.loadInit.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoomImage(
                        listImageUrl: controller.post.value.images,
                        linkVideo: controller.post.value.linkVideo,
                      ),
                      // Container(
                      //   height: Get.height / 3,
                      //   // child: Swiper(
                      //   //   itemBuilder: (BuildContext context, int index) {
                      //   //     return Container(
                      //   //       child: Image.network(
                      //   //         (roomInformationController
                      //   //                 .roomPost.value.images ??
                      //   //             [])[index],
                      //   //         fit: BoxFit.cover,
                      //   //       ),
                      //   //     );
                      //   //   },
                      //   //   itemCount: (roomInformationController
                      //   //               .roomPost.value.images ??
                      //   //           [])
                      //   //       .length,
                      //   //   pagination: SwiperPagination(),
                      //   // ),
                      //   child: RoomImage(
                      //     listImageUrl:
                      //         roomInformationController.roomPost.value.images,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                children: [
                                  Text(
                                    '${typeRoom[controller.post.value.type ?? 0]}. '
                                        .toUpperCase(),
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Icon(
                                    controller.post.value.sex == 0
                                        ? FontAwesomeIcons.marsAndVenus
                                        : controller.post.value.sex == 1
                                            ? FontAwesomeIcons.mars
                                            : FontAwesomeIcons.venus,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    controller.post.value.sex == 0
                                        ? "Nam, Nữ"
                                        : controller.post.value.sex == 1
                                            ? "Nam"
                                            : "Nữ",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Text(
                                controller.post.value.title ?? "",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${SahaStringUtils().convertToMoney(controller.post.value.money ?? 0)} VNĐ/Tháng",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  if (controller.post.value.adminVerified ==
                                      true)
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/icon_images/xac-thuc.png',
                                          width: 25,
                                          height: 25,
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        const Text(
                                          'Xác thực',
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        )
                                      ],
                                    ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 8,
                              color: Colors.grey[100],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            MapNavigationUtils().openGoogleMaps(
                                              '${controller.post.value.addressDetail ?? ""}${controller.post.value.addressDetail == null ? "" : ", "}${controller.post.value.wardsName ?? ""}${controller.post.value.wardsName != null ? ", " : ""}${controller.post.value.districtName ?? ""}${controller.post.value.districtName != null ? ", " : ""}${controller.post.value.provinceName ?? ""}',
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.blue,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${controller.post.value.addressDetail ?? ""}${controller.post.value.addressDetail == null ? "" : ", "}${controller.post.value.wardsName ?? ""}${controller.post.value.wardsName != null ? ", " : ""}${controller.post.value.districtName ?? ""}${controller.post.value.districtName != null ? ", " : ""}${controller.post.value.provinceName ?? ""}',
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.phone_outlined,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              dataAppController
                                                          .badge.value.user !=
                                                      null
                                                  ? (controller.post.value
                                                          .phoneNumber ??
                                                      "")
                                                  : "${(controller.post.value.phoneNumber ?? "").substring(0, 7)}***",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("SỐ NGƯỜI HIỆN TẠI:  "),
                                          Text(
                                            '${controller.post.value.numberTenantCurrent ?? ''}',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("SỐ NGƯỜI TÌM GHÉP:  "),
                                          Text(
                                            '${controller.post.value.numberFindTenant ?? ''}',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // Column(
                                      //   children: [
                                      //     Text(
                                      //       'CÒN PHÒNG',
                                      //       style: TextStyle(
                                      //         color: Colors.grey,
                                      //         fontSize: 10,
                                      //       ),
                                      //     ),
                                      //     SizedBox(
                                      //       height: 10,
                                      //     ),
                                      //     Text(
                                      //       roomInformationController.roomPost
                                      //                   .value.availableMotel ==
                                      //               true
                                      //           ? 'Còn'
                                      //           : 'Đã cho thuê',
                                      //       style: TextStyle(
                                      //         color:
                                      //             Theme.of(context).primaryColor,
                                      //         fontSize: 16,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Column(
                                        children: [
                                          const Text(
                                            'TẦNG',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${controller.post.value.numberFloor ?? ''}',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'DIỆN TÍCH',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${controller.post.value.area}m²',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'ĐẶT CỌC',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${SahaStringUtils().convertToMoney(controller.post.value.deposit ?? 0)} VNĐ',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'SỐ NGƯỜI',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${controller.post.value.capacity ?? 0}',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (controller.post.value
                                                  .quantityVehicleParked !=
                                              null &&
                                          controller.post.value
                                                  .quantityVehicleParked !=
                                              0)
                                        Column(
                                          children: [
                                            const Text(
                                              'CHỖ ĐỂ XE',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${controller.post.value.quantityVehicleParked ?? ''}',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Image.asset(
                                    'assets/icon_host/phi-dich-vu.png',
                                    width: 120,
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children:
                                        (controller.post.value.moServices ?? [])
                                            .map((e) => itemService(e))
                                            .toList(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: 8,
                        color: Colors.grey[100],
                      ),
                      if (controller.post.value.description != null)
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/icon_host/chi-tiet.png',
                                width: 110,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(controller.post.value.description ?? ""),
                            ],
                          ),
                        ),
                      if (controller.post.value.description != null)
                        Container(
                          height: 8,
                          color: Colors.grey[100],
                        ),
                      InkWell(
                        onTap: () {
                          // Get.to(() => FindRoomScreen(
                          //     phoneNumber: roomInformationController
                          //         .roomPost.value.user!.phoneNumber));
                          // Get.to(() => PersonalInformationScreen(
                          //     phoneNumber: roomInformationController
                          //         .roomPost.value.user!.phoneNumber));
                          Get.to(() => ListPostRoommateScreen(
                                phoneNumber:
                                    controller.post.value.user?.phoneNumber,
                              ));
                        },
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(3000),
                                  child: CachedNetworkImage(
                                    imageUrl: controller
                                            .post.value.user?.avatarImage ??
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.post.value.user?.name ?? "",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${controller.post.value.user?.totalPostRoommate ?? "0"} Bài đăng",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.navigate_next_rounded),
                              ],
                            )),
                      ),
                      Container(
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
                                if (controller.post.value.hasMezzanine == true)
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
                                if (controller.post.value.hasBalcony == true)
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
                                if (controller.post.value.hasFingerPrint ==
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
                                if (controller.post.value.hasOwnOwner == true)
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
                                if (controller.post.value.hasPet == true)
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
                                if (controller.post.value.hasAirConditioner ==
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
                                if (controller.post.value.hasWaterHeater ==
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
                                if (controller.post.value.hasKitchen == true)
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
                                if (controller.post.value.hasFridge == true)
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
                                if (controller.post.value.hasBed == true)
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
                                if (controller.post.value.hasWashingMachine ==
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
                                if (controller.post.value.hasKitchenStuff ==
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
                                if (controller.post.value.hasTable == true)
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
                                if (controller.post.value.hasDecorativeLights ==
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
                                if (controller.post.value.hasPicture == true)
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
                                if (controller.post.value.hasTree == true)
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
                                if (controller.post.value.hasPillow == true)
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
                                if (controller.post.value.hasWardrobe == true)
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
                                if (controller.post.value.hasMattress == true)
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
                                if (controller.post.value.hasShoesRasks == true)
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
                                if (controller.post.value.hasCurtain == true)
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
                                if (controller.post.value.hasCeilingFans ==
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
                                if (controller.post.value.hasMirror == true)
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
                                if (controller.post.value.hasSofa == true)
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
                      controller.callPostRoommate();
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
                          Get.to(() => ReportPostRoommateScreen(
                                idPostRoommate: postRoommateId,
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

  Widget itemService(Service service) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
      child: SizedBox(
        //color: Colors.green,
        width: (Get.width - 40) / 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            service.serviceIcon != null
                ? Image.asset(
                    service.serviceIcon != null &&
                            service.serviceIcon!.isNotEmpty
                        ? service.serviceIcon ?? ""
                        : "",
                    width: 18,
                    height: 18,
                  )
                : const SizedBox(),
            const SizedBox(
              width: 4,
            ),
            Text(
              "${service.serviceName}:",
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                "${SahaStringUtils().convertToMoney(service.serviceCharge ?? "")}đ/${(service.serviceUnit ?? "") == 'Người hoặc số lượng' ? "Người" : service.serviceUnit ?? ""}",
                maxLines: 2,
                style: TextStyle(
                    fontSize: 12, color: Theme.of(Get.context!).primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  void sharePostImage() {
    SharePost().sharePostImage(
        controller.post.value.images ?? [], controller.post.value.title ?? "");
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
