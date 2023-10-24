import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/motel_post.dart';

import 'package:gohomy/screen/admin/potential_user/potential_detail/potential_detail_controller.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/appbar/saha_appbar.dart';
import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/widget/post_item/post_item.dart';
import '../../../../model/potential_user.dart';
import '../../../../model/user.dart';
import '../../../../utils/call.dart';
import '../../../chat/chat_detail/chat_detail_screen.dart';
import '../../../find_room/room_information/room_information_screen.dart';
import '../../../owner/contract/add_contract/add_contract_screen.dart';
import '../../../profile/bill/bill_details/bill_details_screen.dart';
import '../add_renter/add_renter_screen.dart';

class PotentialDetailScreen extends StatelessWidget {
  PotentialDetailScreen(
      {super.key,
      required this.idPotential,
      required this.userGuestId,
      this.statusPotential}) {
    controller = PotentialDetailController(
        idPotential: idPotential, userGuestId: userGuestId);
  }

  final int idPotential;
  final int userGuestId;
  late PotentialDetailController controller;
  int? statusPotential;
  ScrollController billScrollController = ScrollController();
  ScrollController contractScrollController = ScrollController();

  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: statusPotential == 2
              ? "Khách đã từng thuê"
              : 'Khách hàng tiềm năng',
          actions: [
            Obx(() => controller.potentialUser.value.status == 2
                ? IconButton(
                    onPressed: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: "Bạn có thực sự muốn xoá người này",
                          onOK: () {
                            controller.deletePotentialUser();
                          });
                    },
                    icon: const Icon(Icons.delete_outline))
                : const SizedBox())
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
                        padding: const EdgeInsets.only(top: 16),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        child: CachedNetworkImage(
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                          imageUrl: controller
                                                  .potentialUser
                                                  .value
                                                  .userGuest
                                                  ?.avatarImage ??
                                              '',
                                          // placeholder: (context, url) =>
                                          //     SahaLoadingWidget(),
                                          errorWidget: (context, url, error) =>
                                              const SahaEmptyAvata(
                                            height: 100,
                                            width: 100,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Call.call(controller.potentialUser.value
                                              .userGuest?.phoneNumber ??
                                          '');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Row(children: const [
                                        Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Gọi',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ]),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => ChatDetailScreen(
                                            toUser: controller.potentialUser
                                                    .value.userGuest ??
                                                User(),
                                          ));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Row(children: const [
                                        Icon(
                                          Icons.chat_outlined,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'SMS',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      item(
                          icon: const Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                          ),
                          title:
                              controller.potentialUser.value.userGuest?.name ??
                                  'Chưa có thông tin',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      item(
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        title: controller
                                .potentialUser.value.userGuest?.phoneNumber ??
                            'Chưa có thông tin',
                        isDidKyc: controller
                                .potentialUser.value.userGuest?.cmndNumber !=
                            null,
                      ),
                      item(
                          icon: const Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          title:
                              controller.potentialUser.value.userGuest?.email ??
                                  'Chưa có thông tin'),
                      const SizedBox(
                        height: 10,
                      ),
                      if (controller.potentialUser.value.status != 2)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((controller
                                        .potentialUser.value.listPostFavorite ??
                                    [])
                                .isNotEmpty)
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Bài đăng quan tâm",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    height: 300,
                                    padding: EdgeInsets.all(10),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      addAutomaticKeepAlives: false,
                                      addRepaintBoundaries: false,
                                      itemCount: (controller.potentialUser.value
                                                  .listPostFavorite ??
                                              [])
                                          .length,
                                      itemBuilder: (context, index) {
                                        return PostItem(
                                          post: (controller.potentialUser.value
                                                          .listPostFavorite ??
                                                      [])[index]
                                                  .moPost ??
                                              MotelPost(),
                                          width: Get.width * 0.5 - 10,
                                          height: 300,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              width: Get.width,
                              padding: const EdgeInsets.all(9),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                tilePadding: EdgeInsets.all(0),
                                title: Text(
                                  'Lịch sử tương tác',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                children: [
                                  Obx(
                                    () => controller.loadInitHistory.value
                                        ? SahaLoadingFullScreen()
                                        : controller.listHistory.isEmpty
                                            ? const Center(
                                                child: Text('Chưa có lịch sử'),
                                              )
                                            : Column(
                                                children: [
                                                  ...controller.listHistory
                                                      .map((element) =>
                                                          itemHistory(element))
                                                      .toList(),
                                                  if (controller
                                                      .isEndList.value = false)
                                                    TextButton(
                                                        onPressed: () {
                                                          controller
                                                              .getAllHistoryPotential();
                                                        },
                                                        child: const Text(
                                                            'Xem thêm'))
                                                ],
                                              ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      if (controller.potentialUser.value.status == 2)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              itemMotel(
                                  title: "Tên toà nhà",
                                  subTitle:
                                      controller.potentialUser.value.status == 2
                                          ? ((controller.potentialUser.value
                                                          .listContract ??
                                                      [])
                                                  .isNotEmpty
                                              ? controller
                                                      .potentialUser
                                                      .value
                                                      .listContract![0]
                                                      .tower
                                                      ?.towerName ??
                                                  ""
                                              : "")
                                          : controller.potentialUser.value
                                                  .nameTower ??
                                              "Chưa có thông tin"),
                              itemMotel(
                                  title: "Số/tên phòng",
                                  subTitle:
                                      controller.potentialUser.value.status == 2
                                          ? ((controller.potentialUser.value
                                                          .listContract ??
                                                      [])
                                                  .isNotEmpty
                                              ? controller
                                                      .potentialUser
                                                      .value
                                                      .listContract![0]
                                                      .motelRoom
                                                      ?.motelName ??
                                                  ""
                                              : "")
                                          : controller.potentialUser.value
                                                  .nameMotel ??
                                              "Chưa có thông tin"),
                              Text(
                                'Hoá đơn : ${(controller.potentialUser.value.listBill ?? []).length}',
                                style: const TextStyle(color: Colors.blue),
                              ),
                              if ((controller.potentialUser.value.listBill ??
                                      [])
                                  .isNotEmpty)
                                Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: RawScrollbar(
                                    controller: billScrollController,
                                    thumbVisibility: true,
                                    thumbColor: Colors.deepOrange,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ...(controller.potentialUser.value
                                                      .listBill ??
                                                  [])
                                              .map((e) => InkWell(
                                                    onTap: () {
                                                      Get.to(() => BillDetails(
                                                            billId: e.id!,
                                                          ));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.circle,
                                                          color: Colors.black,
                                                          size: 5,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                              "Tháng ${e.content}: ${SahaStringUtils().convertToUnit(e.totalFinal)}đ"),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Hợp đồng : ${(controller.potentialUser.value.listContract ?? []).length}',
                                style: const TextStyle(color: Colors.blue),
                              ),
                              if ((controller
                                          .potentialUser.value.listContract ??
                                      [])
                                  .isNotEmpty)
                                Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: RawScrollbar(
                                    controller: contractScrollController,
                                    thumbVisibility: true,
                                    thumbColor: Colors.deepOrange,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ...(controller.potentialUser.value
                                                      .listContract ??
                                                  [])
                                              .map((e) => InkWell(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          AddContractScreen(
                                                            contractId: e.id,
                                                          ));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.circle,
                                                          color: Colors.blue,
                                                          size: 5,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "Hợp đồng thuê ${e.motelRoom?.motelName ?? 'Chưa có thông tin'} ${DateFormat('dd-MM-yyyy').format(e.rentFrom ?? DateTime.now())} ${DateFormat('dd-MM-yyyy').format(e.rentTo ?? DateTime.now())}",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
        ),
        bottomNavigationBar: Obx(
          () => controller.loadInit.value
              ? const SizedBox()
              : SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      SizedBox(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (controller.potentialUser.value.status == 0)
                              InkWell(
                                onTap: () {
                                  controller.updatePotentialUser(
                                    status: 4,
                                  );
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: const Icon(
                                        Icons.check,
                                        size: 20,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Đang tư vấn',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ]),
                                ),
                              ),
                            if (controller.potentialUser.value.status != 0)
                              InkWell(
                                onTap: () {
                                  Get.to(() => AddRenterPotentialScreen(
                                        userPotential:
                                            controller.potentialUser.value,
                                        isFromDetailScreen: true,
                                      ));
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: const Icon(
                                        Icons.check,
                                        size: 20,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      controller.potentialUser.value.status == 2
                                          ? "Thuê lại"
                                          : 'Đồng ý',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ]),
                                ),
                              ),
                            if (controller.potentialUser.value.status == 4 ||
                                controller.potentialUser.value.status == 0)
                              InkWell(
                                onTap: () {
                                  controller.updatePotentialUser(
                                    status: 1,
                                  );
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: const Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Từ chối',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ]),
                                ),
                              ),
                            if (controller.potentialUser.value.status == 1 ||
                                controller.potentialUser.value.status == 2)
                              InkWell(
                                onTap: () {
                                  controller.deletePotentialUser();
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(children: [
                                    Image.asset(
                                      'assets/icon_host/xoa.png',
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      'Xoá',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ]),
                                ),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget item(
      {required Widget icon,
      required String title,
      TextStyle? style,
      bool? isDidKyc}) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Row(
                  children: [
                    Text(
                      title,
                      style: style,
                    ),
                    const SizedBox(width: 5),
                    if (isDidKyc == true)
                      const Icon(Icons.check_circle, color: Colors.blueAccent)
            ],
          )),
        ],
      ),
    );
  }

  Widget itemHistory(HistoryUserPotential historyUserPotential) {
    return SizedBox(
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            color: Colors.black,
            size: 5,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                text:
                    '${DateFormat('dd-MM-yyyy').format(historyUserPotential.createdAt ?? DateTime.now())} ',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: historyUserPotential.typeFrom == TYPE_FROM_LIKE
                          ? "Yêu thích từ "
                          : historyUserPotential.typeFrom ==
                                  TYPE_FROM_RESERVATION
                              ? "Giữ chỗ từ "
                              : historyUserPotential.typeFrom ==
                                      TYPE_FROM_SENT_MESSAGE
                                  ? 'Gửi tin từ '
                                  : historyUserPotential.typeFrom ==
                                          TYPE_FROM_CALL
                                      ? "Gọi điện từ "
                                      : "Xem bài đăng ",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: historyUserPotential.title ??
                        'Chưa có thông tin Chưa có thông tin Chưa có thông tin',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(() => RoomInformationScreen(
                              roomPostId: historyUserPotential.valueReference,
                            ));
                      },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget itemMotel({required String title, required String subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 8,
        ),
        Text(subTitle),
        const Divider()
      ],
    );
  }
}
