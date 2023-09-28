import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/divide/divide.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../components/button/saha_button.dart';
import '../../../../../components/dialog/dialog.dart';
import '../../../../../components/text_field/text_field_no_border.dart';
import '../../../../../const/motel_type.dart';
import '../../../../../utils/string_utils.dart';
import 'add_customer_post_find_room_controller.dart';

class AddCustomerPostFindRoomScreen extends StatelessWidget {
  AddCustomerPostFindRoomScreen({super.key, this.idPostFindRoom,this.isAdmin}) {
    controller =
        AddCustomerPostFindRoomController(idPostFindRoom: idPostFindRoom);
  }
  final int? idPostFindRoom;
  bool? isAdmin;

  late AddCustomerPostFindRoomController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: "Bài đăng tìm phòng",
        ),
        body: Obx(
          () => controller.loadInit.value
              ? SahaLoadingFullScreen()
              : SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          if(isAdmin == true){
                            return;
                          }
                          SahaDialogApp.showDialogAddressChoose(
                            hideAll: true,
                            accept: () {},
                            callback: (v) {
                              controller.locationProvince.value = v;
                              Get.back();
                              SahaDialogApp.showDialogAddressChoose(
                                hideAll: true,
                                accept: () {},
                                idProvince:
                                    controller.locationProvince.value.id,
                                callback: (v) {
                                  controller.locationDistrict.value = v;
                                  Get.back();
                                  SahaDialogApp.showDialogAddressChoose(
                                    hideAll: true,
                                    accept: () {},
                                    idDistrict:
                                        controller.locationDistrict.value.id,
                                    callback: (v) {
                                      controller.locationWard.value = v;
                                      var province =
                                          controller.locationProvince;
                                      controller.postReq.value.province =
                                          province.value.id;
                                      var district =
                                          controller.locationDistrict;
                                      controller.postReq.value.district =
                                          district.value.id;
                                      var ward = controller.locationWard;
                                      controller.postReq.value.wards =
                                          ward.value.id;

                                      controller.postReq.refresh();
                                      controller.addressTextEditingController
                                              .text =
                                          "${ward.value.name} - ${district.value.name} - ${province.value.name}";
                                      Get.back();
                                      // SahaDialogApp.showDialogInputNote(
                                      //     height: 50,
                                      //     confirm: (v) {
                                      //       if (v == null || v == "") {
                                      //         SahaAlert.showToastMiddle(
                                      //             message:
                                      //                 "Vui lòng nhập địa chỉ chi tiết");
                                      //       } else {
                                      //         var province =
                                      //             controller.locationProvince;
                                      //         controller.postReq.value.province =
                                      //             province.value.id;
                                      //         var district =
                                      //             controller.locationDistrict;
                                      //         controller.postReq.value.district =
                                      //             district.value.id;
                                      //         var ward = controller.locationWard;
                                      //         controller.postReq.value.wards =
                                      //             ward.value.id;
                                      //         controller.postReq.value
                                      //             .addressDetail = v;

                                      //         controller.postReq.refresh();
                                      //         controller
                                      //                 .addressTextEditingController
                                      //                 .text =
                                      //             "${controller.postReq.value.addressDetail} - ${ward.value.name} - ${district.value.name} - ${province.value.name}";
                                      //       }
                                      //     },
                                      //     title: "Địa chỉ chi tiết",
                                      //     textInput: controller
                                      //             .postReq.value.addressDetail ??
                                      //         "");
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: SahaTextFieldNoBorder(
                          enabled: false,
                          labelText: "Lựa chọn địa điểm mong muốn",
                          textInputType: TextInputType.text,
                          controller: controller.addressTextEditingController,
                          withAsterisk: true,
                          onChanged: (v) {
                            //addPostController.postReq.value.name = v;
                          },
                          hintText: "Chọn địa chỉ",
                        ),
                      ),
                      SahaDivide(),
                      SahaTextFieldNoBorder(
                        withAsterisk: true,
                        controller: controller.title,
                        onChanged: (v) {
                          controller.postReq.value.title = v;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        labelText: "Tiêu đề bài đăng",
                        hintText: "Nhập tiêu đề bài đăng",
                      ),
                      SahaDivide(),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                  'Giá từ ${SahaStringUtils().convertToMoney(controller.rangePriceValue.value.start.round().toString())}đ đến ${SahaStringUtils().convertToMoney(controller.rangePriceValue.value.end.round().toString())}đ'),
                            ),
                            Obx(
                              () => IgnorePointer(
                                ignoring: isAdmin == true ? true : false,
                                child: RangeSlider(
                                    values: controller.rangePriceValue.value,
                                    max: 20000000,
                                    divisions: 40,
                                    onChanged: (RangeValues v) {
                                      controller.rangePriceValue.value = v;
                                      controller.postReq.value.moneyFrom =
                                          controller.rangePriceValue.value.start;
                                      controller.postReq.value.moneyTo =
                                          controller.rangePriceValue.value.end;
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SahaTextFieldNoBorder(
                        withAsterisk: true,
                        readOnly: isAdmin,
                        controller: controller.capacity,
                        textInputType: TextInputType.number,
                        onChanged: (v) {
                          controller.postReq.value.capacity = int.tryParse(v!);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        labelText: "Số lượng người ở",
                        hintText: "Nhập số lượng người ở",
                      ),
                      SahaDivide(),
                      Padding(
                        padding: const EdgeInsets.all(
                          16,
                        ),
                        child: InkWell(
                          onTap: () {
                            if(isAdmin == true){
                              return;
                            }
                            SahaDialogApp.showDialogSex(
                              onChoose: (sex) {
                                controller.postReq.value.sex = sex;
                                controller.postReq.refresh();
                              },
                              sex: controller.postReq.value.sex ?? 0,
                            );
                          },
                          child: Row(
                            children: [
                              const Text(
                                "Giới tính: ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                              Expanded(
                                child: Obx(
                                  () => Text(
                                    controller.postReq.value.sex == 0
                                        ? "Nam, nữ"
                                        : controller.postReq.value.sex == 1
                                            ? "Nam"
                                            : controller.postReq.value.sex == 2
                                                ? "Nữ"
                                                : "Nam, nữ",
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_rounded)
                            ],
                          ),
                        ),
                      ),
                      SahaDivide(),
                      SahaTextFieldNoBorder(
                         readOnly: isAdmin,
                        withAsterisk: true,
                        textInputType: TextInputType.phone,
                        controller: controller.phoneNumberTextEditingController,
                        onChanged: (v) {
                          controller.postReq.value.phoneNumber = v;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        labelText: "Số điện thoại liên hệ",
                        hintText: "Nhập số điện thoại",
                      ),
                      Container(
                          padding: const EdgeInsets.only(
                              top: 15, left: 10, right: 10, bottom: 10),
                          child: Image.asset(
                            'assets/icon_host/loai-phong.png',
                            width: Get.width / 3.5,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(right: 15.0, left: 15),
                          child: Wrap(
                            children: [
                              itemTypeRoom(type: MOTEL, title: "Trọ thường"),
                              itemTypeRoom(
                                  type: MOTEL_COMPOUND, title: "Nguyên căn"),
                              itemTypeRoom(type: HOME, title: "Chung cư"),
                              itemTypeRoom(type: VILLA, title: "Chung cư mini"),
                              itemTypeRoom(type: HOMESTAY, title: "Homestay"),
                            ],
                          )),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/icon_host/tien-nghi.png',
                          width: Get.width / 4,
                        ),
                      ),
                      IgnorePointer(
                        ignoring: isAdmin == true ? true : false,
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.only(
                              left: 15, top: 10, bottom: 10),
                          child: Obx(
                            () => Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                itemUtilities(
                                    value:
                                        controller.postReq.value.hasWc ?? false,
                                    tile: "Vệ sinh khép kín",
                                    onCheck: () {
                                      controller.postReq.value.hasWc =
                                          !(controller.postReq.value.hasWc ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.postReq.value.hasMezzanine ??
                                            false,
                                    tile: "Gác xép",
                                    onCheck: () {
                                      controller.postReq.value.hasMezzanine =
                                          !(controller
                                                  .postReq.value.hasMezzanine ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.postReq.value.hasBalcony ??
                                        false,
                                    tile: "Ban công",
                                    onCheck: () {
                                      controller.postReq.value.hasBalcony =
                                          !(controller.postReq.value.hasBalcony ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.postReq.value.hasFingerPrint ??
                                            false,
                                    tile: "Ra vào vân tay",
                                    onCheck: () {
                                      controller.postReq.value.hasFingerPrint =
                                          !(controller
                                                  .postReq.value.hasFingerPrint ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.postReq.value.hasOwnOwner ??
                                        false,
                                    tile: "Không chung chủ",
                                    onCheck: () {
                                      controller.postReq.value.hasOwnOwner =
                                          !(controller
                                                  .postReq.value.hasOwnOwner ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.postReq.value.hasPet ?? false,
                                    tile: "Nuôi pet",
                                    onCheck: () {
                                      controller.postReq.value.hasPet =
                                          !(controller.postReq.value.hasPet ??
                                              false);
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SahaDivide(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/icon_host/noi-that.png',
                          width: Get.width / 4,
                        ),
                      ),
                      IgnorePointer(
                        ignoring: isAdmin == true ? true : false,
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.only(
                              left: 15, top: 10, bottom: 10),
                          child: Obx(
                            () => Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                itemUtilities(
                                    value: controller
                                            .postReq.value.hasAirConditioner ??
                                        false,
                                    tile: "Điều hoà",
                                    onCheck: () {
                                      controller.postReq.value.hasAirConditioner =
                                          !(controller.postReq.value
                                                  .hasAirConditioner ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.postReq.value.hasWaterHeater ??
                                            false,
                                    tile: "Bình nóng lạnh",
                                    onCheck: () {
                                      controller.postReq.value.hasWaterHeater =
                                          !(controller
                                                  .postReq.value.hasWaterHeater ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.postReq.value.hasKitchen ??
                                        false,
                                    tile: "Kệ bếp",
                                    onCheck: () {
                                      controller.postReq.value.hasKitchen =
                                          !(controller.postReq.value.hasKitchen ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.postReq.value.hasFridge ??
                                        false,
                                    tile: "Tủ lạnh",
                                    onCheck: () {
                                      controller.postReq.value.hasFridge =
                                          !(controller.postReq.value.hasFridge ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.postReq.value.hasBed ?? false,
                                    tile: "Giường ngủ",
                                    onCheck: () {
                                      controller.postReq.value.hasBed =
                                          !(controller.postReq.value.hasBed ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller
                                            .postReq.value.hasWashingMachine ??
                                        false,
                                    tile: "Máy giặt",
                                    onCheck: () {
                                      controller.postReq.value.hasWashingMachine =
                                          !(controller.postReq.value
                                                  .hasWashingMachine ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller
                                            .postReq.value.hasKitchenStuff ??
                                        false,
                                    tile: "Đồ dùng bếp",
                                    onCheck: () {
                                      controller.postReq.value.hasKitchenStuff =
                                          !(controller.postReq.value
                                                  .hasKitchenStuff ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.postReq.value.hasTable ??
                                        false,
                                    tile: "Bàn ghế",
                                    onCheck: () {
                                      controller.postReq.value.hasTable =
                                          !(controller.postReq.value.hasTable ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller
                                            .postReq.value.hasDecorativeLights ??
                                        false,
                                    tile: "Đèn trang trí",
                                    onCheck: () {
                                      controller.postReq.value
                                          .hasDecorativeLights = !(controller
                                              .postReq
                                              .value
                                              .hasDecorativeLights ??
                                          false);
                                    }),
                                itemUtilities(
                                    value: controller.postReq.value.hasPicture ??
                                        false,
                                    tile: "Tranh trang trí",
                                    onCheck: () {
                                      controller.postReq.value.hasPicture =
                                          !(controller.postReq.value.hasPicture ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.postReq.value.hasTree ?? false,
                                    tile: "Cây cối trang trí",
                                    onCheck: () {
                                      controller.postReq.value.hasTree =
                                          !(controller.postReq.value.hasTree ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.postReq.value.hasPillow ??
                                        false,
                                    tile: "Chăn,ga gối",
                                    onCheck: () {
                                      controller.postReq.value.hasPillow =
                                          !(controller.postReq.value.hasPillow ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.postReq.value.hasWardrobe ??
                                        false,
                                    tile: "Tủ quần áo",
                                    onCheck: () {
                                      controller.postReq.value.hasWardrobe =
                                          !(controller
                                                  .postReq.value.hasWardrobe ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.postReq.value.hasMattress ??
                                        false,
                                    tile: "Nệm",
                                    onCheck: () {
                                      controller.postReq.value.hasMattress =
                                          !(controller
                                                  .postReq.value.hasMattress ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.postReq.value.hasShoesRasks ??
                                            false,
                                    tile: "Kệ giày dép",
                                    onCheck: () {
                                      controller.postReq.value.hasShoesRasks =
                                          !(controller
                                                  .postReq.value.hasShoesRasks ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.postReq.value.hasCurtain ??
                                        false,
                                    tile: "Rèm",
                                    onCheck: () {
                                      controller.postReq.value.hasCurtain =
                                          !(controller.postReq.value.hasCurtain ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.postReq.value.hasCeilingFans ??
                                            false,
                                    tile: "Quạt tràn",
                                    onCheck: () {
                                      controller.postReq.value.hasCeilingFans =
                                          !(controller
                                                  .postReq.value.hasCeilingFans ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.postReq.value.hasMirror ??
                                        false,
                                    tile: "Gương toàn thân",
                                    onCheck: () {
                                      controller.postReq.value.hasMirror =
                                          !(controller.postReq.value.hasMirror ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.postReq.value.hasSofa ?? false,
                                    tile: "Sofa",
                                    onCheck: () {
                                      controller.postReq.value.hasSofa =
                                          !(controller.postReq.value.hasSofa ??
                                              false);
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(
                                  1, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: SahaTextFieldNoBorder(
                          enabled: true,
                          controller: controller.noteTextEditingController,
                          onChanged: (v) {
                            controller.postReq.value.note = v;
                          },
                          textInputType: TextInputType.multiline,
                          maxLine: 5,
                          labelText: "Ghi chú",
                          hintText: "Nhập ghi chú",
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                text: idPostFindRoom == null
                    ? "Thêm bài đăng"
                    : 'Chỉnh sửa bài đăng',
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   SahaDialogApp.showDialogYesNo(
                  //       mess:
                  //           "Bạn có chắc muốn cập nhật bài đăng này",
                  //       onClose: () {},
                  //       onOK: () {
                  //         addUpdatePostManagementController
                  //             .updatePostManagement();
                  //       });
                  // }
                  SahaDialogApp.showDialogYesNo(
                      mess: idPostFindRoom == null
                          ? "Bạn có chắc muốn thêm bài đăng này"
                          : "Bạn có chắc muốn cập nhật bài đăng này",
                      onClose: () {},
                      onOK: () {
                        if (idPostFindRoom == null) {
                          controller.addPostFindRoom();
                        } else {
                          controller.updatePostFindRoom();
                        }
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemUtilities(
      {required bool value, required String tile, required Function onCheck}) {
    return InkWell(
      onTap: () {
        onCheck();
        controller.postReq.refresh();
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
                    color: value ? Theme.of(Get.context!).primaryColor : null),
              ),
            ),
          ),
          if (value == false)
            Positioned.fill(
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200]!.withOpacity(0.5),
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

  Widget itemTypeRoom({required int type, required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if(isAdmin == true){
            return;
          }
          controller.postReq.value.type = type;
          controller.postReq.refresh();
        },
        child: Stack(
          children: [
            Container(
                width: Get.width / 3 - 26,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: controller.postReq.value.type == type
                          ? Theme.of(Get.context!).primaryColor
                          : Colors.grey[200]!),
                  color: controller.postReq.value.type == type
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: controller.postReq.value.type == type
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                ),
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: controller.postReq.value.type == type
                            ? Theme.of(Get.context!).primaryColor
                            : null),
                  ),
                )),
            if (controller.postReq.value.type == type)
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
