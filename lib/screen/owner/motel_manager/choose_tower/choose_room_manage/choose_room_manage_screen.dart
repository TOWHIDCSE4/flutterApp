import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/text_field/rice_text_field.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../components/appbar/saha_appbar.dart';
import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../components/button/saha_button.dart';
import '../../../../../components/empty/saha_empty_image.dart';
import '../../../../../components/loading/loading_full_screen.dart';
import '../../../../../components/text_field/saha_text_field_search.dart';
import '../../../../../const/color.dart';
import '../../../../../const/motel_type.dart';
import '../../../../../model/motel_room.dart';
import '../../../../../model/tower.dart';
import '../../../../../utils/debounce.dart';
import '../../../../../utils/string_utils.dart';
import 'choose_room_manage_controller.dart';

class ChooseRoomManageScreen extends StatelessWidget {
  List<MotelRoom>? listMotelInput;

  Function onChoose;

  int towerId;
  Tower tower;
  bool isAdd;
  int? supportId;
  ChooseRoomManageScreen({
    this.listMotelInput,
    this.supportId,
    required this.isAdd,
    required this.onChoose,
    required this.tower,
    required this.towerId,
  }) {
    controller = ChooseRoomManageController(
      listMotelInput: listMotelInput,
      towerId: towerId,
      isAdd: isAdd,
      supportId: supportId
    );
  }

  late ChooseRoomManageController controller;
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: 'Phòng đơn',
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Stack(
                        children: [
                          Center(
                            child: Text(
                              'Lọc',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Positioned(
                              top: -5,
                              left: -5,
                              child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(Icons.clear)))
                        ],
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Khoảng tầng"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
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
                                  child: RiceTextField(
                                    controller: controller.floorFromEdit,
                                    onChanged: (v) {
                                      controller.floorFrom = int.tryParse(v!);
                                    },
                                    hintText: "Từ",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("-"),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
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
                                  child: RiceTextField(
                                    controller: controller.floorToEdit,
                                    onChanged: (v) {
                                      controller.floorTo = int.tryParse(v!);
                                    },
                                    hintText: "Đến",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if(controller.floorFrom == null){
                                SahaAlert.showError(message: "Chưa chọn số tầng bắt đầu");
                                return;
                              }
                               if(controller.floorTo == null){
                                SahaAlert.showError(message: "Chưa chọn số tầng kết thúc");
                                return;
                              }
                              controller.getAllMotelSupport(isRefresh: true);
                              Get.back();

                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                  child: Text(
                                'Xác nhận',
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.filter_alt))
        ],
      ),
      body: Column(
        children: [
          SahaTextFieldSearch(
            hintText: "Tìm kiếm phòng trọ",
            onChanged: (va) {
              EasyDebounce.debounce(
                  'list_motel_room', const Duration(milliseconds: 300), () {
                controller.textSearch = va;
                controller.getAllMotelSupport(isRefresh: true);
              });
            },
            onClose: () {
              controller.textSearch = "";
              controller.getAllMotelSupport(isRefresh: true);
            },
          ),
          Row(
            children: [
              Obx(
                () => Checkbox(
                    side: BorderSide(
                      color: Theme.of(Get.context!).primaryColor,
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    value: controller.isAll.value,
                    onChanged: (v) {
                      controller.isAll.value = !controller.isAll.value;
                      if (v == true) {
                        controller.listMotelRoomSelected.value = [];
                        controller.listMotelRoomSelected
                            .addAll(controller.listMotelRoom);
                      } else {
                        controller.listMotelRoomSelected.value = [];
                      }
                    }),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Chọn tất cả",
                style: TextStyle(color: Theme.of(context).primaryColor),
              )
            ],
          ),
          Expanded(
            child: Obx(
              () => controller.loadInit.value
                  ? SahaLoadingFullScreen()
                  : SmartRefresher(
                      footer: CustomFooter(
                        builder: (
                          BuildContext context,
                          LoadStatus? mode,
                        ) {
                          Widget body = Container();
                          if (mode == LoadStatus.idle) {
                            body = Obx(() => controller.isLoading.value
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
                        await controller.getAllMotelSupport(isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await controller.getAllMotelSupport();
                        refreshController.loadComplete();
                      },
                      controller: refreshController,
                      child: SingleChildScrollView(
                        child: Column(
                          children: controller.listMotelRoom
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
                onChoose(
                    towerId, tower.towerName, controller.listMotelRoomSelected);
                Get.back();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemRenter(MotelRoom motelRoom) {
    return Stack(
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
                value: controller.listMotelRoomSelected
                    .map((e) => e.id)
                    .toList()
                    .contains(motelRoom.id),
                onChanged: (v) {
                  if (v == true) {
                    controller.listMotelRoomSelected.add(motelRoom);
                  } else {
                    controller.listMotelRoomSelected
                        .removeWhere((e) => e.id == motelRoom.id);
                  }
                }))
      ],
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
