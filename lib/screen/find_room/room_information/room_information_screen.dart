import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/components/widget/image/images.dart';
import 'package:gohomy/components/widget/post_item/post_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:gohomy/model/service.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/find_room/room_information/personal_information/personal_information_screen.dart';
import 'package:gohomy/screen/find_room/room_information/report_violation_post/report_violation_post_screen.dart';
import 'package:gohomy/screen/home/home_controller.dart';
import 'package:gohomy/screen/login/login_screen.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../../../components/empty/saha_empty_avatar.dart';
import '../../../components/loading/loading_container.dart';
import '../../../const/motel_type.dart';
import '../../../model/motel_room.dart';
import '../../../model/user.dart';
import '../../../utils/call.dart';
import '../../../utils/share.dart';
import '../../chat/chat_list/chat_list_screen.dart';
import '../../owner/post_management/add_update_post_management/add_update_post_management_screen.dart';
import '../find_room_screen.dart';
import 'reservation_motel/reservation_motel_screen.dart';
import 'room_information_controller.dart';

class RoomInformationScreen extends StatefulWidget {
  int? roomPostId;
  bool? isWatch;
  Widget? editButton;

  RoomInformationScreen(
      {required this.roomPostId, this.isWatch, this.editButton});

  @override
  State<RoomInformationScreen> createState() => _RoomInformationScreenState();
}

class _RoomInformationScreenState extends State<RoomInformationScreen> {
  DataAppController dataAppController = Get.find();
  late RoomInformationController roomInformationController;

  @override
  void initState() {
    roomInformationController =
        RoomInformationController(roomPostId: widget.roomPostId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            // image: DecorationImage(
            //     fit: BoxFit.cover, image: AssetImage('assets/anh-nen.jpg')),
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Chi tiết phòng',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          // widget.editButton ?? Container(),
          if (dataAppController.currentUser.value.isAdmin == true)
            widget.editButton ??
                IconButton(
                    onPressed: () {
                      Get.to(() => AddUpdatePostManagementScreen(
                                id: widget.roomPostId,
                              ))!
                          .then((value) =>
                              roomInformationController.getRoomPost());
                    },
                    icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                //roomInformationController.buildLink();

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
                              await roomInformationController.buildLink();
                              if (roomInformationController.linkPost == null) {
                                SahaAlert.showError(
                                    message:
                                        "Có lỗi xảy ra, vui lòng thử lại sau");
                                return;
                              }
                              shareLink(roomInformationController.linkPost!);
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
                              await roomInformationController.buildLink();
                              if (roomInformationController.linkPost == null) {
                                SahaAlert.showError(
                                    message:
                                        "Có lỗi xảy ra, vui lòng thử lại sau");
                                return;
                              }

                              shareQr(roomInformationController.linkPost!);
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
        () => roomInformationController.isLoading.value
            ? SahaLoadingFullScreen()
            : roomInformationController.isLoading1.value
                ? SahaLoadingFullScreen()
                : SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => RoomImage(
                              key: Key(const Uuid().v4()),
                              listImageUrl: roomInformationController
                                          .motelRoomChoose.value.id ==
                                      null
                                  ? roomInformationController
                                      .roomPost.value.images
                                  : roomInformationController
                                      .motelRoomChoose.value.images,
                              linkVideo: roomInformationController
                                          .motelRoomChoose.value.id ==
                                      null
                                  ? roomInformationController
                                      .roomPost.value.linkVideo
                                  : roomInformationController
                                      .motelRoomChoose.value.videoLink,
                            ),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${typeRoom[roomInformationController.roomPost.value.type ?? 0]}. '
                                            .toUpperCase(),
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      Icon(
                                        roomInformationController
                                                    .roomPost.value.sex ==
                                                0
                                            ? FontAwesomeIcons.marsAndVenus
                                            : roomInformationController
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
                                        roomInformationController
                                                    .roomPost.value.sex ==
                                                0
                                            ? "Nam, Nữ"
                                            : roomInformationController
                                                        .roomPost.value.sex ==
                                                    1
                                                ? "Nam"
                                                : "Nữ",
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Text(
                                    roomInformationController
                                            .roomPost.value.title ??
                                        "",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        roomInformationController.roomPost.value
                                                        .towerId !=
                                                    null &&
                                                roomInformationController
                                                        .motelRoomChoose
                                                        .value
                                                        .id ==
                                                    null
                                            ? "${SahaStringUtils().convertToMoney(roomInformationController.minMoney ?? 0)} - ${SahaStringUtils().convertToMoney(roomInformationController.maxMoney ?? 0)}VNĐ/Tháng"
                                            : "${SahaStringUtils().convertToMoney(roomInformationController.motelRoomChoose.value.money ?? 0)} VNĐ/Tháng",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   width: 10,
                                      // ),
                                      if (roomInformationController
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
                                      // const SizedBox(
                                      //   width: 10,
                                      // ),
                                      Obx(
                                        () => InkWell(
                                          onTap: () {
                                            if (Get.find<DataAppController>()
                                                    .isLogin
                                                    .value ==
                                                true) {
                                              if (roomInformationController
                                                      .roomPost
                                                      .value
                                                      .isFavorite ==
                                                  true) {
                                                roomInformationController
                                                    .roomPost
                                                    .value
                                                    .isFavorite = false;
                                                roomInformationController
                                                    .setFavouritePost(
                                                        id: widget.roomPostId!);
                                              } else {
                                                roomInformationController
                                                    .roomPost
                                                    .value
                                                    .isFavorite = true;
                                                roomInformationController
                                                    .setFavouritePost(
                                                        id: widget.roomPostId!);
                                              }
                                            } else {
                                              Get.to(() => const LoginScreen(
                                                    hasBack: true,
                                                  ));
                                            }
                                          },
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 2, 5, 2),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                // border: Border.all(
                                                //     color: Theme.of(context)
                                                //         .primaryColor),
                                              ),
                                              child: roomInformationController
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
                                    ],
                                  ),
                                ),
                                if (roomInformationController.roomPost.value
                                            .moneyCommissionUser !=
                                        null &&
                                    roomInformationController.roomPost.value
                                            .moneyCommissionUser !=
                                        0)
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: Row(
                                      children: [
                                        const Text(
                                            'Hoa hồng cho cộng tác viên :  '),
                                        Text(
                                          '${SahaStringUtils().convertToMoney(roomInformationController.roomPost.value.moneyCommissionUser)} VNĐ',
                                          style: const TextStyle(
                                              color: Colors.deepOrange,
                                              fontWeight: FontWeight.w400),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    dataAppController.isLogin
                                                                .value !=
                                                            true
                                                        ? "${roomInformationController.roomPost.value.districtName ?? ""}${roomInformationController.roomPost.value.districtName != null ? ", " : ""}${roomInformationController.roomPost.value.provinceName ?? ""}"
                                                        : '${roomInformationController.roomPost.value.addressDetail ?? ""}${roomInformationController.roomPost.value.addressDetail == null ? "" : ", "}${roomInformationController.roomPost.value.wardsName ?? ""}${roomInformationController.roomPost.value.wardsName != null ? ", " : ""}${roomInformationController.roomPost.value.districtName ?? ""}${roomInformationController.roomPost.value.districtName != null ? ", " : ""}${roomInformationController.roomPost.value.provinceName ?? ""}',
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
                                                  dataAppController.badge.value
                                                              .user !=
                                                          null
                                                      ? (roomInformationController
                                                              .roomPost
                                                              .value
                                                              .phoneNumber ??
                                                          "")
                                                      : "${(roomInformationController.roomPost.value.phoneNumber ?? "").substring(0, 7)}***",
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (roomInformationController
                                              .roomPost.value.towerId !=
                                          null)
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const Divider(),
                                            Wrap(
                                              children: [
                                                ...(roomInformationController
                                                            .roomPost
                                                            .value
                                                            .listMotel ??
                                                        [])
                                                    .map((e) => itemRoom(e))
                                              ],
                                            ),
                                          ],
                                        ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Divider(),
                                      Obx(
                                        () => roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null
                                            ? const SizedBox()
                                            : Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  const Divider(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          const Text(
                                                            'TẦNG',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            '${roomInformationController.motelRoomChoose.value.numberFloor ?? ''}',
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
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
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '${roomInformationController.motelRoomChoose.value.area}m²',
                                                                style:
                                                                    TextStyle(
                                                                  color: Theme.of(
                                                                          context)
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
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            '${SahaStringUtils().convertToMoney(roomInformationController.motelRoomChoose.value.deposit ?? 0)} VNĐ',
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
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
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            '${roomInformationController.motelRoomChoose.value.capacity}',
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      if (roomInformationController
                                                                  .motelRoomChoose
                                                                  .value
                                                                  .quantityVehicleParked !=
                                                              null &&
                                                          roomInformationController
                                                                  .motelRoomChoose
                                                                  .value
                                                                  .quantityVehicleParked !=
                                                              0)
                                                        Column(
                                                          children: [
                                                            const Text(
                                                              'CHỖ ĐỂ XE',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              '${roomInformationController.motelRoomChoose.value.quantityVehicleParked ?? ''}',
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
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
                                        children: (roomInformationController
                                                    .roomPost
                                                    .value
                                                    .moServices ??
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
                          if (roomInformationController
                                  .roomPost.value.description !=
                              null)
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
                                  Text(roomInformationController
                                          .roomPost.value.description ??
                                      ""),
                                ],
                              ),
                            ),
                          if (roomInformationController
                                  .roomPost.value.description !=
                              null)
                            Container(
                              height: 8,
                              color: Colors.grey[100],
                            ),
                          InkWell(
                            onTap: () {
                              // Get.to(() => FindRoomScreen(
                              //     phoneNumber: roomInformationController
                              //         .roomPost.value.user!.phoneNumber));
                              Get.to(() => PersonalInformationScreen(
                                    phoneNumber: roomInformationController
                                        .roomPost.value.user!.phoneNumber,
                                    isFromPost: true,
                                    user: roomInformationController
                                            .roomPost.value.user ??
                                        User(),
                                  ));
                            },
                            child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(3000),
                                      child: CachedNetworkImage(
                                        imageUrl: roomInformationController
                                                .roomPost
                                                .value
                                                .user
                                                ?.avatarImage ??
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
                                          Row(
                                            children: [
                                              Text(
                                                roomInformationController.roomPost
                                                        .value.user?.name ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 5
                                              ),
                                              if(roomInformationController.roomPost.value.user?.cmndNumber != null)
                                                const Icon(Icons.check_circle, color: Colors.blueAccent, size: 20)
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${roomInformationController.roomPost.value.user?.totalPost ?? "0"} Bài đăng",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                    if ((roomInformationController
                                                    .roomPost.value.hasWc ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose.value.hasWc ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasMezzanine ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasMezzanine ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasBalcony ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasBalcony ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasFingerprint ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasFingerprint ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasOwnOwner ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasOwnOwner ==
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
                                    if ((roomInformationController
                                                    .roomPost.value.hasPet ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose.value.hasPet ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasAirConditioner ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasAirConditioner ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasWaterHeater ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasWaterHeater ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasKitchen ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasKitchen ==
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
                                    if ((roomInformationController
                                                    .roomPost.value.hasFridge ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasFridge ==
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
                                    if ((roomInformationController
                                                    .roomPost.value.hasBed ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose.value.hasBed ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasWashingMachine ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasWashingMachine ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasKitchenStuff ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasKitchenStuff ==
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
                                    if ((roomInformationController
                                                    .roomPost.value.hasTable ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasTable ==
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
                                    if ((roomInformationController
                                                    .roomPost
                                                    .value
                                                    .hasDecorativeLights ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasPicture ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasPicture ==
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
                                    if ((roomInformationController
                                                    .roomPost.value.hasTree ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasTree ==
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
                                    if ((roomInformationController
                                                    .roomPost.value.hasPillow ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasPillow ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasWardrobe ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasWardrobe ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasMattress ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasMattress ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasShoesRacks ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasShoesRacks ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasCurtain ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasCurtain ==
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
                                    if ((roomInformationController.roomPost
                                                    .value.hasCeilingFans ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasCeilingFans ==
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
                                    if ((roomInformationController
                                                    .roomPost.value.hasMirror ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasMirror ==
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
                                    if ((roomInformationController
                                                    .roomPost.value.hasSofa ==
                                                true &&
                                            roomInformationController
                                                    .motelRoomChoose.value.id ==
                                                null) ||
                                        roomInformationController
                                                .motelRoomChoose
                                                .value
                                                .hasSofa ==
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
                          Obx(
                            () => roomInformationController
                                    .listSimilarPost.isEmpty
                                ? const SizedBox()
                                : SizedBox(
                                    height: 320,
                                    width: Get.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Bài đăng liên quan',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    roomInformationController
                                                        .listSimilarPost.length,
                                                itemBuilder: (context, index) {
                                                  return PostItem(
                                                    post:
                                                        roomInformationController
                                                                .listSimilarPost[
                                                            index],
                                                    isInPost: true,
                                                  );
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
      bottomNavigationBar: widget.isWatch == true
          ? null
          : SizedBox(
              height: 80,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => ChatListLockScreen(
                                toUser: roomInformationController
                                    .roomPost.value.user,
                                isBackAll: true,
                                motelPost:
                                    roomInformationController.roomPost.value,
                              ));
                          roomInformationController.addPotentialUser(
                              typeFrom: 2);
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
                                moPostId: roomInformationController
                                    .roomPost.value.id!,
                                hostId: roomInformationController
                                    .roomPost.value.userId!,
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
                          if (dataAppController.badge.value.user != null) {
                            Call.call(roomInformationController
                                    .roomPost.value.phoneNumber ??
                                "");
                            roomInformationController.addPotentialUser(
                                typeFrom: 3);
                            roomInformationController.callRequest();
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
                                Get.to(() => ReportPostSCreen(
                                      id: roomInformationController.roomPostId,
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

  String? textTime(int hour, int minute) {
    return "${hour < 10 ? "0$hour" : hour}:${minute < 10 ? "0$minute" : minute}";
  }

  Widget itemRoom(
    MotelRoom motelRoom,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if(motelRoom.isHidden != 1) {
            roomInformationController.motelRoomChoose.value = motelRoom;
          }
        },
        child: Stack(
          children: [
            Container(
              width: Get.width / 3 - 26,
              decoration: BoxDecoration(
                border: Border.all(
                    color: motelRoom.id ==
                            roomInformationController.motelRoomChoose.value.id
                        ? Theme.of(Get.context!).primaryColor
                        : Colors.grey[200]!),
                color: motelRoom.isHidden == 1
                    ? Colors.grey.withOpacity(0.1)
                    : motelRoom.id ==
                            roomInformationController.motelRoomChoose.value.id
                        ? Colors.white
                        : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                boxShadow: motelRoom.id ==
                        roomInformationController.motelRoomChoose.value.id
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
              ),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(motelRoom.motelName ?? '.'),
              ),
            ),
            if (motelRoom.id ==
                roomInformationController.motelRoomChoose.value.id)
              Positioned(
                left: -25,
                top: -20,
                child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(Get.context!).primaryColor,
                    ),
                    transform: Matrix4.rotationZ(-0.5),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: const <Widget>[
                        Positioned(
                            bottom: -0,
                            right: 20,
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation(20 / 360),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 13,
                              ),
                            ))
                      ],
                    )),
              )
          ],
        ),
      ),
    );
  }

  void sharePostImage() {
    SharePost().sharePostImage(
        roomInformationController.roomPost.value.images ?? [],
        roomInformationController.roomPost.value.title ?? "");
  }

  void shareLink(String link) {
    SharePost().shareLink(link);
  }

  void shareQr(String link) {
    showDialog(
      context: context,
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
