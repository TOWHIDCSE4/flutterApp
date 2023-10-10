import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/screen/admin/motel_room_admin/tower/add_tower/map/map_screen.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../../components/appbar/saha_appbar.dart';
import '../../../../../components/button/saha_button.dart';
import '../../../../../components/dialog/dialog.dart';
import '../../../../../components/divide/divide.dart';
import '../../../../../components/text_field/text_field_no_border.dart';
import '../../../../../components/widget/image/select_images.dart';
import '../../../../../components/widget/video_picker_single/video_picker_single.dart';
import '../../../../../const/motel_type.dart';
import '../../../../../const/type_image.dart';
import '../../../../../model/furniture.dart';
import '../../../../../model/image_assset.dart';
import '../../../../../model/service.dart';
import '../../../../../utils/string_utils.dart';
import '../../../../owner/choose_service/choose_service_screen.dart';
import '../../../../profile/bill/widget/dialog_add_service.dart';
import 'add_tower_controller.dart';

class AddTowerScreen extends StatelessWidget {
  AddTowerScreen({super.key, this.towerId}) {
    controller = AddTowerController(towerId: towerId);
  }
  late AddTowerController controller;
  final int? towerId;
  final _formKey = GlobalKey<FormState>();
  late Subscription subscription;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: towerId == null ? "Thêm toà nhà" : "Chỉnh sửa toà nhà",
        ),
        body: Obx(
          () => controller.loadInit.value
              ? SahaLoadingFullScreen()
              : Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SahaTextFieldNoBorder(
                          withAsterisk: true,
                          textInputType: TextInputType.text,
                          controller: controller.towerNameTextEditingController,
                          onChanged: (v) {
                            controller.towerReq.value.towerName = v;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                          labelText: "Tên toà nhà",
                          hintText: "Nhập tên toà nhà",
                        ),
                        SahaDivide(),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 15, left: 10, right: 10, bottom: 10),
                          child: Image.asset(
                            'assets/icon_host/loai-phong.png',
                            width: 120,
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(right: 15.0, left: 15),
                            child: Wrap(
                              children: [
                                itemTypeRoom(type: MOTEL, title: "Trọ thường"),
                                itemTypeRoom(
                                    type: MOTEL_COMPOUND, title: "Nguyên căn"),
                                itemTypeRoom(type: HOME, title: "Chung cư"),
                                itemTypeRoom(
                                    type: VILLA, title: "Chung cư mini"),
                                itemTypeRoom(type: HOMESTAY, title: "Homestay"),
                              ],
                            )),
                        // MultiImagePicker(
                        //   onChange: (list) {
                        //     print("=====> ssss${list}");
                        //   },
                        // ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SelectImages(
                              maxImage: 10,
                              type: MOTEL_FILES_FOLDER,
                              title: 'Ảnh phòng trọ',
                              subTitle: 'Tối đa 10 hình',
                              onUpload: () {
                                controller.doneUploadImage.value = false;
                              },
                              images: controller.listImages.toList(),
                              doneUpload: (List<ImageData> listImages) {
                                print(
                                    "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                                controller.listImages(listImages);
                                if ((listImages.map((e) => e.linkImage ?? "x"))
                                    .toList()
                                    .contains('x')) {
                                  SahaAlert.showError(message: 'Lỗi ảnh');
                                  return;
                                }
                                controller.towerReq.value.images = (listImages
                                    .map((e) => e.linkImage ?? "x")).toList();
                                print(controller.towerReq.value.images);
                                controller.doneUploadImage.value = true;
                              },
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Obx(
                            () => VideoPickerSingle(
                              linkVideo: controller.towerReq.value.videoLink,
                              onChange: (File? file) async {
                                controller.file = file;
                                if (file == null) {
                                  controller.towerReq.value.videoLink = null;
                                }
                              },
                            ),
                          ),
                        ),

                        SahaDivide(),

                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                onSelectAddress();
                              },
                              child: SahaTextFieldNoBorder(
                                enabled: false,
                                icon: const Icon(Icons.location_pin, color: Colors.transparent,),
                                labelText: "Địa chỉ",
                                textInputType: TextInputType.text,
                                controller: controller.addressTextEditingController,
                                withAsterisk: true,
                                onChanged: (v) {
                                  //addPostController.postReq.value.name = v;
                                },
                                hintText: "Chọn địa chỉ",
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    Get.to(() => const MapScreen());
                                  },
                                  icon: const Icon(Icons.location_pin),
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SahaDivide(),
                        SahaTextFieldNoBorder(
                          withAsterisk: false,
                          controller:
                              controller.descriptionTextEditingController,
                          onChanged: (v) {
                            controller.towerReq.value.description = v;
                          },
                          //maxLine: 2,

                          textInputType: TextInputType.multiline,
                          labelText: "Mô tả",
                          hintText: "Nhập mô tả",
                        ),
                        SahaDivide(),
                        // SahaTextFieldNoBorder(
                        //   withAsterisk: true,
                        //   textInputType:
                        //       const TextInputType.numberWithOptions(decimal: true),
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                        //   ],
                        //   controller: controller.capacityTextEditingController,
                        //   onChanged: (v) {
                        //     controller.towerReq.value.capacity = int.parse(v!);
                        //   },
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Không được để trống';
                        //     }
                        //     return null;
                        //   },
                        //   labelText: "Sức chứa (Người/Phòng)",
                        //   hintText: "Nhập số Người/Phòng",
                        // ),
                        // SahaDivide(),
                        // SahaTextFieldNoBorder(
                        //   withAsterisk: true,
                        //   textInputType:
                        //       const TextInputType.numberWithOptions(decimal: true),
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                        //   ],
                        //   controller: controller.areaTextEditingController,
                        //   onChanged: (v) {
                        //     controller.towerReq.value.area = int.parse(v!);
                        //   },
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Không được để trống';
                        //     }
                        //     return null;
                        //   },
                        //   labelText: "Diện tích (m²)",
                        //   hintText: "Nhập diện tích",
                        // ),
                        // SahaDivide(),
                        // SahaTextFieldNoBorder(
                        //   withAsterisk: true,
                        //   textInputType: TextInputType.number,
                        //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        //   controller: controller.numberFloor,
                        //   onChanged: (v) {
                        //     controller.towerReq.value.numberFloor = int.parse(v!);
                        //   },
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Không được để trống';
                        //     }
                        //     return null;
                        //   },
                        //   labelText: "Tầng",
                        //   hintText: "Nhập tầng",
                        // ),
                        // SahaDivide(),
                        SahaTextFieldNoBorder(
                          textInputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: controller.quantityVehicleParked,
                          onChanged: (v) {
                            controller.towerReq.value.quantityVehicleParked =
                                int.parse(v!);
                          },
                          labelText: "Số chỗ để xe",
                          hintText: "Nhập sô chỗ để xe",
                        ),
                        SahaDivide(),
                        SahaTextFieldNoBorder(
                          withAsterisk: true,
                          textInputType: TextInputType.phone,
                          controller:
                              controller.phoneNumberTextEditingController,
                          onChanged: (v) {
                            controller.towerReq.value.phoneNumber = v;
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
                                  controller.towerReq.value.sex = sex;
                                  controller.towerReq.refresh();
                                },
                                sex: controller.towerReq.value.sex ?? 0,
                              );
                            },
                            child: Row(
                              children: [
                                const Text(
                                  "Giới tính: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54,
                                  ),
                                ),
                                Expanded(
                                  child: Obx(
                                    () => Text(
                                      controller.towerReq.value.sex == 0
                                          ? "Nam, nữ"
                                          : controller.towerReq.value.sex == 1
                                              ? "Nam"
                                              : "Nữ",
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
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Expanded(
                        //       child: SahaTextFieldNoBorder(
                        //         withAsterisk: true,
                        //         textInputType:
                        //             const TextInputType.numberWithOptions(decimal: true),
                        //         inputFormatters: [ThousandsFormatter()],
                        //         controller: controller.moneyTextEditingController,
                        //         onChanged: (v) {
                        //           controller.towerReq.value.money = double.tryParse(
                        //               SahaStringUtils().convertFormatText(
                        //                   controller.moneyTextEditingController.text));
                        //         },
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'Không được để trống';
                        //           }
                        //           return null;
                        //         },
                        //         labelText: "Giá phòng",
                        //         hintText: "Nhập giá phòng",
                        //       ),
                        //     ),
                        //     Container(
                        //       margin: const EdgeInsets.only(bottom: 15, right: 10),
                        //       child: const Text(
                        //         "VNĐ",
                        //         style: TextStyle(
                        //             color: Colors.black54,
                        //             fontWeight: FontWeight.w500,
                        //             fontSize: 14),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SahaDivide(),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Expanded(
                        //       child: SahaTextFieldNoBorder(
                        //         withAsterisk: true,
                        //         textInputType:
                        //             const TextInputType.numberWithOptions(decimal: true),
                        //         inputFormatters: [ThousandsFormatter()],
                        //         controller: controller.depositTextEditingController,
                        //         onChanged: (v) {
                        //           controller.towerReq.value.deposit = double.tryParse(
                        //               SahaStringUtils().convertFormatText(
                        //                   controller.depositTextEditingController.text));
                        //         },
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'Không được để trống';
                        //           }
                        //           return null;
                        //         },
                        //         labelText: "Tiền đặt cọc",
                        //         hintText: "Nhập tiền đặt cọc",
                        //       ),
                        //     ),
                        //     Container(
                        //       margin: const EdgeInsets.only(bottom: 15, right: 10),
                        //       child: const Text(
                        //         "VNĐ",
                        //         style: TextStyle(
                        //             color: Colors.black54,
                        //             fontWeight: FontWeight.w500,
                        //             fontSize: 14),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SahaDivide(),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Expanded(
                        //       child: SahaTextFieldNoBorder(
                        //         textInputType:
                        //             TextInputType.numberWithOptions(decimal: true),
                        //         inputFormatters: [ThousandsFormatter()],
                        //         controller: addMotelRoomController.moneyCommissionAdmin,
                        //         onChanged: (v) {
                        //           addMotelRoomController
                        //                   .motelRoomRequest.value.moneyCommissionAdmin =
                        //               double.tryParse(SahaStringUtils()
                        //                   .convertFormatText(addMotelRoomController
                        //                       .moneyCommissionAdmin.text));
                        //         },
                        //         labelText: "Tiền hoa hồng",
                        //         hintText: "Nhập tiền hoa hồng",
                        //       ),
                        //     ),
                        //     Container(
                        //       margin: EdgeInsets.only(bottom: 15, right: 10),
                        //       child: Text(
                        //         "VNĐ",
                        //         style: TextStyle(
                        //             color: Colors.black54,
                        //             fontWeight: FontWeight.w500,
                        //             fontSize: 14),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SahaDivide(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10.0, left: 10, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/icon_host/phi-dich-vu.png',
                                width: 120,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => ChooseServiceScreen(
                                    isFromMotelManage: true,
                                      serviceInput: controller.listService,
                                      listServiceInput: (controller.towerReq
                                                  .value.moServicesReq ??
                                              [])
                                          .toList(),
                                      onChoose:
                                          (List<Service> v, List<Service> t) {
                                        controller
                                            .towerReq.value.moServicesReq = [];
                                        (controller.towerReq.value
                                                    .moServicesReq ??
                                                [])
                                            .addAll(v);
                                        controller.listService = t;
                                        controller.towerReq.refresh();
                                      }));
                                },
                                child: const Center(child: Icon(Icons.add)),
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => (controller.towerReq.value.moServicesReq ?? [])
                                  .isEmpty
                              ? Container()
                              : Center(
                                  child: Column(
                                    children: [
                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: [
                                          ...(controller.towerReq.value
                                                      .moServicesReq ??
                                                  [])
                                              .map((e) {
                                            return itemService(
                                                value: (controller
                                                            .towerReq
                                                            .value
                                                            .moServicesReq ??
                                                        [])
                                                    .map((e) => e.serviceName)
                                                    .contains(e.serviceName),
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
                          margin: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/icon_host/tien-nghi.png',
                            width: 120,
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
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                itemUtilities(
                                    value: controller.towerReq.value.hasWc ??
                                        false,
                                    tile: "Nhà vệ sinh",
                                    onCheck: () {
                                      controller.towerReq.value.hasWc =
                                          !(controller.towerReq.value.hasWc ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller
                                            .towerReq.value.hasMezzanine ??
                                        false,
                                    tile: "Gác xép",
                                    onCheck: () {
                                      controller.towerReq.value.hasMezzanine =
                                          !(controller.towerReq.value
                                                  .hasMezzanine ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.towerReq.value.hasBalcony ??
                                            false,
                                    tile: "Ban công",
                                    onCheck: () {
                                      controller.towerReq.value.hasBalcony =
                                          !(controller
                                                  .towerReq.value.hasBalcony ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller
                                            .towerReq.value.hasFingerPrint ??
                                        false,
                                    tile: "Ra vào vân tay",
                                    onCheck: () {
                                      controller.towerReq.value.hasFingerPrint =
                                          !(controller.towerReq.value
                                                  .hasFingerPrint ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.towerReq.value.hasOwnOwner ??
                                            false,
                                    tile: "Không chung chủ",
                                    onCheck: () {
                                      controller.towerReq.value.hasOwnOwner =
                                          !(controller
                                                  .towerReq.value.hasOwnOwner ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.towerReq.value.hasPet ??
                                        false,
                                    tile: "Nuôi Pet",
                                    onCheck: () {
                                      controller.towerReq.value.hasPet =
                                          !(controller.towerReq.value.hasPet ??
                                              false);
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/icon_host/noi-that.png',
                            width: 120,
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
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                itemUtilities(
                                    value: controller
                                            .towerReq.value.hasAirConditioner ??
                                        false,
                                    tile: "Điều hoà",
                                    onCheck: () {
                                      controller.towerReq.value
                                          .hasAirConditioner = !(controller
                                              .towerReq
                                              .value
                                              .hasAirConditioner ??
                                          false);
                                    }),
                                itemUtilities(
                                    value: controller
                                            .towerReq.value.hasWaterHeater ??
                                        false,
                                    tile: "Nóng lạnh",
                                    onCheck: () {
                                      controller.towerReq.value.hasWaterHeater =
                                          !(controller.towerReq.value
                                                  .hasWaterHeater ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.towerReq.value.hasKitchen ??
                                            false,
                                    tile: "Kệ bếp",
                                    onCheck: () {
                                      controller.towerReq.value.hasKitchen =
                                          !(controller
                                                  .towerReq.value.hasKitchen ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.towerReq.value.hasFridge ??
                                            false,
                                    tile: "Tủ lạnh",
                                    onCheck: () {
                                      controller.towerReq.value.hasFridge =
                                          !(controller
                                                  .towerReq.value.hasFridge ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.towerReq.value.hasBed ??
                                        false,
                                    tile: "Giường ngủ",
                                    onCheck: () {
                                      controller.towerReq.value.hasBed =
                                          !(controller.towerReq.value.hasBed ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller
                                            .towerReq.value.hasWashingMachine ??
                                        false,
                                    tile: "Máy giặt",
                                    onCheck: () {
                                      controller.towerReq.value
                                          .hasWashingMachine = !(controller
                                              .towerReq
                                              .value
                                              .hasWashingMachine ??
                                          false);
                                    }),
                                itemUtilities(
                                    value: controller
                                            .towerReq.value.hasKitchenStuff ??
                                        false,
                                    tile: "Đồ dùng bếp",
                                    onCheck: () {
                                      controller.towerReq.value
                                          .hasKitchenStuff = !(controller
                                              .towerReq.value.hasKitchenStuff ??
                                          false);
                                    }),
                                itemUtilities(
                                    value: controller.towerReq.value.hasTable ??
                                        false,
                                    tile: "Bàn ghế",
                                    onCheck: () {
                                      controller.towerReq.value.hasTable =
                                          !(controller
                                                  .towerReq.value.hasTable ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.towerReq.value
                                            .hasDecorativeLights ??
                                        false,
                                    tile: "Đèn trang trí",
                                    onCheck: () {
                                      controller.towerReq.value
                                          .hasDecorativeLights = !(controller
                                              .towerReq
                                              .value
                                              .hasDecorativeLights ??
                                          false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.towerReq.value.hasPicture ??
                                            false,
                                    tile: "Tranh trang trí",
                                    onCheck: () {
                                      controller.towerReq.value.hasPicture =
                                          !(controller
                                                  .towerReq.value.hasPicture ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.towerReq.value.hasTree ??
                                        false,
                                    tile: "Cây cối trang trí",
                                    onCheck: () {
                                      controller.towerReq.value.hasTree =
                                          !(controller.towerReq.value.hasTree ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.towerReq.value.hasPillow ??
                                            false,
                                    tile: "Chăn ga gối",
                                    onCheck: () {
                                      controller.towerReq.value.hasPillow =
                                          !(controller
                                                  .towerReq.value.hasPillow ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.towerReq.value.hasWardrobe ??
                                            false,
                                    tile: "Tủ quần áo",
                                    onCheck: () {
                                      controller.towerReq.value.hasWardrobe =
                                          !(controller
                                                  .towerReq.value.hasWardrobe ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.towerReq.value.hasMattress ??
                                            false,
                                    tile: "Nệm",
                                    onCheck: () {
                                      controller.towerReq.value.hasMattress =
                                          !(controller
                                                  .towerReq.value.hasMattress ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller
                                            .towerReq.value.hasShoesRasks ??
                                        false,
                                    tile: "Kệ giày dép",
                                    onCheck: () {
                                      controller.towerReq.value.hasShoesRasks =
                                          !(controller.towerReq.value
                                                  .hasShoesRasks ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.towerReq.value.hasCurtain ??
                                            false,
                                    tile: "Rèm",
                                    onCheck: () {
                                      controller.towerReq.value.hasCurtain =
                                          !(controller
                                                  .towerReq.value.hasCurtain ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller
                                            .towerReq.value.hasCeilingFans ??
                                        false,
                                    tile: "Quạt trần",
                                    onCheck: () {
                                      controller.towerReq.value.hasCeilingFans =
                                          !(controller.towerReq.value
                                                  .hasCeilingFans ??
                                              false);
                                    }),
                                itemUtilities(
                                    value:
                                        controller.towerReq.value.hasMirror ??
                                            false,
                                    tile: "Gương toàn thân",
                                    onCheck: () {
                                      controller.towerReq.value.hasMirror =
                                          !(controller
                                                  .towerReq.value.hasMirror ??
                                              false);
                                    }),
                                itemUtilities(
                                    value: controller.towerReq.value.hasSofa ??
                                        false,
                                    tile: "Sofa",
                                    onCheck: () {
                                      controller.towerReq.value.hasSofa =
                                          !(controller.towerReq.value.hasSofa ??
                                              false);
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10.0, left: 10, top: 10, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Liệt kê số lượng nội thất trong phòng",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  DialogAddService.showDialogFurnitureInput(
                                      onDone: (name, quantity) {
                                    controller.towerReq.value.furniture!.add(
                                        Furniture(
                                            name: name,
                                            quantity: int.parse(quantity)));

                                    controller.towerReq.refresh();
                                    Get.back();
                                  });
                                },
                                child: const Center(child: Icon(Icons.add)),
                              ),
                            ],
                          ),
                        ),

                        Obx(
                          () => (controller.towerReq.value.furniture ?? [])
                                  .isEmpty
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0,
                                      left: 15,
                                      top: 0,
                                      bottom: 10),
                                  child: Column(
                                    children: [
                                      ...(controller.towerReq.value.furniture ??
                                              [])
                                          .map((e) => itemFurniture(
                                              e,
                                              (controller.towerReq.value
                                                          .furniture ??
                                                      [])
                                                  .indexOf(e)))
                                    ],
                                  ),
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
                text: towerId == null ? "Thêm toà nhà" : 'Chỉnh sửa',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if ((controller.towerReq.value.moServicesReq ?? [])
                        .isEmpty) {
                      SahaAlert.showError(message: "Vui lòng thêm phí dịch vụ");
                    } else {
                      if (towerId == null) {
                        controller.addTower();
                      } else {
                        controller.updateTower();
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSelectAddress() {
    SahaDialogApp.showDialogAddressChoose(
      hideAll: true,
      accept: () {},
      callback: (v) {
        controller.locationProvince.value = v;
        controller.towerReq.value.province = v.id;
        Get.back();
        SahaDialogApp.showDialogAddressChoose(
          hideAll: true,
          accept: () {},
          idProvince: controller.locationProvince.value.id,
          callback: (v) {
            controller.locationDistrict.value = v;
            controller.towerReq.value.district = v.id;
            Get.back();
            SahaDialogApp.showDialogAddressChoose(
              hideAll: true,
              accept: () {},
              idDistrict: controller.locationDistrict.value.id,
              callback: (v) {
                controller.locationWard.value = v;
                controller.towerReq.value.wards = v.id;
                Get.back();
                SahaDialogApp.showDialogInputNote(
                    height: 50,
                    confirm: (v) {
                      if (v == null || v == "") {
                        SahaAlert.showToastMiddle(
                            message: "Vui lòng nhập địa chỉ chi tiết");
                      } else {
                        controller.towerReq.value.addressDetail = v;
                        controller.towerReq.refresh();
                        var province = controller.locationProvince;
                        var district = controller.locationDistrict;
                        var ward = controller.locationWard;
                        controller.addressTextEditingController.text =
                            "${controller.towerReq.value.addressDetail} - ${ward.value.name} - ${district.value.name} - ${province.value.name}";
                      }
                    },
                    title: "Địa chỉ chi tiết",
                    textInput: controller.towerReq.value.addressDetail ?? "");
              },
            );
          },
        );
      },
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
            height: 140,
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.2,
                      letterSpacing: 0.1,
                    ),
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
          Positioned(
            right: -5,
            top: -5,
            child: InkWell(
              onTap: () {
                controller.towerReq.value.moServicesReq!.remove(service);
                controller.towerReq.refresh();
              },
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.clear_rounded,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ),
          Positioned(
              top: -5,
              left: -5,
              child: IconButton(
                  onPressed: () {
                    SahaDialogApp.showDialogInput(
                      isNumber: true,
                      textInput:
                          removeDecimalZeroFormat(service.serviceCharge!),
                      onInput: (v) {
                        service.serviceCharge = double.parse(
                            SahaStringUtils().convertFormatText(v));
                        var index = controller.towerReq.value.moServicesReq
                            ?.indexWhere((element) =>
                                element.serviceName == service.serviceName);
                        controller.towerReq.value.moServicesReq![index!]
                                .serviceCharge =
                            double.parse(
                                SahaStringUtils().convertFormatText(v));
                        controller.towerReq.refresh();
                      },
                      title: 'Sửa giá',
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey[600],
                  )))
        ],
      ),
    );
  }

  Widget itemUtilities(
      {required bool value, required String tile, required Function onCheck}) {
    return InkWell(
      onTap: () {
        onCheck();
        controller.towerReq.refresh();
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

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  Widget itemFurniture(Furniture furniture, int index) {
    return InkWell(
      onTap: () {
        DialogAddService.showDialogFurnitureInput(
            isFix: true,
            nameService: furniture.name,
            quantity: furniture.quantity,
            onDone: (name, quantity) {
              (controller.towerReq.value.furniture ?? [])[index] =
                  Furniture(name: name, quantity: int.parse(quantity));

              controller.towerReq.refresh();
              Get.back();
            });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: Colors.blue,
                  size: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  furniture.name ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Text(furniture.quantity.toString()),
                IconButton(
                    onPressed: () {
                      (controller.towerReq.value.furniture ?? [])
                          .removeAt(index);
                      controller.towerReq.refresh();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget itemTypeRoom({required int type, required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          controller.towerReq.value.type = type;
          controller.towerReq.refresh();
        },
        child: Stack(
          children: [
            Container(
              width: Get.width / 3 - 26,
              decoration: BoxDecoration(
                border: Border.all(
                    color: controller.towerReq.value.type == type
                        ? Theme.of(Get.context!).primaryColor
                        : Colors.grey[200]!),
                color: controller.towerReq.value.type == type
                    ? Colors.white
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                boxShadow: controller.towerReq.value.type == type
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
                child: Text(
                  title,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            if (controller.towerReq.value.type == type)
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
