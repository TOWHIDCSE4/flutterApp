import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/screen/admin/post/roommate_post/post_roommate_admin/post_roommate_admin_detail_controller.dart';

import '../../../../../components/dialog/dialog.dart';
import '../../../../../components/empty/saha_empty_avatar.dart';
import '../../../../../components/loading/loading_container.dart';
import '../../../../../components/loading/loading_full_screen.dart';
import '../../../../../components/widget/image/images.dart';
import '../../../../../const/motel_type.dart';
import '../../../../../model/service.dart';
import '../../../../../utils/string_utils.dart';
import '../../../../data_app_controller.dart';
import '../../../../find_room/post_roommate/list_post_roommate/list_post_roommate_screen.dart';
import '../../../../profile/customer_post/customer_post_roommate/add_customer_post_roommate/add_customer_post_roommate_screen.dart';
import '../post_roommate_admin_controller.dart';

class PostRoommateAdminDetailScreen extends StatelessWidget {
  PostRoommateAdminDetailScreen({super.key, required this.postRoommateId}) {
    controller =
        PostRoommateAdminDetailController(postRoommateId: postRoommateId);
  }
  final int postRoommateId;
  late PostRoommateAdminDetailController controller;
  DataAppController dataAppController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Bài đăng tìm người ở ghép",
        actions: [
          IconButton(
                onPressed: () {
                 Get.to(()=> AddCustomerPostRoommateScreen(
                  isAdmin: true,
                  idPostRoommate: postRoommateId,
                 ));
                },
                icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                SahaDialogApp.showDialogYesNo(
                    mess: "Bạn có chắc chắn muốn xoá bài đăng này ?",
                    onOK: () {
                      controller.deleteAdminPostRoommate();
                    });
              },
              icon: const Icon(FontAwesomeIcons.trashCan))
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
                        listImageUrl: controller.postRes.value.images,
                        linkVideo: controller.postRes.value.linkVideo,
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
                                    '${typeRoom[controller.postRes.value.type ?? 0]}. '
                                        .toUpperCase(),
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Icon(
                                    controller.postRes.value.sex == 0
                                        ? FontAwesomeIcons.marsAndVenus
                                        : controller.postRes.value.sex == 1
                                            ? FontAwesomeIcons.mars
                                            : FontAwesomeIcons.venus,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    controller.postRes.value.sex == 0
                                        ? "Nam, Nữ"
                                        : controller.postRes.value.sex == 1
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
                                controller.postRes.value.title ?? "",
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
                                    "${SahaStringUtils().convertToMoney(controller.postRes.value.money ?? 0)} VNĐ/Tháng",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  if (controller.postRes.value.adminVerified ==
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
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${controller.postRes.value.addressDetail ?? ""}${controller.postRes.value.addressDetail == null ? "" : ", "}${controller.postRes.value.wardsName ?? ""}${controller.postRes.value.wardsName != null ? ", " : ""}${controller.postRes.value.districtName ?? ""}${controller.postRes.value.districtName != null ? ", " : ""}${controller.postRes.value.provinceName ?? ""}',
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
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
                                                  ? (controller.postRes.value
                                                          .phoneNumber ??
                                                      "")
                                                  : "${(controller.postRes.value.phoneNumber ?? "").substring(0, 7)}***",
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
                                            '${controller.postRes.value.numberTenantCurrent ?? ''}',
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
                                            '${controller.postRes.value.numberFindTenant ?? ''}',
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
                                            '${controller.postRes.value.numberFloor ?? ''}',
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
                                                '${controller.postRes.value.area}m²',
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
                                            '${SahaStringUtils().convertToMoney(controller.postRes.value.deposit ?? 0)} VNĐ',
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
                                            '${controller.postRes.value.capacity}',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (controller.postRes.value
                                                  .quantityVehicleParked !=
                                              null &&
                                          controller.postRes.value
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
                                              '${controller.postRes.value.quantityVehicleParked ?? ''}',
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
                                        (controller.postRes.value.moServices ??
                                                [])
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
                      if (controller.postRes.value.description != null)
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
                              Text(controller.postRes.value.description ?? ""),
                            ],
                          ),
                        ),
                      if (controller.postRes.value.description != null)
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
                           Get.to(()=>ListPostRoommateScreen(
                            phoneNumber:controller
                                   .postRes.value.user?.phoneNumber,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.postRes.value.user?.name ??
                                            "",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${controller.postRes.value.user?.totalPostRoommate ?? "0"} Bài đăng",
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
                                if (controller.postRes.value.hasWc == true)
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
                                if (controller.postRes.value.hasMezzanine ==
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
                                if (controller.postRes.value.hasBalcony == true)
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
                                if (controller.postRes.value.hasFingerPrint ==
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
                                if (controller.postRes.value.hasOwnOwner ==
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
                                if (controller.postRes.value.hasPet == true)
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
                                        .postRes.value.hasAirConditioner ==
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
                                if (controller.postRes.value.hasWaterHeater ==
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
                                if (controller.postRes.value.hasKitchen == true)
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
                                if (controller.postRes.value.hasFridge == true)
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
                                if (controller.postRes.value.hasBed == true)
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
                                        .postRes.value.hasWashingMachine ==
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
                                if (controller.postRes.value.hasKitchenStuff ==
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
                                if (controller.postRes.value.hasTable == true)
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
                                        .postRes.value.hasDecorativeLights ==
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
                                if (controller.postRes.value.hasPicture == true)
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
                                if (controller.postRes.value.hasTree == true)
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
                                if (controller.postRes.value.hasPillow == true)
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
                                if (controller.postRes.value.hasWardrobe ==
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
                                if (controller.postRes.value.hasMattress ==
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
                                if (controller.postRes.value.hasShoesRasks ==
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
                                if (controller.postRes.value.hasCurtain == true)
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
                                if (controller.postRes.value.hasCeilingFans ==
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
                                if (controller.postRes.value.hasMirror == true)
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
                                if (controller.postRes.value.hasSofa == true)
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
                                      controller.updateStatusAdminPostRoommate(
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
                                      controller.updateStatusAdminPostRoommate(
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
                                                  .updateStatusAdminPostRoommate(
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
                                              .updateStatusAdminPostRoommate(
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
}
