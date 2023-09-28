import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import '../../../../components/dialog/dialog.dart';
import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/loading/loading_container.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../components/widget/image/images.dart';
import '../../../../components/widget/post_item/post_item.dart';
import '../../../../const/motel_type.dart';
import '../../../../model/service.dart';
import '../../../../utils/call.dart';
import '../../../../utils/string_utils.dart';
import '../../../chat/chat_list/chat_list_screen.dart';
import '../../../data_app_controller.dart';
import '../../../find_room/find_room_screen.dart';
import '../../../find_room/room_information/report_violation_post/report_violation_post_screen.dart';
import '../../../find_room/room_information/reservation_motel/reservation_motel_screen.dart';
import '../../../home/home_controller.dart';
import '../../../login/login_screen.dart';
import 'favourite_details_controller.dart';

class FavouriteDetailsScreen extends StatelessWidget {
  late FavouriteDetailsController favouriteDetailsController;
  int? roomPostId;

  FavouriteDetailsScreen({required this.roomPostId}) {
    favouriteDetailsController =
        FavouriteDetailsController(roomPostId: roomPostId!);
  }

  DataAppController dataAppController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Chi tiết phòng',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_rounded)),
        ],
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
                          toUser:
                              favouriteDetailsController.roomPost.value.user,
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
                    Get.to(() => ReservationMotelScreen(
                          moPostId:
                              favouriteDetailsController.roomPost.value.id!,
                          hostId:
                              favouriteDetailsController.roomPost.value.userId!,
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.security,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Giữ chỗ',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (dataAppController.badge.value.user !=
                        null) {
                      Call.call(
                          favouriteDetailsController.roomPost.value.phoneNumber ?? "");
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
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Gọi',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (dataAppController.badge.value.user !=
                        null) {
                      SahaDialogApp.showDialogReport(onChoose: (v) {
                        if (v == 0) {
                          Get.back();
                          Get.to(() => ReportPostSCreen(
                                id: favouriteDetailsController.roomPostId,
                              ));
                        } else {
                          Get.back();
                          Call.call(
                              Get.find<HomeController>().homeApp.value.adminContact?.phoneNumber ?? "");
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
      body: Obx(
        () => favouriteDetailsController.isLoading.value
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
                        listImageUrl:
                            favouriteDetailsController.roomPost.value.images,
                        linkVideo:
                            favouriteDetailsController.roomPost.value.linkVideo,
                      ),
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
                                    '${typeRoom[favouriteDetailsController.roomPost.value.type ?? 0]}. '
                                        .toUpperCase(),
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Icon(
                                    favouriteDetailsController
                                                .roomPost.value.sex ==
                                            0
                                        ? FontAwesomeIcons.marsAndVenus
                                        : favouriteDetailsController
                                                    .roomPost.value.sex ==
                                                1
                                            ? FontAwesomeIcons.mars
                                            : FontAwesomeIcons.venus,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    favouriteDetailsController
                                                .roomPost.value.sex ==
                                            0
                                        ? "Nam, Nữ"
                                        : favouriteDetailsController
                                                    .roomPost.value.sex ==
                                                1
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
                                favouriteDetailsController
                                        .roomPost.value.title ??
                                    "",
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
                                    "${SahaStringUtils().convertToMoney(favouriteDetailsController.roomPost.value.money ?? 0)} VNĐ/Tháng",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  if (favouriteDetailsController
                                          .roomPost.value.adminVerified ==
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
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Obx(
                                    () => InkWell(
                                      onTap: () {
                                        if (dataAppController
                                                .isLogin
                                                .value ==
                                            true) {
                                          if (favouriteDetailsController
                                                  .isFavourite.value ==
                                              true) {
                                            favouriteDetailsController
                                                .isFavourite.value = false;
                                            favouriteDetailsController
                                                .setFavouritePost(
                                                    id: roomPostId!);
                                          } else {
                                            favouriteDetailsController
                                                .isFavourite.value = true;
                                            favouriteDetailsController
                                                .setFavouritePost(
                                                    id: roomPostId!);
                                          }
                                        } else {
                                          Get.to(() => const LoginScreen(
                                                hasBack: true,
                                              ));
                                        }
                                      },
                                      child: Container(
                                        padding:
                                            const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                            padding:
                                                const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              // border: Border.all(
                                              //     color: Theme.of(context)
                                              //         .primaryColor),
                                            ),
                                            child: favouriteDetailsController
                                                        .isFavourite.value ==
                                                    true
                                                ? Image.asset(
                                                    'assets/icon_user/bai-dang-da-luu.png',
                                                    fit: BoxFit.fill,
                                                    height: 35,
                                                    width: 35,
                                                  )
                                                : Image.asset(
                                                    'assets/icon_host/luu-tin-chua-luu.png',
                                                    fit: BoxFit.fill,
                                                    height: 35,
                                                    width: 35,
                                                  )),
                                      ),
                                    ),
                                  ),
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
                                        const Text(
                                          'Địa chỉ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 15,
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
                                                '${favouriteDetailsController.roomPost.value.addressDetail ?? ""}${favouriteDetailsController.roomPost.value.addressDetail == null ? "" : ", "}${favouriteDetailsController.roomPost.value.wardsName ?? ""}${favouriteDetailsController.roomPost.value.wardsName != null ? ", " : ""}${favouriteDetailsController.roomPost.value.districtName ?? ""}${favouriteDetailsController.roomPost.value.districtName != null ? ", " : ""}${favouriteDetailsController.roomPost.value.provinceName ?? ""}',
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
                                                          .badge
                                                          .value
                                                          .user !=
                                                      null
                                                  ? (favouriteDetailsController
                                                          .roomPost
                                                          .value
                                                          .phoneNumber ??
                                                      "")
                                                  : "${(favouriteDetailsController.roomPost.value.phoneNumber ?? "").substring(0, 7)}***",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
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
                                            '${favouriteDetailsController.roomPost.value.numberFloor ?? ''}',
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
                                                '${favouriteDetailsController.roomPost.value.area}m²',
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
                                            '${SahaStringUtils().convertToMoney(favouriteDetailsController.roomPost.value.deposit ?? 0)} VNĐ',
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
                                            '${favouriteDetailsController.roomPost.value.capacity}',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (favouriteDetailsController
                                                  .roomPost
                                                  .value
                                                  .quantityVehicleParked !=
                                              null &&
                                          favouriteDetailsController
                                                  .roomPost
                                                  .value
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
                                              '${favouriteDetailsController.roomPost.value.quantityVehicleParked ?? ''}',
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
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: (favouriteDetailsController
                                                .roomPost.value.moServices ??
                                            [])
                                        .map((e) => itemService(e))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Container(
                      //   padding: EdgeInsets.all(15),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         roomInformationController
                      //                     .roomPost.value.adminVerified ==
                      //                 true
                      //             ? 'Phòng đã xác thực'
                      //             : 'Phòng chưa được xác thực',
                      //         style: TextStyle(
                      //             color: Theme.of(context).primaryColor,
                      //             fontSize: 18),
                      //       ),
                      //       SizedBox(
                      //         height: 15,
                      //       ),
                      //       Row(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Icon(
                      //             Icons.security,
                      //             color: Theme.of(context).primaryColor,
                      //           ),
                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //           Expanded(
                      //             child: Text(
                      //               roomInformationController.roomPost.value
                      //                           .adminVerified ==
                      //                       true
                      //                   ? 'Phòng đã xác thực là phòng đã được Rencity đảm bảo chất lượng và giá cả. Nơi bạn có thể yên tâm cọc giữ chỗ ngay trên Rencity. Bạn sẽ không cần phải lo lắng mỗi khi đặt cọc giữ chỗ với chủ nhà xa lạ nữa.'
                      //                   : 'Phòng chưa được xác thực',
                      //               style: TextStyle(
                      //                 color: Colors.grey,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      // InkWell(
                      //   onTap: () {
                      //     SahaDialogApp.showDialogReport(onChoose: (v) {
                      //       if (v == 0) {
                      //         Get.back();
                      //         Get.to(() => ReportPostSCreen(
                      //               id: roomInformationController
                      //                   .roomPostId,
                      //             ));
                      //       } else {
                      //         Get.back();
                      //         Call.call(
                      //             "${Get.find<HomeController>().homeApp.value.adminContact?.phoneNumber ?? ""}");
                      //       }
                      //     });
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.all(15),
                      //     child: Row(
                      //       children: [
                      //         Icon(
                      //           Icons.report_problem_rounded,
                      //           color: Colors.red,
                      //         ),
                      //         SizedBox(
                      //           width: 10,
                      //         ),
                      //         Expanded(
                      //           child: Text(
                      //             'Báo cáo vi phạm',
                      //             style: TextStyle(
                      //               color: Colors.grey,
                      //             ),
                      //           ),
                      //         ),
                      //         Icon(Icons.navigate_next_rounded),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Container(
                        height: 8,
                        color: Colors.grey[100],
                      ),
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
                            Text(favouriteDetailsController
                                    .roomPost.value.description ??
                                ""),
                          ],
                        ),
                      ),

                      Container(
                        height: 8,
                        color: Colors.grey[100],
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => FindRoomScreen(
                              phoneNumber: favouriteDetailsController
                                  .roomPost.value.user!.phoneNumber));
                        },
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(3000),
                                  child: CachedNetworkImage(
                                    imageUrl: favouriteDetailsController
                                            .roomPost.value.user?.avatarImage ??
                                        "",
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                    // placeholder: (context, url) =>
                                    //     const SahaLoadingContainer(
                                    //   height: 40,
                                    //   width: 30,
                                    // ),
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
                                        favouriteDetailsController.roomPost.value.user?.name ?? "",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${favouriteDetailsController.roomPost.value.user?.totalPost ?? "0"} Bài đăng",
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
                            ),
                            Wrap(
                              children: [
                                if (favouriteDetailsController
                                        .roomPost.value.hasWc ==
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
                                        ),
                                      ],
                                    ),
                                  ),

                                if (favouriteDetailsController
                                        .roomPost.value.hasMezzanine ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasBalcony ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasFingerprint ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasOwnOwner ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasPet ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                // if (roomInformationController
                                //         .roomPost.value.hasSecurity ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         Image.asset(
                                //           "assets/icon_images/bao-ve.png",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "bảo an",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // if (roomInformationController
                                //         .roomPost.value.hasFreeMove ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         SvgPicture.asset(
                                //           "assets/icon_utility/delivery-truck.svg",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "Vận chuyển",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // if (roomInformationController
                                //         .roomPost.value.hasOwnOwner ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         SvgPicture.asset(
                                //           "assets/icon_utility/principal.svg",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "Chủ sở hữu",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // if (roomInformationController
                                //         .roomPost.value.hasAirConditioner ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         SvgPicture.asset(
                                //           "assets/icon_utility/ac.svg",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "Điều hoà",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // if (roomInformationController
                                //         .roomPost.value.hasWaterHeater ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         SvgPicture.asset(
                                //           "assets/icon_utility/water-heater.svg",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "Bình nóng lạnh",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // if (roomInformationController
                                //         .roomPost.value.hasKitchen ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         SvgPicture.asset(
                                //           "assets/icon_utility/kitchen.svg",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "Nhà bếp",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // if (roomInformationController
                                //         .roomPost.value.hasFridge ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         SvgPicture.asset(
                                //           "assets/icon_utility/fridge.svg",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "Tủ lạnh",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // if (roomInformationController
                                //         .roomPost.value.hasWashingMachine ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         SvgPicture.asset(
                                //           "assets/icon_utility/washing-machine.svg",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "Máy giặt",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // if (roomInformationController
                                //         .roomPost.value.hasMezzanine ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         SvgPicture.asset(
                                //           "assets/icon_utility/rooftop.svg",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "Gác lửng",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // if (roomInformationController
                                //         .roomPost.value.hasBed ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         SvgPicture.asset(
                                //           "assets/icon_utility/bed.svg",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "Giường ngủ",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // if (roomInformationController
                                //         .roomPost.value.hasWardrobe ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         SvgPicture.asset(
                                //           "assets/icon_utility/closet.svg",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "Tủ quần áo",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // if (roomInformationController
                                //         .roomPost.value.hasTivi ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         SvgPicture.asset(
                                //           "assets/icon_utility/tv.svg",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "Tivi",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // if (roomInformationController
                                //         .roomPost.value.hasPet ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         SvgPicture.asset(
                                //           "assets/icon_utility/pets.svg",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "Thú nuôi",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // if (roomInformationController
                                //         .roomPost.value.hasBalcony ==
                                //     true)
                                //   Container(
                                //     width: (Get.width - 30) / 4,
                                //     height: (Get.width - 30) / 4,
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         Image.asset(
                                //           "assets/icon_images/ban-cong.png",
                                //           height: 40,
                                //           width: 40,
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           "ban công",
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
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
                                if (favouriteDetailsController
                                        .roomPost.value.hasAirConditioner ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasWaterHeater ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasKitchen ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasFridge ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasBed ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasWashingMachine ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasKitchenStuff ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasTable ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasDecorativeLights ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasPicture ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasTree ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasPillow ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasWardrobe ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasMattress ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasShoesRacks ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasCurtain ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasCeilingFans ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasMirror ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                                if (favouriteDetailsController
                                        .roomPost.value.hasSofa ==
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
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          height: 320,
                          width: Get.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Bài đăng liên quan',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: favouriteDetailsController
                                          .listSimilarPost.length,
                                      itemBuilder: (context, index) {
                                        return PostItem(

                                            isInPost: true,
                                            post: favouriteDetailsController
                                                .listSimilarPost[index]);
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
            Image.asset(
              service.serviceIcon != null && service.serviceIcon!.isNotEmpty
                  ? service.serviceIcon ?? ""
                  : "",
              width: 18,
              height: 18,
            ),
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

  String? textTime(int hour, int minute) {
    return "${hour < 10 ? "0$hour" : hour}:${minute < 10 ? "0$minute" : minute}";
  }
}
