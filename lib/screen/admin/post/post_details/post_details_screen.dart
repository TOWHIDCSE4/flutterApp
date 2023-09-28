import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/admin/post/post_details/post_details_controller.dart';
import 'package:gohomy/screen/find_room/find_room_post/post_find_room_controller.dart';
import 'package:gohomy/utils/share.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../components/dialog/dialog.dart';
import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/loading/loading_container.dart';
import '../../../../components/widget/image/images.dart';
import '../../../../const/motel_type.dart';
import '../../../../model/motel_post.dart';
import '../../../../model/motel_room.dart';
import '../../../../model/service.dart';
import '../../../../utils/string_utils.dart';
import '../../../chat/chat_list/chat_list_screen.dart';
import '../../../data_app_controller.dart';
import '../../../find_room/find_room_screen.dart';
import '../../../owner/post_management/add_update_post_management/add_update_post_management_screen.dart';

class PostDetailsScreen extends StatelessWidget {
  MotelPost? motelPostInput;
  int id;
  final VoidCallback? onTapEdit;
  late PostFindRoomController controller;
  final bool isVisibleShareIcon;
  late bool? isFindRoomPost;

  PostDetailsScreen({
    super.key,
    required this.id,
    this.motelPostInput,
    this.onTapEdit,
    this.isVisibleShareIcon = false,
    this.isFindRoomPost = false,
  }) {
    if(isFindRoomPost == true) {
      controller = PostFindRoomController(postFindRoomId: id);
    }
    postDetailsController = PostDetailsController(id: id);
  }

  late PostDetailsController postDetailsController;
  DataAppController dataAppController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => postDetailsController.loadInit.value || onTapEdit != null
            ? const SizedBox()
            : SizedBox(
                height: 90,
                child: postDetailsController.motelPost.value.status == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => AddUpdatePostManagementScreen(
                                        id: id,
                                      ))!
                                  .then((value) =>
                                      {postDetailsController.getMotelPost()});
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).primaryColor),
                              child: const Text(
                                'Chỉnh sửa',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              SahaDialogApp.showDialogYesNo(
                                  mess: "Bạn có chắc muốn duyệt bài đăng này",
                                  onClose: () {},
                                  onOK: () async {
                                    postDetailsController.approvePost(stt: 2);
                                  });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).primaryColor),
                              child: const Text(
                                'Duyệt',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Obx(
                            () => InkWell(
                              onTap: () {
                                SahaDialogApp.showDialogYesNo(
                                    mess: postDetailsController.isVerified ==
                                            false
                                        ? "Bạn có chắc muốn duyệt và xác thực bài đăng này"
                                        : 'Bạn có chắc muốn huỷ xác thực bài đăng này',
                                    onClose: () {},
                                    onOK: () async {
                                      if (postDetailsController.isVerified ==
                                          true) {
                                        postDetailsController.verify(
                                            verifyPost: false);
                                      } else {
                                        postDetailsController.verify(
                                            verifyPost: true, isBack: false);
                                        postDetailsController.approvePost(
                                            stt: 2);
                                      }
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      postDetailsController.isVerified == false
                                          ? Colors.green
                                          : Theme.of(context).primaryColor,
                                ),
                                child: Text(
                                  postDetailsController.isVerified == false
                                      ? 'Xác thực'
                                      : 'Huỷ xác thực',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              SahaDialogApp.showDialogYesNo(
                                  mess: "Bạn có chắc muốn hủy bài đăng này",
                                  onClose: () {},
                                  onOK: () async {
                                    postDetailsController.approvePost(stt: 1);
                                  });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).primaryColor),
                              child: const Text(
                                'Huỷ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    : postDetailsController.motelPost.value.status == 2
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => AddUpdatePostManagementScreen(
                                            id: id,
                                          ))!
                                      .then((value) => {
                                            postDetailsController.getMotelPost()
                                          });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).primaryColor),
                                  child: const Text(
                                    'Cập nhật',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Xác nhận ẩn bài đăng'),
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
                                            postDetailsController.approvePost(
                                                stt: 1);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).primaryColor),
                                  child: const Text(
                                    'Ẩn bài đăng',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Obx(
                                () => InkWell(
                                  onTap: () {
                                    SahaDialogApp.showDialogYesNo(
                                        mess: postDetailsController
                                                    .isVerified ==
                                                false
                                            ? "Bạn có chắc muốn xác thực bài đăng này"
                                            : 'Bạn có chắc muốn huỷ xác thực bài đăng này',
                                        onClose: () {},
                                        onOK: () async {
                                          if (postDetailsController
                                                  .isVerified ==
                                              true) {
                                            postDetailsController.verify(
                                                verifyPost: false);
                                          } else {
                                            postDetailsController.verify(
                                                verifyPost: true);
                                          }
                                        });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).primaryColor),
                                    child: Text(
                                      postDetailsController.isVerified == false
                                          ? 'Xác thực'
                                          : 'Huỷ xác thực',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => AddUpdatePostManagementScreen(
                                            id: id,
                                          ))!
                                      .then((value) => {
                                            postDetailsController.getMotelPost()
                                          });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).primaryColor),
                                  child: const Text(
                                    'Cập nhật',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  SahaDialogApp.showDialogYesNo(
                                      mess:
                                          "Bạn có chắc muốn hiện lại bài đăng này",
                                      onClose: () {},
                                      onOK: () {
                                        postDetailsController.approvePost(
                                            stt: 0);
                                      });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).primaryColor),
                                  child: const Text(
                                    'Hiển thị',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: const Text('Chi tiết bài đăng'),
        actions: [
          IconButton(
              onPressed: () {
                if (onTapEdit == null) {
                  Get.to(() => ChatListScreen(
                        toUser: postDetailsController.motelPost.value.user,
                        isBackAll: true,
                      ));
                } else {
                  onTapEdit!();
                }
              },
              icon: onTapEdit == null
                  ? const Icon(Icons.chat)
                  : const Icon(Icons.edit)),
                  
          !isVisibleShareIcon ? GestureDetector(
            onTap: () {
              SahaDialogApp.showDialogYesNo(
                  mess: "Bạn có chắc muốn xoá bài đăng này",
                  onClose: () {},
                  onOK: () async {
                    await postDetailsController.deleteMotelPost();
                    Get.back();
                  });
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              child: const Icon(
                FontAwesomeIcons.trashCan,
              ),
            ),
          ) :
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
      body: Obx(
        () => postDetailsController.loadInit.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoomImage(
                      key: Key(const Uuid().v4()),
                      listImageUrl:
                          postDetailsController.motelRoomChoose.value.id == null
                              ? postDetailsController.motelPost.value.images
                              : postDetailsController
                                  .motelRoomChoose.value.images,
                      linkVideo:
                          postDetailsController.motelRoomChoose.value.id == null
                              ? postDetailsController.motelPost.value.linkVideo
                              : postDetailsController
                                  .motelRoomChoose.value.videoLink,
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
                                  '${typeRoom[postDetailsController.motelPost.value.type ?? 0]}. '
                                      .toUpperCase(),
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                Icon(
                                  postDetailsController.motelPost.value.sex == 0
                                      ? FontAwesomeIcons.marsAndVenus
                                      : postDetailsController
                                                  .motelPost.value.sex ==
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
                                  postDetailsController.motelPost.value.sex == 0
                                      ? "Nam, Nữ"
                                      : postDetailsController
                                                  .motelPost.value.sex ==
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
                              postDetailsController.motelPost.value.title ?? "",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  postDetailsController
                                                  .motelPost.value.towerId !=
                                              null &&
                                          postDetailsController
                                                  .motelRoomChoose.value.id ==
                                              null
                                      ? "${SahaStringUtils().convertToMoney(postDetailsController.minMoney ?? 0)} - ${SahaStringUtils().convertToMoney(postDetailsController.maxMoney ?? 0)}VNĐ/Tháng"
                                      : "${SahaStringUtils().convertToMoney(postDetailsController.motelRoomChoose.value.money ?? 0)} VNĐ/Tháng",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                if (postDetailsController
                                        .motelPost.value.adminVerified ==
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (postDetailsController
                                      .motelPost.value.moneyCommissionUser !=
                                  null &&
                              postDetailsController
                                      .motelPost.value.moneyCommissionUser !=
                                  0)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                children: [
                                  const Text('Hoa hồng cho cộng tác viên :  '),
                                  Text(
                                    '${SahaStringUtils().convertToMoney(postDetailsController.motelPost.value.moneyCommissionUser)} VNĐ',
                                    style: const TextStyle(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
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
                                              '${postDetailsController.motelPost.value.addressDetail ?? ""}${postDetailsController.motelPost.value.addressDetail == null ? "" : ", "}${postDetailsController.motelPost.value.wardsName ?? ""}${postDetailsController.motelPost.value.wardsName != null ? ", " : ""}${postDetailsController.motelPost.value.districtName ?? ""}${postDetailsController.motelPost.value.districtName != null ? ", " : ""}${postDetailsController.motelPost.value.provinceName ?? ""}',
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
                                                ? (postDetailsController
                                                        .motelPost
                                                        .value
                                                        .phoneNumber ??
                                                    "")
                                                : "${(postDetailsController.motelPost.value.phoneNumber ?? "").substring(0, 7)}***",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if (postDetailsController
                                        .motelPost.value.towerId !=
                                    null)
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Divider(),
                                      Wrap(
                                        children: [
                                          ...(postDetailsController.motelPost
                                                      .value.listMotel ??
                                                  [])
                                              .map((e) => itemRoom(e))
                                        ],
                                      ),
                                    ],
                                  ),
                                Obx(
                                  () => postDetailsController
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
                                                  MainAxisAlignment.spaceAround,
                                              children: [
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
                                                      '${postDetailsController.motelRoomChoose.value.numberFloor ?? ''}',
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
                                                          '${postDetailsController.motelRoomChoose.value.area}m²',
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
                                                      '${SahaStringUtils().convertToMoney(postDetailsController.motelRoomChoose.value.deposit ?? 0)} VNĐ',
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
                                                      '${postDetailsController.motelRoomChoose.value.capacity}',
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                if (postDetailsController
                                                            .motelRoomChoose
                                                            .value
                                                            .quantityVehicleParked !=
                                                        null &&
                                                    postDetailsController
                                                            .motelRoomChoose
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
                                                        '${postDetailsController.motelRoomChoose.value.quantityVehicleParked ?? ''}',
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
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
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: (postDetailsController
                                              .motelPost.value.moServices ??
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
                          Text(postDetailsController
                                  .motelPost.value.description ??
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
                            phoneNumber: postDetailsController
                                .motelPost.value.user!.phoneNumber));
                      },
                      child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3000),
                                child: CachedNetworkImage(
                                  imageUrl: postDetailsController
                                          .motelPost.value.user?.avatarImage ??
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
                                      postDetailsController
                                              .motelPost.value.user?.name ??
                                          "",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${postDetailsController.motelPost.value.user?.totalPost ?? "0"} Bài đăng",
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
                              if ((postDetailsController
                                              .motelPost.value.hasWc ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasWc ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasMezzanine ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasMezzanine ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasBalcony ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasBalcony ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasFingerprint ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController.motelRoomChoose.value
                                          .hasFingerprint ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasOwnOwner ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasOwnOwner ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasPet ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasPet ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                              if ((postDetailsController.motelPost.value
                                              .hasAirConditioner ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController.motelRoomChoose.value
                                          .hasAirConditioner ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasWaterHeater ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController.motelRoomChoose.value
                                          .hasWaterHeater ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasKitchen ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasKitchen ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasFridge ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasFridge ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasBed ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasBed ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController.motelPost.value
                                              .hasWashingMachine ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController.motelRoomChoose.value
                                          .hasWashingMachine ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController.motelPost.value
                                              .hasKitchenStuff ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController.motelRoomChoose.value
                                          .hasKitchenStuff ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasTable ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasTable ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController.motelPost.value
                                              .hasDecorativeLights ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController.motelRoomChoose.value
                                          .hasDecorativeLights ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasPicture ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasPicture ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasTree ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasTree ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasPillow ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasPillow ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasWardrobe ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasWardrobe ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasMattress ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasMattress ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasShoesRacks ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController.motelRoomChoose.value
                                          .hasShoesRacks ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasCurtain ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasCurtain ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasCeilingFans ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController.motelRoomChoose.value
                                          .hasCeilingFans ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasMirror ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasMirror ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  ),
                                ),
                              if ((postDetailsController
                                              .motelPost.value.hasSofa ==
                                          true &&
                                      postDetailsController
                                              .motelRoomChoose.value.id ==
                                          null) ||
                                  postDetailsController
                                          .motelRoomChoose.value.hasSofa ==
                                      true)
                                SizedBox(
                                  width: (Get.width - 30) / 4,
                                  height: (Get.width - 30) / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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

  Widget itemRoom(
    MotelRoom motelRoom,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (motelRoom.isHidden == 0) {
            postDetailsController.motelRoomChoose.value = motelRoom;
          }
        },
        child: Stack(
          children: [
            Container(
              width: Get.width / 3 - 26,
              decoration: BoxDecoration(
                border: Border.all(
                    color: motelRoom.id ==
                            postDetailsController.motelRoomChoose.value.id
                        ? Theme.of(Get.context!).primaryColor
                        : Colors.grey[200]!),
                color: motelRoom.isHidden == 0
                    ? Colors.grey.withOpacity(0.1)
                    : motelRoom.id ==
                    postDetailsController.motelRoomChoose.value.id
                    ? Colors.white
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                boxShadow: motelRoom.id ==
                        postDetailsController.motelRoomChoose.value.id
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
            if (motelRoom.id == postDetailsController.motelRoomChoose.value.id)
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
}
