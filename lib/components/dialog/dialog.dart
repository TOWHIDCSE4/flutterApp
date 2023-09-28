import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/button/saha_button.dart';
import 'package:gohomy/const/const_service.dart';
import 'package:gohomy/data/remote/response-request/manage/motel_post_req.dart';
import 'package:gohomy/screen/home/home_controller.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../const/const_payment_term.dart';
import '../../const/motel_type.dart';
import '../../data/remote/response-request/manage/post_find_room_filter.dart';
import '../../data/remote/response-request/manage/post_roommate_filter.dart';
import '../../data/repository/repository_manager.dart';
import '../../model/admin_discover.dart';
import '../../model/location_address.dart';
import '../arlert/saha_alert.dart';
import '../loading/loading_full_screen.dart';
import 'package:gallery_saver/gallery_saver.dart';

class SahaDialogApp {
  static void showFilterPostRoommate(
      {required PostRoommateFilter motelPostReqInput,
      required Function onAccept}) {
    var motelPost = PostRoommateFilter().obs;

    var rangePriceValue = const RangeValues(0, 20000000).obs;
    rangePriceValue.value = RangeValues(motelPostReqInput.fromMoney ?? 0,
        motelPostReqInput.maxMoney ?? 20000000);
    motelPost(motelPostReqInput);
    motelPost.value.listType ??= [];
    Widget itemService(
        {required bool value,
        required String tile,
        required Function onCheck}) {
      return InkWell(
        onTap: () {
          onCheck();
          motelPost.refresh();
        },
        child: Stack(
          children: [
            Container(
              width: (Get.width - 40) / 2,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: value
                          ? Theme.of(Get.context!).primaryColor
                          : Colors.grey[200]!)),
              child: Center(
                child: Text(
                  tile,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color:
                          value ? Theme.of(Get.context!).primaryColor : null),
                ),
              ),
            ),
            if (value == true)
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
      );
    }

    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.grey[200],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        isScrollControlled: true,
        builder: (context) {
          return Stack(
            children: [
              SizedBox(
                height: Get.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: 50,
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(Icons.clear)),
                          const Text(
                            "Lọc kết quả",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                motelPost.value =
                                    PostRoommateFilter(listType: []);
                              },
                              child: const Text('Bỏ lọc'))
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => Text(
                                            'Giá từ ${SahaStringUtils().convertToMoney(rangePriceValue.value.start.round().toString())}đ đến ${SahaStringUtils().convertToMoney(rangePriceValue.value.end.round().toString())}đ'),
                                      ),
                                      Obx(
                                        () => RangeSlider(
                                            values: rangePriceValue.value,
                                            max: 20000000,
                                            divisions: 40,
                                            onChanged: (RangeValues v) {
                                              rangePriceValue.value = v;
                                            }),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'SẮP XẾP THEO',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time_rounded),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text('Tin mới'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                          value: motelPost.value
                                                                  .sortBy ==
                                                              'created_at',
                                                          onChanged: (v) {
                                                            if (motelPost.value
                                                                    .sortBy ==
                                                                'created_at') {
                                                              motelPost.value
                                                                  .sortBy = '';
                                                              motelPost.value
                                                                      .descending =
                                                                  true;
                                                            } else {
                                                              motelPost.value
                                                                      .sortBy =
                                                                  'created_at';
                                                              motelPost.value
                                                                      .descending =
                                                                  true;
                                                            }

                                                            motelPost.refresh();
                                                          }),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.arrow_circle_up_rounded),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                            'Giá cao nhất'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                          value: motelPost.value
                                                                      .sortBy ==
                                                                  'money' &&
                                                              motelPost.value
                                                                      .descending ==
                                                                  true,
                                                          onChanged: (v) {
                                                            if (motelPost.value
                                                                    .sortBy ==
                                                                'money') {
                                                              motelPost.value
                                                                  .sortBy = '';
                                                              motelPost.value
                                                                      .descending =
                                                                  true;
                                                            } else {
                                                              motelPost.value
                                                                      .sortBy =
                                                                  'money';
                                                              motelPost.value
                                                                      .descending =
                                                                  true;
                                                            }

                                                            motelPost.refresh();
                                                          }),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.arrow_circle_down_rounded),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                            'Giá thấp nhất'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                          value: motelPost.value
                                                                      .sortBy ==
                                                                  'money' &&
                                                              motelPost.value
                                                                      .descending ==
                                                                  false,
                                                          onChanged: (v) {
                                                            if (motelPost.value
                                                                    .sortBy ==
                                                                'money') {
                                                              motelPost.value
                                                                  .sortBy = '';
                                                              motelPost.value
                                                                      .descending =
                                                                  false;
                                                            } else {
                                                              motelPost.value
                                                                      .sortBy =
                                                                  'money';
                                                              motelPost.value
                                                                      .descending =
                                                                  false;
                                                            }

                                                            motelPost.refresh();
                                                          }),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'LOẠI PHÒNG',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child:
                                                            Text('Trọ thường'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(MOTEL),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(
                                                                  MOTEL)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere(
                                                                    (e) =>
                                                                        e ==
                                                                        MOTEL);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(MOTEL);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child:
                                                            Text('Nguyên căn'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(
                                                                MOTEL_COMPOUND),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(
                                                                  MOTEL_COMPOUND)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere((e) =>
                                                                    e ==
                                                                    MOTEL_COMPOUND);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(
                                                                    MOTEL_COMPOUND);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text('HomeStay'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(HOMESTAY),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(
                                                                  HOMESTAY)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere(
                                                                    (e) =>
                                                                        e ==
                                                                        HOMESTAY);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(HOMESTAY);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text('Chung cư'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(HOME),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(HOME)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere(
                                                                    (e) =>
                                                                        e ==
                                                                        HOME);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(HOME);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                            'Chưng cư mini'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(VILLA),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(
                                                                  VILLA)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere(
                                                                    (e) =>
                                                                        e ==
                                                                        VILLA);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(VILLA);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'TIỆN NGHI',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 10, bottom: 10),
                                  child: Obx(
                                    () => Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: [
                                        itemService(
                                            value:
                                                motelPost.value.hasWc ?? false,
                                            tile: "Vệ sinh khép kín",
                                            onCheck: () {
                                              motelPost.value.hasWc =
                                                  !(motelPost.value.hasWc ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasMezzanine ??
                                                    false,
                                            tile: "Gác xép",
                                            onCheck: () {
                                              motelPost.value.hasMezzanine =
                                                  !(motelPost
                                                          .value.hasMezzanine ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasBalcony ??
                                                false,
                                            tile: "Ban công",
                                            onCheck: () {
                                              motelPost.value.hasBalcony =
                                                  !(motelPost
                                                          .value.hasBalcony ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasFingerprint ??
                                                false,
                                            tile: "Ra vào vân tay",
                                            onCheck: () {
                                              motelPost.value.hasFingerprint =
                                                  !(motelPost.value
                                                          .hasFingerprint ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasOwnOwner ??
                                                    false,
                                            tile: "Không chung chủ",
                                            onCheck: () {
                                              motelPost.value.hasOwnOwner =
                                                  !(motelPost
                                                          .value.hasOwnOwner ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasPet ?? false,
                                            tile: "Nuôi Pet",
                                            onCheck: () {
                                              motelPost.value.hasPet =
                                                  !(motelPost.value.hasPet ??
                                                      false);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'NỘI THẤT',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 10, bottom: 10),
                                  child: Obx(
                                    () => Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: [
                                        itemService(
                                            value: motelPost
                                                    .value.hasAirConditioner ??
                                                false,
                                            tile: "Điều hoà",
                                            onCheck: () {
                                              motelPost
                                                      .value.hasAirConditioner =
                                                  !(motelPost.value
                                                          .hasAirConditioner ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasWaterHeater ??
                                                false,
                                            tile: "Nóng lạnh",
                                            onCheck: () {
                                              motelPost.value.hasWaterHeater =
                                                  !(motelPost.value
                                                          .hasWaterHeater ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasKitchen ??
                                                false,
                                            tile: "Kệ bếp",
                                            onCheck: () {
                                              motelPost.value.hasKitchen =
                                                  !(motelPost
                                                          .value.hasKitchen ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasFridge ??
                                                false,
                                            tile: "Tủ lạnh",
                                            onCheck: () {
                                              motelPost.value.hasFridge =
                                                  !(motelPost.value.hasFridge ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasBed ?? false,
                                            tile: "Giường ngủ",
                                            onCheck: () {
                                              motelPost.value.hasBed =
                                                  !(motelPost.value.hasBed ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasWashingMachine ??
                                                false,
                                            tile: "Máy giặt",
                                            onCheck: () {
                                              motelPost
                                                      .value.hasWashingMachine =
                                                  !(motelPost.value
                                                          .hasWashingMachine ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasKitchenStuff ??
                                                false,
                                            tile: "Đồ dùng bếp",
                                            onCheck: () {
                                              motelPost.value.hasKitchenStuff =
                                                  !(motelPost.value
                                                          .hasKitchenStuff ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasTable ??
                                                false,
                                            tile: "Bàn ghế",
                                            onCheck: () {
                                              motelPost.value.hasTable =
                                                  !(motelPost.value.hasTable ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value
                                                    .hasDecorativeLights ??
                                                false,
                                            tile: "Đèn trang trí",
                                            onCheck: () {
                                              motelPost.value
                                                      .hasDecorativeLights =
                                                  !(motelPost.value
                                                          .hasDecorativeLights ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasPicture ??
                                                false,
                                            tile: "Tranh trang trí",
                                            onCheck: () {
                                              motelPost.value.hasPicture =
                                                  !(motelPost
                                                          .value.hasPicture ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasTree ??
                                                false,
                                            tile: "Cây cối trang trí",
                                            onCheck: () {
                                              motelPost.value.hasTree =
                                                  !(motelPost.value.hasTree ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasPillow ??
                                                false,
                                            tile: "Chăn ga gối",
                                            onCheck: () {
                                              motelPost.value.hasPillow =
                                                  !(motelPost.value.hasPillow ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasWardrobe ??
                                                    false,
                                            tile: "Tủ quần áo",
                                            onCheck: () {
                                              motelPost.value.hasWardrobe =
                                                  !(motelPost
                                                          .value.hasWardrobe ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasMattress ??
                                                    false,
                                            tile: "Nệm",
                                            onCheck: () {
                                              motelPost.value.hasMattress =
                                                  !(motelPost
                                                          .value.hasMattress ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasShoesRacks ??
                                                    false,
                                            tile: "Kệ giày dép",
                                            onCheck: () {
                                              motelPost.value.hasShoesRacks =
                                                  !(motelPost.value
                                                          .hasShoesRacks ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasCurtain ??
                                                false,
                                            tile: "Rèm",
                                            onCheck: () {
                                              motelPost.value.hasCurtain =
                                                  !(motelPost
                                                          .value.hasCurtain ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasCeilingFans ??
                                                false,
                                            tile: "Quạt trần",
                                            onCheck: () {
                                              motelPost.value.hasCeilingFans =
                                                  !(motelPost.value
                                                          .hasCeilingFans ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasMirror ??
                                                false,
                                            tile: "Gương toàn thân",
                                            onCheck: () {
                                              motelPost.value.hasMirror =
                                                  !(motelPost.value.hasMirror ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasSofa ??
                                                false,
                                            tile: "Sofa",
                                            onCheck: () {
                                              motelPost.value.hasSofa =
                                                  !(motelPost.value.hasSofa ??
                                                      false);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 66,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 15,
                left: 10,
                right: 10,
                child: SahaButtonFullParent(
                  onPressed: () {
                    motelPost.value.fromMoney = rangePriceValue.value.start;
                    motelPost.value.maxMoney = rangePriceValue.value.end;
                    onAccept(motelPost.value);
                    Get.back();
                  },
                  text: "Áp dụng",
                ),
              )
            ],
          );
        });
  }

  static void showFilterPostFindRoom(
      {required PostFindRoomFilter motelPostReqInput,
      required Function onAccept}) {
    var motelPost = PostFindRoomFilter().obs;

    var rangePriceValue = const RangeValues(0, 20000000).obs;
    rangePriceValue.value = RangeValues(motelPostReqInput.fromMoney ?? 0,
        motelPostReqInput.maxMoney ?? 20000000);
    motelPost(motelPostReqInput);
    motelPost.value.listType ??= [];
    Widget itemService(
        {required bool value,
        required String tile,
        required Function onCheck}) {
      return InkWell(
        onTap: () {
          onCheck();
          motelPost.refresh();
        },
        child: Stack(
          children: [
            Container(
              width: (Get.width - 40) / 2,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: value
                          ? Theme.of(Get.context!).primaryColor
                          : Colors.grey[200]!)),
              child: Center(
                child: Text(
                  tile,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color:
                          value ? Theme.of(Get.context!).primaryColor : null),
                ),
              ),
            ),
            if (value == true)
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
      );
    }

    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.grey[200],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        isScrollControlled: true,
        builder: (context) {
          return Stack(
            children: [
              SizedBox(
                height: Get.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: 50,
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(Icons.clear)),
                          const Text(
                            "Lọc kết quả",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                motelPost.value =
                                    PostFindRoomFilter(listType: []);
                              },
                              child: const Text('Bỏ lọc'))
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => Text(
                                            'Giá từ ${SahaStringUtils().convertToMoney(rangePriceValue.value.start.round().toString())}đ đến ${SahaStringUtils().convertToMoney(rangePriceValue.value.end.round().toString())}đ'),
                                      ),
                                      Obx(
                                        () => RangeSlider(
                                            values: rangePriceValue.value,
                                            max: 20000000,
                                            divisions: 40,
                                            onChanged: (RangeValues v) {
                                              rangePriceValue.value = v;
                                            }),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'SẮP XẾP THEO',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time_rounded),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text('Tin mới'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                          value: motelPost.value
                                                                  .sortBy ==
                                                              'created_at',
                                                          onChanged: (v) {
                                                            if (motelPost.value
                                                                    .sortBy ==
                                                                'created_at') {
                                                              motelPost.value
                                                                  .sortBy = '';
                                                              motelPost.value
                                                                      .descending =
                                                                  true;
                                                            } else {
                                                              motelPost.value
                                                                      .sortBy =
                                                                  'created_at';
                                                              motelPost.value
                                                                      .descending =
                                                                  true;
                                                            }

                                                            motelPost.refresh();
                                                          }),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.arrow_circle_up_rounded),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                            'Giá cao nhất'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                          value: motelPost.value
                                                                      .sortBy ==
                                                                  'money' &&
                                                              motelPost.value
                                                                      .descending ==
                                                                  true,
                                                          onChanged: (v) {
                                                            if (motelPost.value
                                                                    .sortBy ==
                                                                'money') {
                                                              motelPost.value
                                                                  .sortBy = '';
                                                              motelPost.value
                                                                      .descending =
                                                                  true;
                                                            } else {
                                                              motelPost.value
                                                                      .sortBy =
                                                                  'money';
                                                              motelPost.value
                                                                      .descending =
                                                                  true;
                                                            }

                                                            motelPost.refresh();
                                                          }),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.arrow_circle_down_rounded),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                            'Giá thấp nhất'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                          value: motelPost.value
                                                                      .sortBy ==
                                                                  'money' &&
                                                              motelPost.value
                                                                      .descending ==
                                                                  false,
                                                          onChanged: (v) {
                                                            if (motelPost.value
                                                                    .sortBy ==
                                                                'money') {
                                                              motelPost.value
                                                                  .sortBy = '';
                                                              motelPost.value
                                                                      .descending =
                                                                  false;
                                                            } else {
                                                              motelPost.value
                                                                      .sortBy =
                                                                  'money';
                                                              motelPost.value
                                                                      .descending =
                                                                  false;
                                                            }

                                                            motelPost.refresh();
                                                          }),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'LOẠI PHÒNG',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child:
                                                            Text('Trọ thường'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(MOTEL),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(
                                                                  MOTEL)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere(
                                                                    (e) =>
                                                                        e ==
                                                                        MOTEL);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(MOTEL);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child:
                                                            Text('Nguyên căn'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(
                                                                MOTEL_COMPOUND),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(
                                                                  MOTEL_COMPOUND)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere((e) =>
                                                                    e ==
                                                                    MOTEL_COMPOUND);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(
                                                                    MOTEL_COMPOUND);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text('HomeStay'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(HOMESTAY),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(
                                                                  HOMESTAY)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere(
                                                                    (e) =>
                                                                        e ==
                                                                        HOMESTAY);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(HOMESTAY);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text('Chung cư'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(HOME),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(HOME)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere(
                                                                    (e) =>
                                                                        e ==
                                                                        HOME);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(HOME);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                            'Chưng cư mini'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(VILLA),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(
                                                                  VILLA)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere(
                                                                    (e) =>
                                                                        e ==
                                                                        VILLA);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(VILLA);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'TIỆN NGHI',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 10, bottom: 10),
                                  child: Obx(
                                    () => Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: [
                                        itemService(
                                            value:
                                                motelPost.value.hasWc ?? false,
                                            tile: "Vệ sinh khép kín",
                                            onCheck: () {
                                              motelPost.value.hasWc =
                                                  !(motelPost.value.hasWc ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasMezzanine ??
                                                    false,
                                            tile: "Gác xép",
                                            onCheck: () {
                                              motelPost.value.hasMezzanine =
                                                  !(motelPost
                                                          .value.hasMezzanine ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasBalcony ??
                                                false,
                                            tile: "Ban công",
                                            onCheck: () {
                                              motelPost.value.hasBalcony =
                                                  !(motelPost
                                                          .value.hasBalcony ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasFingerprint ??
                                                false,
                                            tile: "Ra vào vân tay",
                                            onCheck: () {
                                              motelPost.value.hasFingerprint =
                                                  !(motelPost.value
                                                          .hasFingerprint ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasOwnOwner ??
                                                    false,
                                            tile: "Không chung chủ",
                                            onCheck: () {
                                              motelPost.value.hasOwnOwner =
                                                  !(motelPost
                                                          .value.hasOwnOwner ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasPet ?? false,
                                            tile: "Nuôi Pet",
                                            onCheck: () {
                                              motelPost.value.hasPet =
                                                  !(motelPost.value.hasPet ??
                                                      false);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'NỘI THẤT',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 10, bottom: 10),
                                  child: Obx(
                                    () => Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: [
                                        itemService(
                                            value: motelPost
                                                    .value.hasAirConditioner ??
                                                false,
                                            tile: "Điều hoà",
                                            onCheck: () {
                                              motelPost
                                                      .value.hasAirConditioner =
                                                  !(motelPost.value
                                                          .hasAirConditioner ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasWaterHeater ??
                                                false,
                                            tile: "Nóng lạnh",
                                            onCheck: () {
                                              motelPost.value.hasWaterHeater =
                                                  !(motelPost.value
                                                          .hasWaterHeater ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasKitchen ??
                                                false,
                                            tile: "Kệ bếp",
                                            onCheck: () {
                                              motelPost.value.hasKitchen =
                                                  !(motelPost
                                                          .value.hasKitchen ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasFridge ??
                                                false,
                                            tile: "Tủ lạnh",
                                            onCheck: () {
                                              motelPost.value.hasFridge =
                                                  !(motelPost.value.hasFridge ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasBed ?? false,
                                            tile: "Giường ngủ",
                                            onCheck: () {
                                              motelPost.value.hasBed =
                                                  !(motelPost.value.hasBed ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasWashingMachine ??
                                                false,
                                            tile: "Máy giặt",
                                            onCheck: () {
                                              motelPost
                                                      .value.hasWashingMachine =
                                                  !(motelPost.value
                                                          .hasWashingMachine ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasKitchenStuff ??
                                                false,
                                            tile: "Đồ dùng bếp",
                                            onCheck: () {
                                              motelPost.value.hasKitchenStuff =
                                                  !(motelPost.value
                                                          .hasKitchenStuff ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasTable ??
                                                false,
                                            tile: "Bàn ghế",
                                            onCheck: () {
                                              motelPost.value.hasTable =
                                                  !(motelPost.value.hasTable ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value
                                                    .hasDecorativeLights ??
                                                false,
                                            tile: "Đèn trang trí",
                                            onCheck: () {
                                              motelPost.value
                                                      .hasDecorativeLights =
                                                  !(motelPost.value
                                                          .hasDecorativeLights ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasPicture ??
                                                false,
                                            tile: "Tranh trang trí",
                                            onCheck: () {
                                              motelPost.value.hasPicture =
                                                  !(motelPost
                                                          .value.hasPicture ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasTree ??
                                                false,
                                            tile: "Cây cối trang trí",
                                            onCheck: () {
                                              motelPost.value.hasTree =
                                                  !(motelPost.value.hasTree ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasPillow ??
                                                false,
                                            tile: "Chăn ga gối",
                                            onCheck: () {
                                              motelPost.value.hasPillow =
                                                  !(motelPost.value.hasPillow ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasWardrobe ??
                                                    false,
                                            tile: "Tủ quần áo",
                                            onCheck: () {
                                              motelPost.value.hasWardrobe =
                                                  !(motelPost
                                                          .value.hasWardrobe ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasMattress ??
                                                    false,
                                            tile: "Nệm",
                                            onCheck: () {
                                              motelPost.value.hasMattress =
                                                  !(motelPost
                                                          .value.hasMattress ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasShoesRacks ??
                                                    false,
                                            tile: "Kệ giày dép",
                                            onCheck: () {
                                              motelPost.value.hasShoesRacks =
                                                  !(motelPost.value
                                                          .hasShoesRacks ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasCurtain ??
                                                false,
                                            tile: "Rèm",
                                            onCheck: () {
                                              motelPost.value.hasCurtain =
                                                  !(motelPost
                                                          .value.hasCurtain ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasCeilingFans ??
                                                false,
                                            tile: "Quạt trần",
                                            onCheck: () {
                                              motelPost.value.hasCeilingFans =
                                                  !(motelPost.value
                                                          .hasCeilingFans ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasMirror ??
                                                false,
                                            tile: "Gương toàn thân",
                                            onCheck: () {
                                              motelPost.value.hasMirror =
                                                  !(motelPost.value.hasMirror ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasSofa ??
                                                false,
                                            tile: "Sofa",
                                            onCheck: () {
                                              motelPost.value.hasSofa =
                                                  !(motelPost.value.hasSofa ??
                                                      false);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 66,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 15,
                left: 10,
                right: 10,
                child: SahaButtonFullParent(
                  onPressed: () {
                    motelPost.value.fromMoney = rangePriceValue.value.start;
                    motelPost.value.maxMoney = rangePriceValue.value.end;
                    onAccept(motelPost.value);
                    Get.back();
                  },
                  text: "Áp dụng",
                ),
              )
            ],
          );
        });
  }

  static void showDialogImageTest(Uint8List bytes) {
    // flutter defined function
    showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Thành công!"),
          content: Column(
            children: [Image.memory(bytes)],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogOneButton(
      {String? title, String? mess, bool barrierDismissible = true, Function? onClose}) {
    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title ?? "Thành công!"),
          content: Text(mess ?? "Gửi yêu cầu bài hát mới thành công!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                onClose!();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogInputText({
    required String title,
    String? textInput,
    String? des,
    required String textButton,
    required Function onDone,
  }) {
    TextEditingController nameEditingController =
        TextEditingController(text: textInput);
    Get.dialog(
      AlertDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                )),
              ],
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
              child: TextField(
                controller: nameEditingController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                style: const TextStyle(fontSize: 14),
                maxLines: 5,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: des,
                  contentPadding: const EdgeInsets.only(left: 5),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    onDone(nameEditingController.text);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      textButton,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }

  static void showDialogNotificationOneButton(
      {String? mess, bool barrierDismissible = true, Function? onClose}) {
    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Thông báo!"),
          content: Text(mess ?? "Chú ý!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                onClose!();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showDialogInput(
      {String? title,
      String? hintText,
      bool? isNumber,
      String? textInput,
      Function? onInput,
      Function? onCancel}) {
    return showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) {
          TextEditingController textEditingController =
              TextEditingController(text: textInput);
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: textEditingController,
                    keyboardType: isNumber == true
                        ? TextInputType.number
                        : TextInputType.text,
                    inputFormatters:
                        isNumber == true ? [ThousandsFormatter()] : null,
                    decoration: InputDecoration(
                      labelText: title ?? "",
                      hintText: hintText ?? "",
                      hintStyle: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    if (onCancel != null) onCancel();
                    Get.back();
                  }),
              TextButton(
                  child: const Text('Đồng ý'),
                  onPressed: () {
                    onInput!(textEditingController.text);
                    Get.back();
                  })
            ],
          );
        });
  }

  static Future<void> showDialogFixService(
      {String? title,
      String? hintText,
      bool? isNumber,
      String? textInput,
      Function? onInput,
      Function? onCancel}) {
    return showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) {
          TextEditingController textEditingController =
              TextEditingController(text: textInput);
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: textEditingController,
                    keyboardType: isNumber == true
                        ? TextInputType.number
                        : TextInputType.text,
                    inputFormatters:
                        isNumber == true ? [ThousandsFormatter()] : null,
                    decoration: InputDecoration(
                      labelText: title ?? "",
                      hintText: hintText ?? "",
                      hintStyle: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    if (onCancel != null) onCancel();
                    Get.back();
                  }),
              TextButton(
                  child: const Text('Đồng ý'),
                  onPressed: () {
                    onInput!(textEditingController.text);
                    Get.back();
                  })
            ],
          );
        });
  }

  static void showDialogError(
      {required BuildContext context, String? errorMess}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Có lỗi xảy ra"),
          content: Text(errorMess!),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogYesNo(
      {String? mess,
      bool barrierDismissible = true,
      Function? onClose,
      Function? onOK}) {
    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Thông báo!"),
          content: Text(mess ?? "Chú ý!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text(
                "Hủy",
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (onClose != null) {
                  onClose();
                }
              },
            ),
            TextButton(
              child: const Text(
                "Đồng ý",
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onOK!();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogSex({int? sex, required Function onChoose}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Chọn giới tính",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text(
                      "Nam, Nữ",
                    ),
                    onTap: () async {
                      onChoose(0);
                      Get.back();
                    },
                    trailing: sex == 0
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  const Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: const Text(
                      "Nam",
                    ),
                    onTap: () async {
                      onChoose(1);
                      Get.back();
                    },
                    trailing: sex == 1
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  const Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: const Text(
                      "Nữ",
                    ),
                    onTap: () async {
                      onChoose(2);
                      Get.back();
                    },
                    trailing: sex == 2
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogServiceIcon(
      {String? icon, required Function onChoose}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Chọn Icon dịch vụ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 1,
              ),
              Wrap(
                children: [
                  ...iconService
                      .map((e) => InkWell(
                            onTap: () {
                              onChoose(e);
                            },
                            child: Container(
                              width: Get.width / 3,
                              padding: const EdgeInsets.only(top: 20),
                              child: InkWell(
                                child: Image.asset(
                                  e,
                                  width: 40,
                                  height: 40,
                                ),
                                onTap: () async {
                                  onChoose(e);
                                  Get.back();
                                },
                              ),
                            ),
                          ))
                      .toList(),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          );
        });
  }

  static void showDialogPaymentTerm(
      {String? icon, required Function onChoose}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Chọn kỳ hạn nộp",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 1,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...paymentTerm
                          .map((e) => InkWell(
                                onTap: () {
                                  onChoose(e);
                                },
                                child: InkWell(
                                  onTap: () async {
                                    onChoose(e);
                                    Get.back();
                                  },
                                  child: Container(
                                    width: Get.width / 1.3,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          offset: const Offset(0, 1),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Text(
                                      "$e Tháng",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogSuggestion(
      {required String title, required Widget contentWidget}) {
    // flutter defined function
    showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          contentPadding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 0),
          alignment: Alignment.center,
          content: contentWidget,
          titlePadding: const EdgeInsets.only(bottom: 10, top: 20),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.all(0),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text("Tôi đã hiểu"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static void showBottomFilter(
      {required MotelPostReq motelPostReqInput, required Function onAccept}) {
    var motelPost = MotelPostReq().obs;

    var rangePriceValue = const RangeValues(0, 20000000).obs;
    rangePriceValue.value = RangeValues(motelPostReqInput.fromMoney ?? 0,
        motelPostReqInput.maxMoney ?? 20000000);
    motelPost(motelPostReqInput);
    motelPost.value.listType ??= [];
    Widget itemService(
        {required bool value,
        required String tile,
        required Function onCheck}) {
      return InkWell(
        onTap: () {
          onCheck();
          motelPost.refresh();
        },
        child: Stack(
          children: [
            Container(
              width: (Get.width - 40) / 2,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: value
                          ? Theme.of(Get.context!).primaryColor
                          : Colors.grey[200]!)),
              child: Center(
                child: Text(
                  tile,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color:
                          value ? Theme.of(Get.context!).primaryColor : null),
                ),
              ),
            ),
            if (value == true)
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
      );
    }

    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.grey[200],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        isScrollControlled: true,
        builder: (context) {
          return Stack(
            children: [
              SizedBox(
                height: Get.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: 50,
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(Icons.clear)),
                          const Text(
                            "Lọc kết quả",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                motelPost.value = MotelPostReq(listType: []);
                              },
                              child: const Text('Bỏ lọc'))
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => Text(
                                            'Giá từ ${SahaStringUtils().convertToMoney(rangePriceValue.value.start.round().toString())}đ đến ${SahaStringUtils().convertToMoney(rangePriceValue.value.end.round().toString())}đ'),
                                      ),
                                      Obx(
                                        () => RangeSlider(
                                            values: rangePriceValue.value,
                                            max: 20000000,
                                            divisions: 40,
                                            onChanged: (RangeValues v) {
                                              rangePriceValue.value = v;
                                            }),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'SẮP XẾP THEO',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time_rounded),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text('Tin mới'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                          value: motelPost.value
                                                                  .sortBy ==
                                                              'created_at',
                                                          onChanged: (v) {
                                                            if (motelPost.value
                                                                    .sortBy ==
                                                                'created_at') {
                                                              motelPost.value
                                                                  .sortBy = '';
                                                              motelPost.value
                                                                      .descending =
                                                                  true;
                                                            } else {
                                                              motelPost.value
                                                                      .sortBy =
                                                                  'created_at';
                                                              motelPost.value
                                                                      .descending =
                                                                  true;
                                                            }

                                                            motelPost.refresh();
                                                          }),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.arrow_circle_up_rounded),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                            'Giá cao nhất'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                          value: motelPost.value
                                                                      .sortBy ==
                                                                  'money' &&
                                                              motelPost.value
                                                                      .descending ==
                                                                  true,
                                                          onChanged: (v) {
                                                            if (motelPost.value
                                                                    .sortBy ==
                                                                'money') {
                                                              motelPost.value
                                                                  .sortBy = '';
                                                              motelPost.value
                                                                      .descending =
                                                                  true;
                                                            } else {
                                                              motelPost.value
                                                                      .sortBy =
                                                                  'money';
                                                              motelPost.value
                                                                      .descending =
                                                                  true;
                                                            }

                                                            motelPost.refresh();
                                                          }),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.arrow_circle_down_rounded),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                            'Giá thấp nhất'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                          value: motelPost.value
                                                                      .sortBy ==
                                                                  'money' &&
                                                              motelPost.value
                                                                      .descending ==
                                                                  false,
                                                          onChanged: (v) {
                                                            if (motelPost.value
                                                                    .sortBy ==
                                                                'money') {
                                                              motelPost.value
                                                                  .sortBy = '';
                                                              motelPost.value
                                                                      .descending =
                                                                  false;
                                                            } else {
                                                              motelPost.value
                                                                      .sortBy =
                                                                  'money';
                                                              motelPost.value
                                                                      .descending =
                                                                  false;
                                                            }

                                                            motelPost.refresh();
                                                          }),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'LOẠI PHÒNG',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child:
                                                            Text('Trọ thường'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(MOTEL),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(
                                                                  MOTEL)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere(
                                                                    (e) =>
                                                                        e ==
                                                                        MOTEL);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(MOTEL);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child:
                                                            Text('Nguyên căn'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(
                                                                MOTEL_COMPOUND),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(
                                                                  MOTEL_COMPOUND)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere((e) =>
                                                                    e ==
                                                                    MOTEL_COMPOUND);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(
                                                                    MOTEL_COMPOUND);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text('HomeStay'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(HOMESTAY),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(
                                                                  HOMESTAY)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere(
                                                                    (e) =>
                                                                        e ==
                                                                        HOMESTAY);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(HOMESTAY);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text('Chung cư'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(HOME),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(HOME)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere(
                                                                    (e) =>
                                                                        e ==
                                                                        HOME);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(HOME);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.home_outlined),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                            'Chưng cư mini'),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Checkbox(
                                                        value: (motelPost.value
                                                                    .listType ??
                                                                [])
                                                            .contains(VILLA),
                                                        onChanged: (v) {
                                                          if ((motelPost.value
                                                                      .listType ??
                                                                  [])
                                                              .contains(
                                                                  VILLA)) {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .removeWhere(
                                                                    (e) =>
                                                                        e ==
                                                                        VILLA);
                                                          } else {
                                                            (motelPost.value
                                                                        .listType ??
                                                                    [])
                                                                .add(VILLA);
                                                          }

                                                          motelPost.refresh();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'TIỆN NGHI',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 10, bottom: 10),
                                  child: Obx(
                                    () => Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: [
                                        itemService(
                                            value:
                                                motelPost.value.hasWc ?? false,
                                            tile: "Vệ sinh khép kín",
                                            onCheck: () {
                                              motelPost.value.hasWc =
                                                  !(motelPost.value.hasWc ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasMezzanine ??
                                                    false,
                                            tile: "Gác xép",
                                            onCheck: () {
                                              motelPost.value.hasMezzanine =
                                                  !(motelPost
                                                          .value.hasMezzanine ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasBalcony ??
                                                false,
                                            tile: "Ban công",
                                            onCheck: () {
                                              motelPost.value.hasBalcony =
                                                  !(motelPost
                                                          .value.hasBalcony ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasFingerprint ??
                                                false,
                                            tile: "Ra vào vân tay",
                                            onCheck: () {
                                              motelPost.value.hasFingerprint =
                                                  !(motelPost.value
                                                          .hasFingerprint ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasOwnOwner ??
                                                    false,
                                            tile: "Không chung chủ",
                                            onCheck: () {
                                              motelPost.value.hasOwnOwner =
                                                  !(motelPost
                                                          .value.hasOwnOwner ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasPet ?? false,
                                            tile: "Nuôi Pet",
                                            onCheck: () {
                                              motelPost.value.hasPet =
                                                  !(motelPost.value.hasPet ??
                                                      false);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'NỘI THẤT',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 10, bottom: 10),
                                  child: Obx(
                                    () => Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: [
                                        itemService(
                                            value: motelPost
                                                    .value.hasAirConditioner ??
                                                false,
                                            tile: "Điều hoà",
                                            onCheck: () {
                                              motelPost
                                                      .value.hasAirConditioner =
                                                  !(motelPost.value
                                                          .hasAirConditioner ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasWaterHeater ??
                                                false,
                                            tile: "Nóng lạnh",
                                            onCheck: () {
                                              motelPost.value.hasWaterHeater =
                                                  !(motelPost.value
                                                          .hasWaterHeater ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasKitchen ??
                                                false,
                                            tile: "Kệ bếp",
                                            onCheck: () {
                                              motelPost.value.hasKitchen =
                                                  !(motelPost
                                                          .value.hasKitchen ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasFridge ??
                                                false,
                                            tile: "Tủ lạnh",
                                            onCheck: () {
                                              motelPost.value.hasFridge =
                                                  !(motelPost.value.hasFridge ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasBed ?? false,
                                            tile: "Giường ngủ",
                                            onCheck: () {
                                              motelPost.value.hasBed =
                                                  !(motelPost.value.hasBed ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasWashingMachine ??
                                                false,
                                            tile: "Máy giặt",
                                            onCheck: () {
                                              motelPost
                                                      .value.hasWashingMachine =
                                                  !(motelPost.value
                                                          .hasWashingMachine ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasKitchenStuff ??
                                                false,
                                            tile: "Đồ dùng bếp",
                                            onCheck: () {
                                              motelPost.value.hasKitchenStuff =
                                                  !(motelPost.value
                                                          .hasKitchenStuff ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasTable ??
                                                false,
                                            tile: "Bàn ghế",
                                            onCheck: () {
                                              motelPost.value.hasTable =
                                                  !(motelPost.value.hasTable ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value
                                                    .hasDecorativeLights ??
                                                false,
                                            tile: "Đèn trang trí",
                                            onCheck: () {
                                              motelPost.value
                                                      .hasDecorativeLights =
                                                  !(motelPost.value
                                                          .hasDecorativeLights ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasPicture ??
                                                false,
                                            tile: "Tranh trang trí",
                                            onCheck: () {
                                              motelPost.value.hasPicture =
                                                  !(motelPost
                                                          .value.hasPicture ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasTree ??
                                                false,
                                            tile: "Cây cối trang trí",
                                            onCheck: () {
                                              motelPost.value.hasTree =
                                                  !(motelPost.value.hasTree ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasPillow ??
                                                false,
                                            tile: "Chăn ga gối",
                                            onCheck: () {
                                              motelPost.value.hasPillow =
                                                  !(motelPost.value.hasPillow ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasWardrobe ??
                                                    false,
                                            tile: "Tủ quần áo",
                                            onCheck: () {
                                              motelPost.value.hasWardrobe =
                                                  !(motelPost
                                                          .value.hasWardrobe ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasMattress ??
                                                    false,
                                            tile: "Nệm",
                                            onCheck: () {
                                              motelPost.value.hasMattress =
                                                  !(motelPost
                                                          .value.hasMattress ??
                                                      false);
                                            }),
                                        itemService(
                                            value:
                                                motelPost.value.hasShoesRacks ??
                                                    false,
                                            tile: "Kệ giày dép",
                                            onCheck: () {
                                              motelPost.value.hasShoesRacks =
                                                  !(motelPost.value
                                                          .hasShoesRacks ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasCurtain ??
                                                false,
                                            tile: "Rèm",
                                            onCheck: () {
                                              motelPost.value.hasCurtain =
                                                  !(motelPost
                                                          .value.hasCurtain ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost
                                                    .value.hasCeilingFans ??
                                                false,
                                            tile: "Quạt trần",
                                            onCheck: () {
                                              motelPost.value.hasCeilingFans =
                                                  !(motelPost.value
                                                          .hasCeilingFans ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasMirror ??
                                                false,
                                            tile: "Gương toàn thân",
                                            onCheck: () {
                                              motelPost.value.hasMirror =
                                                  !(motelPost.value.hasMirror ??
                                                      false);
                                            }),
                                        itemService(
                                            value: motelPost.value.hasSofa ??
                                                false,
                                            tile: "Sofa",
                                            onCheck: () {
                                              motelPost.value.hasSofa =
                                                  !(motelPost.value.hasSofa ??
                                                      false);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 66,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 15,
                left: 10,
                right: 10,
                child: SahaButtonFullParent(
                  onPressed: () {
                    motelPost.value.fromMoney = rangePriceValue.value.start;
                    motelPost.value.maxMoney = rangePriceValue.value.end;
                    onAccept(motelPost.value);
                    Get.back();
                  },
                  text: "Áp dụng",
                ),
              )
            ],
          );
        });
  }

  static void showDialogAddressChoose({
    required Function callback,
    required Function accept,
    int? idProvince,
    int? idDistrict,
    bool? hideAll,
  }) {
    TextEditingController textEditingController = TextEditingController();

    var nameTitleAppbar = "".obs;
    var listLocationAddress = RxList<LocationAddress>();
    List<LocationAddress> listLocationAddressCache = [];
    var isLoadingAddress = false.obs;

    Future<void> getProvince() async {
      isLoadingAddress.value = true;
      try {
        var res = await RepositoryManager.addressRepository.getProvince();

        for (var element in res!.data!) {
          listLocationAddress.add(element);
          listLocationAddressCache.add(element);
        }
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }

      isLoadingAddress.value = false;
    }

    Future<void> getDistrict(int? idProvince) async {
      isLoadingAddress.value = true;
      try {
        var res =
            await RepositoryManager.addressRepository.getDistrict(idProvince);

        for (var element in res!.data!) {
          listLocationAddress.add(element);
          listLocationAddressCache.add(element);
        }
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }

      isLoadingAddress.value = false;
    }

    Future<void> getWard(int? idDistrict) async {
      isLoadingAddress.value = true;
      try {
        var res = await RepositoryManager.addressRepository.getWard(idDistrict);

        for (var element in res!.data!) {
          listLocationAddress.add(element);
          listLocationAddressCache.add(element);
        }
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
      isLoadingAddress.value = false;
    }

    if (idProvince == null && idDistrict == null) {
      nameTitleAppbar.value = "Tỉnh/Thành phố";
      getProvince();
    } else if (idProvince == null && idDistrict != null) {
      nameTitleAppbar.value = "Phường/Xã";
      getWard(idDistrict);
    } else {
      nameTitleAppbar.value = "Quận/Huyện";
      getDistrict(idProvince);
    }

    void search(String text) {
      listLocationAddress(listLocationAddressCache
          .where((e) => TiengViet.parse(e.name ?? "")
              .toLowerCase()
              .contains(TiengViet.parse(text).toLowerCase()))
          .toList());
    }

    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    nameTitleAppbar.value,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            content: SizedBox(
              height: Get.height / 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search),
                        isDense: true,
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 14),
                      ),
                      onChanged: (v) async {
                        if (v != "") search(v);
                      },
                      style: const TextStyle(fontSize: 14),
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => isLoadingAddress.value == true
                        ? Expanded(
                            child: Center(child: SahaLoadingFullScreen()))
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Column(children: [
                                if (hideAll != true)
                                  InkWell(
                                    onTap: () {
                                      callback(LocationAddress(name: "Tất cả"));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                            'Tất cả',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                        const Divider(
                                          height: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                ...listLocationAddress
                                    .map((e) => InkWell(
                                          onTap: () {
                                            callback(e);
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text(
                                                  e.name ?? "",
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              ),
                                              const Divider(
                                                height: 1,
                                              )
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ]),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static void showDialogInputNote(
      {String? title,
      String? textInput,
      required Function confirm,
      Function? cancel,
      double? height}) {
    TextEditingController textEditingController =
        TextEditingController(text: textInput);
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            contentPadding: const EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? "",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: Get.width * 0.7,
                  height: height ?? Get.height / 5,
                  child: TextFormField(
                    controller: textEditingController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (v) async {},
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (cancel != null) {
                            cancel();
                          }
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey[200]!,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Thoát",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          confirm(textEditingController.text);
                          Get.back();
                        },
                        child: const SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              "Lưu",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  static void showDialogServiceType({required Function onChoose}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Thu phí dựa trên",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text(
                      "Theo chỉ số đồng hồ",
                    ),
                    subtitle: const Text(
                      'Dịch vụ có chỉ số đầu cuối (Điện, nước...)',
                      style: TextStyle(fontSize: 12),
                    ),
                    onTap: () async {
                      onChoose(0);
                      Get.back();
                    },
                  ),
                  const Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: const Text(
                      "Người hoặc Số lượng",
                    ),
                    subtitle: const Text(
                      'Tính theo số người hoặc số lượng(Vệ sinh 15.000đ/Người/Tháng...',
                      style: TextStyle(fontSize: 12),
                    ),
                    onTap: () async {
                      onChoose(1);
                      Get.back();
                    },
                  ),
                  const Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: const Text(
                      "Phòng",
                    ),
                    subtitle: const Text(
                      'Tính theo phòng(Thang máy 200.000đ/Phòng/Tháng...',
                      style: TextStyle(fontSize: 12),
                    ),
                    onTap: () async {
                      onChoose(2);
                      Get.back();
                    },
                  ),
                  const Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: const Text(
                      "Số lần sử dụng",
                    ),
                    subtitle: const Text(
                      'Tính số lần (Giặt là 10.000đ/Lần...)',
                      style: TextStyle(fontSize: 12),
                    ),
                    onTap: () async {
                      onChoose(3);
                      Get.back();
                    },
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogChangeDiscover(
      {required Function onChoose,
      required List<AdminDiscover> item,
      AdminDiscover? adminDiscoverInit}) {
    showDialog(
        barrierDismissible: true,
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  adminDiscoverInit?.id == null
                      ? 'Chọn khu vực tìm kiếm'
                      : "Chuyển đổi khu vực tìm kiếm",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  height: 1,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: item
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            onChoose(e);
                            Get.back();
                          },
                          child: Container(
                            width: Get.width,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              e.provinceName ?? "",
                              style: TextStyle(
                                color: adminDiscoverInit?.province == e.province
                                    ? Theme.of(context).primaryColor
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  static void showDialogReport({required Function onChoose}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Row(
                      children: const [
                        Icon(
                          Icons.report,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Gửi phản hồi",
                        ),
                      ],
                    ),
                    onTap: () async {
                      onChoose(0);
                    },
                  ),
                  const Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Icon(
                          Icons.call,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Gọi hotline ${Get.find<HomeController>().homeApp.value.adminContact?.phoneNumber ?? ""}",
                        ),
                      ],
                    ),
                    onTap: () async {
                      onChoose(1);
                    },
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showQRCodePopup({required String imageLink}) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(0),
            content: Container(
              height: Get.width * 0.95,
              child: Column(
                children: [
                  Image.network(
                    imageLink,
                    fit: BoxFit.cover,
                    width: Get.width * 0.8,
                    height: Get.width * 0.8,
                  ),
                  SizedBox(height: 10),
                  TextButton(
                      onPressed: () {
                        GallerySaver.saveImage(imageLink).then((bool? success) {
                          if (success == true) {
                            SahaAlert.showSuccess(message: "Đã lưu");
                          }
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.download),
                          Text("Tải mã QR về máy"),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  static void showDialogBalance(
      {String? mess,
      String? title,
      String? actionText,
      bool barrierDismissible = true,
      Function? onClose,
      Function? onOK}) {
    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,

          title: Text(title ?? "Thông báo!",
              style: TextStyle(color: Theme.of(context).primaryColor)),
          content: Text(mess ?? "Chú ý!"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ElevatedButton(
                child: Text(
                  actionText ?? "Đồng ý",
                  style: const TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onOK!();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
