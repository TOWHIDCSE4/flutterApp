import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/motel_room.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/appbar/saha_appbar.dart';
import '../../../components/button/saha_button.dart';
import '../../../components/empty/saha_empty_image.dart';
import '../../../components/loading/loading_widget.dart';
import '../../../components/text_field/saha_text_field_search.dart';
import '../../../const/color.dart';
import '../../../const/motel_type.dart';
import '../../../model/tower.dart';
import '../../../utils/debounce.dart';
import '../../../utils/string_utils.dart';
import '../motel_room/add_motel_room/add_motel_room_screen.dart';
import 'choose_room_controller.dart';

class ChooseRoomScreen extends StatelessWidget {
  List<MotelRoom>? listMotelInput;
  bool? hasContract;
  bool? hasPost;
  Function onChoose;
  bool? isUser;
  bool? isChooseFromBill;
  bool? isFromChooseRoom;
  bool? isTower;
  int? towerId;
  Tower? tower;
  bool? isFromPost;
  bool? isSupporter;
  ChooseRoomScreen(
      {this.listMotelInput,
      required this.onChoose,
      this.hasContract,
      this.isUser,
      this.hasPost,
      this.isChooseFromBill,
      this.isFromChooseRoom,
      this.isTower,
      this.towerId,
      this.tower,
      this.isFromPost,this.isSupporter}) {
    chooseRoomController = ChooseRoomController(
        hasPost: hasPost,
        listMotelInput: listMotelInput,
        hasContract: hasContract,
        isUser: isUser,
        towerId: towerId,
        isTower: isTower,isSupporter: isSupporter);
  }

  late ChooseRoomController chooseRoomController;
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SahaAppBar(
          titleText: 'Phòng đơn',
        ),
        body: Column(
          children: [
                SahaTextFieldSearch(
              hintText: "Tìm kiếm phòng trọ",
              onChanged: (va) {
                EasyDebounce.debounce(
                    'list_motel_room', const Duration(milliseconds: 300), () {
                 chooseRoomController.textSearch = va;
                  chooseRoomController
                      .getAllMotelRoom(isRefresh: true);
                });
              },
              onClose: () {
               chooseRoomController.textSearch = "";
               chooseRoomController
                    .getAllMotelRoom(isRefresh: true);
              },
            ),
            Expanded(
              child: Obx(
                () => chooseRoomController.loadInit.value
                    ? SahaLoadingFullScreen()
                    : SmartRefresher(
                        footer: CustomFooter(
                          builder: (
                            BuildContext context,
                            LoadStatus? mode,
                          ) {
                            Widget body = Container();
                            if (mode == LoadStatus.idle) {
                              body = Obx(() => chooseRoomController.isLoading.value
                                  ? const CupertinoActivityIndicator()
                                  : Container());
                            } else if (mode == LoadStatus.loading) {
                              body = const CupertinoActivityIndicator();
                            }
                            return SizedBox(
                              height: 100,
                              child: Center(child: body),
                            );
                          },
                        ),
                        enablePullDown: true,
                        enablePullUp: true,
                        header: const MaterialClassicHeader(),
                        onRefresh: () async {
                          await chooseRoomController.getAllMotelRoom(isRefresh: true);
                          refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await chooseRoomController.getAllMotelRoom();
                          refreshController.loadComplete();
                        },
                        controller: refreshController,
                        child: SingleChildScrollView(
                          child: Column(
                            children: chooseRoomController.listMotelRoom
                                .map((e) => itemRenter(e))
                                .toList(),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                text: "Xác nhận",
                onPressed: () {
                  if (chooseRoomController.listMotelRoomSelected.isNotEmpty) {
                    var index = chooseRoomController.listMotelRoom.indexWhere((e) => e.id == chooseRoomController.listMotelRoomSelected[0].id,);
                 
                    chooseRoomController.listMotelRoomSelected[0] = chooseRoomController.listMotelRoom[index];
                    onChoose(chooseRoomController.listMotelRoomSelected);
                    Get.back();
                    if (isFromPost == true) {
                      Get.back();
                    }
                  } else {
                    SahaAlert.showError(message: "Bạn chưa chọn phòng nào");
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: isChooseFromBill == null && isUser != true
            ? SizedBox(
                height: Get.height / 7,
                width: Get.width,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (chooseRoomController.listMotelRoom.isEmpty)
                            CustomPaint(
                              painter: TooltipCustomPainter(),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(8, 8, 8, 15),
                                child: Text(
                                  'Thêm phòng ngay!',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          FloatingActionButton(
                              tooltip: 'Thêm phòng mới',
                              backgroundColor: primaryColor,
                              child: const Icon(Icons.add),
                              onPressed: () {
                                Get.to(() => AddMotelRoomScreen(
                                          isHaveTower: isTower,
                                          towerInput: tower,
                                        ))!
                                    .then((value) => chooseRoomController
                                        .getAllMotelRoom(isRefresh: true));
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox());
  }

  Widget itemRenter(MotelRoom motelRoom) {
    return InkWell(
      onTap: () {
        if (isUser != true) {
          Get.to(() => AddMotelRoomScreen(
                  motelRoomInput: motelRoom,
                  isFromChooseRoom: isFromChooseRoom))!
              .then((value) =>
                  chooseRoomController.getAllMotelRoom(isRefresh: true));
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            //padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    ((motelRoom.images ?? []).isNotEmpty
                            ? motelRoom.images![0]
                            : "") +
                        "?reduce_file=true",
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    // imageUrl:
                    //     (post.images ?? []).isNotEmpty ? post.images![0] : "",
                    //placeholder: (context, url) => const SahaLoadingContainer(),
                    errorBuilder: (context, url, error) => const SahaEmptyImage(
                      height: 120,
                      width: 130,
                    ),
                  ),
                ),
                // Positioned.fill(
                //     child: Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       gradient: LinearGradient(
                //         begin: Alignment.bottomCenter,
                //         end: Alignment.topCenter,
                //         stops: const [
                //           0.19,
                //           0.5,
                //         ],
                //         colors: [
                //           Colors.black.withOpacity(0.35),
                //           Colors.transparent,
                //         ],
                //       )),
                // )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        (motelRoom.motelName ?? "").toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 15,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            letterSpacing: 0.1,
                            color: Theme.of(Get.context!).primaryColor),
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.border_style_outlined,
                                color: Colors.grey,
                                size: 14,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                '${motelRoom.area} m2',
                                style: const TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 14,
                              ),
                              Text(
                                '${motelRoom.capacity ?? 0}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          if (motelRoom.sex == 0)
                            const Text(
                              "Nam / Nữ",
                              style: TextStyle(color: Colors.grey),
                            ),
                          if (motelRoom.sex == 1)
                            const Text(
                              'Nam',
                              style: TextStyle(color: Colors.grey),
                            ),
                          if (motelRoom.sex == 2)
                            const Text(
                              'Nữ',
                              style: TextStyle(color: Colors.grey),
                            ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Icon(
                              FontAwesomeIcons.dollarSign,
                              color: Theme.of(Get.context!).primaryColor,
                              size: 14,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            '${SahaStringUtils().convertToMoney(motelRoom.money ?? 0)} VNĐ/${typeUnitRoom[motelRoom.type ?? 0]}',
                            style: TextStyle(
                                color: Theme.of(Get.context!).primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            child: Text(
                              '${motelRoom.addressDetail ?? ""}${motelRoom.addressDetail == null ? "" : ", "}${motelRoom.wardsName ?? ""}${motelRoom.wardsName != null ? ", " : ""}${motelRoom.districtName ?? ""}${motelRoom.districtName != null ? ", " : ""}${motelRoom.provinceName ?? ""}',
                              maxLines: 2,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                height: 1.2,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Row(
            //   children: [
            //     ClipRRect(
            //       borderRadius: BorderRadius.circular(5.0),
            //       child: CachedNetworkImage(
            //         height: 100,
            //         width: 100,
            //         fit: BoxFit.cover,
            //         imageUrl: (motelRoom.images ?? []).isEmpty
            //             ? ""
            //             : motelRoom.images![0],
            //         //placeholder: (context, url) => SahaLoadingWidget(),
            //         errorWidget: (context, url, error) => const SahaEmptyImage(),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Expanded(
            //                 child: Text(
            //                   motelRoom.motelName ?? "",
            //                   maxLines: 2,
            //                   textAlign: TextAlign.center,
            //                   style: const TextStyle(
            //                     overflow: TextOverflow.ellipsis,
            //                     fontWeight: FontWeight.w500,
            //                   ),
            //                 ),
            //               ),
            //               const SizedBox(
            //                 width: 10,
            //               ),
            //               Text(
            //                 "${SahaStringUtils().convertToMoney(motelRoom.money ?? "0")}đ",
            //                 textAlign: TextAlign.center,
            //                 maxLines: 2,
            //                 style: TextStyle(
            //                   overflow: TextOverflow.ellipsis,
            //                   color: Theme.of(Get.context!).primaryColor,
            //                 ),
            //               ),
            //             ],
            //           ),
            //           const SizedBox(
            //             height: 10,
            //           ),
            //           Text(
            //             '${typeRoom[motelRoom.type]}',
            //             maxLines: 2,
            //             style: const TextStyle(
            //               fontSize: 12,
            //             ),
            //           ),
            //           const SizedBox(
            //             height: 10,
            //           ),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Row(
            //                 children: [
            //                   const Icon(
            //                     FontAwesomeIcons.peopleRoof,
            //                     color: Color(0xFF00B894),
            //                     size: 18,
            //                   ),
            //                   const SizedBox(
            //                     width: 10,
            //                   ),
            //                   Text(
            //                     motelRoom.capacity == null
            //                         ? "0"
            //                         : "${motelRoom.capacity}",
            //                   ),
            //                 ],
            //               ),
            //               Row(
            //                 children: [
            //                   Icon(
            //                     motelRoom.sex == 0
            //                         ? FontAwesomeIcons.marsAndVenus
            //                         : motelRoom.sex == 1
            //                             ? FontAwesomeIcons.mars
            //                             : FontAwesomeIcons.venus,
            //                     size: 20,
            //                     color: motelRoom.sex == 0
            //                         ? const Color(0xFFBDC3C7)
            //                         : motelRoom.sex == 1
            //                             ? const Color(0xFF2980B9)
            //                             : const Color(0xFFE84393),
            //                   ),
            //                   const SizedBox(
            //                     width: 5,
            //                   ),
            //                   Text(
            //                     motelRoom.sex == 0
            //                         ? "Nam, Nữ"
            //                         : motelRoom.sex == 1
            //                             ? "Nam"
            //                             : "Nữ",
            //                   )
            //                 ],
            //               ),
            //               Row(
            //                 children: [
            //                   const Icon(
            //                     Icons.photo_size_select_small_rounded,
            //                     size: 20,
            //                     color: Color(0xFFFF7675),
            //                   ),
            //                   const SizedBox(
            //                     width: 5,
            //                   ),
            //                   Text(
            //                     "${motelRoom.area}m²",
            //                   )
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //     Checkbox(
            //         value: chooseRoomController.listMotelRoomSelected
            //             .map((e) => e.id)
            //             .toList()
            //             .contains(motelRoom.id),
            //         onChanged: (v) {
            //           chooseRoomController.listMotelRoomSelected([]);
            //           chooseRoomController.listMotelRoomSelected.add(motelRoom);
            //         })
            //   ],
            // ),
          ),
          Positioned(
              right: 10,
              child: Checkbox(
                  side: BorderSide(
                    color: Theme.of(Get.context!).primaryColor,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  value: chooseRoomController.listMotelRoomSelected
                      .map((e) => e.id)
                      .toList()
                      .contains(motelRoom.id),
                  onChanged: (v) {
                    chooseRoomController.listMotelRoomSelected([]);
                    chooseRoomController.listMotelRoomSelected.add(motelRoom);
                  }))
        ],
      ),
    );
  }
}

class TooltipCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 245, 210, 244)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0019167, 0);
    path0.quadraticBezierTo(size.width * -0.1197667, size.height * 0.3568500, 0,
        size.height * 0.7550000);
    path0.lineTo(size.width * 0.5850000, size.height * 0.7550000);
    path0.lineTo(size.width * 0.6683333, size.height * 0.8725000);
    path0.lineTo(size.width * 0.7450000, size.height * 0.7525000);
    path0.lineTo(size.width * 0.9950000, size.height * 0.7500000);
    path0.quadraticBezierTo(size.width * 1.1203500, size.height * 0.4254750,
        size.width * 0.9982000, 0);
    path0.cubicTo(size.width * 0.7491292, 0, size.width * 0.7491292, 0,
        size.width * 0.0019167, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
