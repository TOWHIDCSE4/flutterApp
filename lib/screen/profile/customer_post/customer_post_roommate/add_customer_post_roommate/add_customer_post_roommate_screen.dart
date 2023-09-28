import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/screen/profile/customer_post/customer_post_roommate/add_customer_post_roommate/add_customer_post_roommate_controller.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../components/button/saha_button.dart';
import '../../../../../components/dialog/dialog.dart';
import '../../../../../components/divide/divide.dart';
import '../../../../../components/loading/loading_full_screen.dart';
import '../../../../../components/text_field/text_field_no_border.dart';
import '../../../../../components/widget/image/select_images.dart';
import '../../../../../components/widget/video_picker_single/video_picker_single.dart';
import '../../../../../const/motel_type.dart';
import '../../../../../const/type_image.dart';
import '../../../../../model/image_assset.dart';
import '../../../../../model/service.dart';
import '../../../../../utils/string_utils.dart';
import '../../../../owner/choose_room/choose_room_screen.dart';

class AddCustomerPostRoommateScreen extends StatelessWidget {
  AddCustomerPostRoommateScreen({super.key, this.idPostRoommate,this.isAdmin}) {
    controller =
        AddCustomerPostRoommateController(idPostRoommate: idPostRoommate);
  }
  late AddCustomerPostRoommateController controller;
  final _formKey = GlobalKey<FormState>();
  final int? idPostRoommate;
  final bool? isAdmin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: idPostRoommate == null
            ? "Thêm bài đăng tìm người ở ghép"
            : "Sửa thông tin bài đăng",
      ),
      body: Form(
        key: _formKey,
        child: Obx(
          () => controller.loadInit.value
              ? SahaLoadingFullScreen()
              : SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const Divider(),
                      SahaTextFieldNoBorder(
                        readOnly: isAdmin,
                        textInputType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        withAsterisk: true,
                        controller: controller.numberFindTenant,
                        onChanged: (v) {
                          controller.postReq.value.numberFindTenant =
                              int.tryParse(v!);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        labelText: "Số người tìm ghép",
                        hintText: "Nhập số người tìm ghép",
                      ),
                      InkWell(
                        onTap: () {

                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(
                                      top: 15,
                                      left: 10,
                                      right: 10,
                                      bottom: 10),
                                  child: Image.asset(
                                    'assets/icon_host/loai-phong.png',
                                    width: Get.width / 3.5,
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, left: 15),
                                  child: Wrap(
                                    children: [
                                      itemTypeRoom(
                                          type: MOTEL, title: "Trọ thường"),
                                      itemTypeRoom(
                                          type: MOTEL_COMPOUND,
                                          title: "Nguyên căn"),
                                      itemTypeRoom(
                                          type: HOME, title: "Chung cư"),
                                      itemTypeRoom(
                                          type: VILLA,
                                          title: "Chung cư mini"),
                                      itemTypeRoom(
                                          type: HOMESTAY, title: "Homestay"),
                                    ],
                                  )),
                              Obx(
                                () => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SelectImages(
                                    maxImage: 10,
                                    type: MO_POST_FILES_FOLDER,
                                    title: 'Ảnh phòng trọ',
                                    subTitle: 'Tối đa 10 hình',
                                    onUpload: () {
                                      controller.doneUploadImage.value =
                                          false;
                                    },
                                    images: controller.listImages.toList(),
                                    doneUpload: (List<ImageData> listImages) {
                                      print(
                                          "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                                      controller.listImages(listImages);
                                      if ((listImages
                                              .map((e) => e.linkImage ?? "x"))
                                          .toList()
                                          .contains('x')) {
                                        SahaAlert.showError(
                                            message: 'Lỗi ảnh');
                                        return;
                                      }
                                      controller.postReq.value.images =
                                          (listImages.map(
                                                  (e) => e.linkImage ?? ""))
                                              .toList();

                                      controller.doneUploadImage.value = true;
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Obx(
                                  () => VideoPickerSingle(
                                    linkVideo:
                                        controller.postReq.value.linkVideo,
                                    onChange: (File? file) async {
                                      controller.file = file;
                                      if (file == null) {
                                        controller.postReq.value.linkVideo =
                                            "";
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SahaDivide(),

                              InkWell(
                                onTap: () {
                                  SahaDialogApp.showDialogAddressChoose(
                                    hideAll: true,
                                    accept: () {},
                                    callback: (v) {
                                      controller.locationProvince.value = v;
                                      Get.back();
                                      SahaDialogApp.showDialogAddressChoose(
                                        hideAll: true,
                                        accept: () {},
                                        idProvince: controller
                                            .locationProvince.value.id,
                                        callback: (v) {
                                          controller.locationDistrict.value =
                                              v;
                                          Get.back();
                                          SahaDialogApp
                                              .showDialogAddressChoose(
                                            hideAll: true,
                                            accept: () {},
                                            idDistrict: controller
                                                .locationDistrict.value.id,
                                            callback: (v) {
                                              controller.locationWard.value =
                                                  v;
                                              Get.back();
                                              SahaDialogApp
                                                  .showDialogInputNote(
                                                      height: 50,
                                                      confirm: (v) {
                                                        if (v == null ||
                                                            v == "") {
                                                          SahaAlert
                                                              .showToastMiddle(
                                                                  message:
                                                                      "Vui lòng nhập địa chỉ chi tiết");
                                                        } else {
                                                          var province =
                                                              controller
                                                                  .locationProvince;
                                                          controller
                                                                  .postReq
                                                                  .value
                                                                  .province =
                                                              province
                                                                  .value.id;
                                                          var district =
                                                              controller
                                                                  .locationDistrict;
                                                          controller
                                                                  .postReq
                                                                  .value
                                                                  .district =
                                                              district
                                                                  .value.id;
                                                          var ward = controller
                                                              .locationWard;
                                                          controller
                                                                  .postReq
                                                                  .value
                                                                  .wards =
                                                              ward.value.id;
                                                          controller
                                                              .postReq
                                                              .value
                                                              .addressDetail = v;

                                                          controller.postReq
                                                              .refresh();
                                                          controller
                                                                  .addressTextEditingController
                                                                  .text =
                                                              "${controller.postReq.value.addressDetail} - ${ward.value.name} - ${district.value.name} - ${province.value.name}";
                                                        }
                                                      },
                                                      title:
                                                          "Địa chỉ chi tiết",
                                                      textInput: controller
                                                              .postReq
                                                              .value
                                                              .addressDetail ??
                                                          "");
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: SahaTextFieldNoBorder(
                                  enabled: false,
                                  labelText: "Địa chỉ",
                                  textInputType: TextInputType.text,
                                  controller:
                                      controller.addressTextEditingController,
                                  withAsterisk: true,
                                  onChanged: (v) {
                                    //addPostController.postReq.value.name = v;
                                  },
                                  hintText: "Chọn địa chỉ",
                                ),
                              ),
                              SahaDivide(),
                              SahaTextFieldNoBorder(
                                readOnly: false,
                                withAsterisk: true,
                                textInputType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller:
                                    controller.numberTenantCurrent,
                                onChanged: (v) {
                                  controller.postReq.value.numberTenantCurrent =
                                      int.parse(v!);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Không được để trống';
                                  }
                                  return null;
                                },
                                labelText: "Số người hiện tại",
                                hintText: "Nhập số người hiện tại",
                              ),
                              SahaDivide(),

                              SahaTextFieldNoBorder(
                                readOnly: false,
                                withAsterisk: true,
                                textInputType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9.,]+')),
                                ],
                                controller:
                                    controller.areaTextEditingController,
                                onChanged: (v) {
                                  controller.postReq.value.area =
                                      int.parse(v!);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Không được để trống';
                                  }
                                  return null;
                                },
                                labelText: "Diện tích (m²)",
                                hintText: "Nhập diện tích",
                              ),
                              SahaDivide(),
                              SahaTextFieldNoBorder(
                                readOnly: false,
                                textInputType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: controller.quantityVehicleParked,
                                onChanged: (v) {
                                  controller.postReq.value
                                      .quantityVehicleParked = int.parse(v!);
                                },
                                labelText: "Số chỗ để xe",
                                hintText: "Nhập sô chỗ để xe",
                              ),
                              SahaDivide(),
                              SahaTextFieldNoBorder(
                                readOnly: false,
                                withAsterisk: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textInputType: TextInputType.number,
                                controller: controller.numberFloor,
                                onChanged: (v) {
                                  controller.postReq.value.numberFloor =
                                      int.parse(v!);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Không được để trống';
                                  }
                                  return null;
                                },
                                labelText: "Tầng",
                                hintText: "Nhập số tầng",
                              ),
                              SahaDivide(),
                              SahaTextFieldNoBorder(
                                withAsterisk: true,
                                textInputType: TextInputType.phone,
                                controller: controller
                                    .phoneNumberTextEditingController,
                                onChanged: (v) {
                                  controller.postReq.value.phoneNumber = v;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Không được để trống';
                                  }
                                  return null;
                                },
                                labelText: "Số điện thoại",
                                hintText: "Nhập số điện thoại",
                              ),
                              SahaDivide(),
                              Padding(
                                padding: const EdgeInsets.all(
                                  16,
                                ),
                                child: InkWell(
                                  onTap: () {
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
                                                : controller.postReq.value
                                                            .sex ==
                                                        1
                                                    ? "Nam"
                                                    : controller.postReq.value
                                                                .sex ==
                                                            2
                                                        ? "Nữ"
                                                        : "Nam, nữ",
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                          Icons.keyboard_arrow_down_rounded)
                                    ],
                                  ),
                                ),
                              ),
                              SahaDivide(),

                              // Container(
                              //   padding: EdgeInsets.all(10),
                              //   child: Text(
                              //     "Các loại khoản tiền",
                              //     style: TextStyle(
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.w700,
                              //       color: Theme.of(context).primaryColor,
                              //     ),
                              //   ),
                              // ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: SahaTextFieldNoBorder(
                                      withAsterisk: true,
                                      textInputType: const TextInputType
                                          .numberWithOptions(decimal: true),
                                      inputFormatters: [ThousandsFormatter()],
                                      controller: controller
                                          .moneyTextEditingController,
                                      onChanged: (v) {
                                        controller.postReq.value.money =
                                            double.tryParse(SahaStringUtils()
                                                .convertFormatText(controller
                                                    .moneyTextEditingController
                                                    .text));
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Không được để trống';
                                        }
                                        return null;
                                      },
                                      labelText: "Giá phòng",
                                      hintText: "Nhập giá phòng",
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 15, right: 10),
                                    child: const Text(
                                      "VNĐ",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              SahaDivide(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: SahaTextFieldNoBorder(
                                      withAsterisk: true,
                                      textInputType: const TextInputType
                                          .numberWithOptions(decimal: true),
                                      inputFormatters: [ThousandsFormatter()],
                                      controller: controller
                                          .depositTextEditingController,
                                      onChanged: (v) {
                                        controller.postReq.value.deposit =
                                            double.tryParse(SahaStringUtils()
                                                .convertFormatText(controller
                                                    .depositTextEditingController
                                                    .text));
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Không được để trống';
                                        }
                                        return null;
                                      },
                                      labelText: "Tiền đặt cọc",
                                      hintText: "Nhập tiền đặt cọc",
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 15, right: 10),
                                    child: const Text(
                                      "VNĐ",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),

                              SahaDivide(),

                              SahaDivide(),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/icon_host/phi-dich-vu.png',
                                      width: Get.width / 3.5,
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Get.to(() => ChooseServiceScreen(
                                    //         listServiceInput:
                                    //             (addUpdatePostManagementController
                                    //                         .motelPostRequest
                                    //                         .value
                                    //                         .moServicesReq ??
                                    //                     [])
                                    //                 .toList(),
                                    //         onChoose: (List<Service> v) {
                                    //           addUpdatePostManagementController
                                    //               .motelPostRequest
                                    //               .value
                                    //               .moServicesReq = [];
                                    //           (addUpdatePostManagementController
                                    //                       .motelPostRequest
                                    //                       .value
                                    //                       .moServicesReq ??
                                    //                   [])
                                    //               .addAll(v);
                                    //           addUpdatePostManagementController
                                    //               .motelPostRequest
                                    //               .refresh();
                                    //         }));
                                    //   },
                                    //   child: Container(
                                    //     child: const Center(
                                    //         child: Icon(Icons.add)),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Obx(
                                () => (controller.postReq.value.moServices ??
                                            [])
                                        .isEmpty
                                    ? const SizedBox()
                                    : Center(
                                        child: Column(
                                          children: [
                                            Wrap(
                                              spacing: 10,
                                              runSpacing: 10,
                                              children: [
                                                ...(controller.postReq.value
                                                            .moServices ??
                                                        [])
                                                    .map((e) {
                                                  return itemService(
                                                      value: (controller
                                                                  .postReq
                                                                  .value
                                                                  .moServices ??
                                                              [])
                                                          .map((e) =>
                                                              e.serviceName)
                                                          .contains(
                                                              e.serviceName),
                                                      service: e,
                                                      onCheck: () {});
                                                }).toList()
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/icon_host/tien-nghi.png',
                                  width: Get.width / 4,
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
                                      itemUtilities(
                                          value: controller
                                                  .postReq.value.hasWc ??
                                              false,
                                          tile: "Vệ sinh khép kín",
                                          onCheck: () {
                                            controller.postReq.value.hasWc =
                                                !(controller.postReq.value
                                                        .hasWc ??
                                                    false);
                                          }),
                                      itemUtilities(
                                          value: controller.postReq.value
                                                  .hasMezzanine ??
                                              false,
                                          tile: "Gác xép",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasMezzanine = !(controller
                                                    .postReq
                                                    .value
                                                    .hasMezzanine ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller
                                                  .postReq.value.hasBalcony ??
                                              false,
                                          tile: "Ban công",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasBalcony = !(controller
                                                    .postReq
                                                    .value
                                                    .hasBalcony ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller.postReq.value
                                                  .hasFingerPrint ??
                                              false,
                                          tile: "Ra vào vân tay",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasFingerPrint = !(controller
                                                    .postReq
                                                    .value
                                                    .hasFingerPrint ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller.postReq.value
                                                  .hasOwnOwner ??
                                              false,
                                          tile: "Không chung chủ",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasOwnOwner = !(controller
                                                    .postReq
                                                    .value
                                                    .hasOwnOwner ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller
                                                  .postReq.value.hasPet ??
                                              false,
                                          tile: "Nuôi pet",
                                          onCheck: () {
                                            controller.postReq.value.hasPet =
                                                !(controller.postReq.value
                                                        .hasPet ??
                                                    false);
                                          }),
                                    ],
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
                                      itemUtilities(
                                          value: controller.postReq.value
                                                  .hasAirConditioner ??
                                              false,
                                          tile: "Điều hoà",
                                          onCheck: () {
                                            controller.postReq.value
                                                    .hasAirConditioner =
                                                !(controller.postReq.value
                                                        .hasAirConditioner ??
                                                    false);
                                          }),
                                      itemUtilities(
                                          value: controller.postReq.value
                                                  .hasWaterHeater ??
                                              false,
                                          tile: "Bình nóng lạnh",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasWaterHeater = !(controller
                                                    .postReq
                                                    .value
                                                    .hasWaterHeater ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller
                                                  .postReq.value.hasKitchen ??
                                              false,
                                          tile: "Kệ bếp",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasKitchen = !(controller
                                                    .postReq
                                                    .value
                                                    .hasKitchen ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller
                                                  .postReq.value.hasFridge ??
                                              false,
                                          tile: "Tủ lạnh",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasFridge = !(controller
                                                    .postReq
                                                    .value
                                                    .hasFridge ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller
                                                  .postReq.value.hasBed ??
                                              false,
                                          tile: "Giường ngủ",
                                          onCheck: () {
                                            controller.postReq.value.hasBed =
                                                !(controller.postReq.value
                                                        .hasBed ??
                                                    false);
                                          }),
                                      itemUtilities(
                                          value: controller.postReq.value
                                                  .hasWashingMachine ??
                                              false,
                                          tile: "Máy giặt",
                                          onCheck: () {
                                            controller.postReq.value
                                                    .hasWashingMachine =
                                                !(controller.postReq.value
                                                        .hasWashingMachine ??
                                                    false);
                                          }),
                                      itemUtilities(
                                          value: controller.postReq.value
                                                  .hasKitchenStuff ??
                                              false,
                                          tile: "Đồ dùng bếp",
                                          onCheck: () {
                                            controller.postReq.value
                                                    .hasKitchenStuff =
                                                !(controller.postReq.value
                                                        .hasKitchenStuff ??
                                                    false);
                                          }),
                                      itemUtilities(
                                          value: controller
                                                  .postReq.value.hasTable ??
                                              false,
                                          tile: "Bàn ghế",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasTable = !(controller
                                                    .postReq.value.hasTable ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller.postReq.value
                                                  .hasDecorativeLights ??
                                              false,
                                          tile: "Đèn trang trí",
                                          onCheck: () {
                                            controller.postReq.value
                                                    .hasDecorativeLights =
                                                !(controller.postReq.value
                                                        .hasDecorativeLights ??
                                                    false);
                                          }),
                                      itemUtilities(
                                          value: controller
                                                  .postReq.value.hasPicture ??
                                              false,
                                          tile: "Tranh trang trí",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasPicture = !(controller
                                                    .postReq
                                                    .value
                                                    .hasPicture ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller
                                                  .postReq.value.hasTree ??
                                              false,
                                          tile: "Cây cối trang trí",
                                          onCheck: () {
                                            controller.postReq.value.hasTree =
                                                !(controller.postReq.value
                                                        .hasTree ??
                                                    false);
                                          }),
                                      itemUtilities(
                                          value: controller
                                                  .postReq.value.hasPillow ??
                                              false,
                                          tile: "Chăn,ga gối",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasPillow = !(controller
                                                    .postReq
                                                    .value
                                                    .hasPillow ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller.postReq.value
                                                  .hasWardrobe ??
                                              false,
                                          tile: "Tủ quần áo",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasWardrobe = !(controller
                                                    .postReq
                                                    .value
                                                    .hasWardrobe ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller.postReq.value
                                                  .hasMattress ??
                                              false,
                                          tile: "Nệm",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasMattress = !(controller
                                                    .postReq
                                                    .value
                                                    .hasMattress ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller.postReq.value
                                                  .hasShoesRasks ??
                                              false,
                                          tile: "Kệ giày dép",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasShoesRasks = !(controller
                                                    .postReq
                                                    .value
                                                    .hasShoesRasks ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller
                                                  .postReq.value.hasCurtain ??
                                              false,
                                          tile: "Rèm",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasCurtain = !(controller
                                                    .postReq
                                                    .value
                                                    .hasCurtain ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller.postReq.value
                                                  .hasCeilingFans ??
                                              false,
                                          tile: "Quạt tràn",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasCeilingFans = !(controller
                                                    .postReq
                                                    .value
                                                    .hasCeilingFans ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller
                                                  .postReq.value.hasMirror ??
                                              false,
                                          tile: "Gương toàn thân",
                                          onCheck: () {
                                            controller.postReq.value
                                                .hasMirror = !(controller
                                                    .postReq
                                                    .value
                                                    .hasMirror ??
                                                false);
                                          }),
                                      itemUtilities(
                                          value: controller
                                                  .postReq.value.hasSofa ??
                                              false,
                                          tile: "Sofa",
                                          onCheck: () {
                                            controller.postReq.value.hasSofa =
                                                !(controller.postReq.value
                                                        .hasSofa ??
                                                    false);
                                          }),
                                    ],
                                  ),
                                ),
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
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              color: Theme.of(context).primaryColor,
              text: idPostRoommate == null
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
                    mess: idPostRoommate == null
                        ? "Bạn có chắc muốn thêm bài đăng này"
                        : "Bạn có chắc muốn cập nhật bài đăng này",
                    onClose: () {},
                    onOK: () {
                      if (idPostRoommate == null) {
                        controller.addPostRoommate();
                      } else {
                        controller.updatePostRoommate();
                      }
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemUtilities(
      {required bool value, required String tile, required Function onCheck}) {
    return InkWell(
      onTap: () {
        // onCheck();
        // addUpdatePostManagementController.motelPostRequest.refresh();
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

  Widget itemService(
      {required bool value,
      required Function onCheck,
      required Service service}) {
    return GestureDetector(
      onTap: () {
        onCheck();
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: (Get.width - 40) / 3,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: value
                      ? Theme.of(Get.context!).primaryColor
                      : Colors.grey[200]!),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  service.serviceIcon != null && service.serviceIcon!.isNotEmpty
                      ? service.serviceIcon ?? ""
                      : "",
                  width: 25,
                  height: 25,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    service.serviceName ?? "",
                  ),
                ),
                Text(
                  "${SahaStringUtils().convertToMoney(service.serviceCharge ?? "")}đ/${service.serviceUnit ?? ""}",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          // Positioned(
          //   right: -5,
          //   top: -5,
          //   child: InkWell(
          //     onTap: () {
          //       addUpdatePostManagementController
          //           .motelPostRequest.value.moServicesReq!
          //           .remove(service);
          //       addUpdatePostManagementController.motelPostRequest.refresh();
          //     },
          //     child: Container(
          //       padding: const EdgeInsets.all(3),
          //       decoration: const BoxDecoration(
          //         color: Colors.red,
          //         shape: BoxShape.circle,
          //       ),
          //       child: const Icon(
          //         Icons.clear_rounded,
          //         color: Colors.white,
          //         size: 15,
          //       ),
          //     ),
          //   ),
          // ),
          // Positioned(
          //     top: -5,
          //     left: -5,
          //     child: IconButton(
          //         onPressed: () {
          //           SahaDialogApp.showDialogInput(
          //             isNumber: true,
          //             textInput:
          //                 removeDecimalZeroFormat(service.serviceCharge!),
          //             onInput: (v) {
          //               service.serviceCharge = double.parse(
          //                   SahaStringUtils().convertFormatText(v));
          //               var index = addUpdatePostManagementController
          //                   .motelPostRequest.value.moServicesReq
          //                   ?.indexWhere((element) => element == service);
          //               addUpdatePostManagementController.motelPostRequest.value
          //                       .moServicesReq![index!].serviceCharge =
          //                   double.parse(
          //                       SahaStringUtils().convertFormatText(v));
          //               addUpdatePostManagementController.motelPostRequest
          //                   .refresh();
          //             },
          //             title: 'Sửa giá',
          //           );
          //         },
          //         icon: Icon(
          //           Icons.edit,
          //           color: Colors.grey[600],
          //         )))
        ],
      ),
    );
  }

  Widget itemTypeRoom({required int type, required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
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
