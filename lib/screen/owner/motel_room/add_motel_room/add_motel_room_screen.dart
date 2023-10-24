import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/button/saha_button.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/motel_type.dart';
import 'package:gohomy/model/motel_room.dart';
import 'package:gohomy/screen/admin/motel_room_admin/tower/add_tower/map/map_screen.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/profile/bill/widget/dialog_add_service.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/dialog/dialog.dart';
import '../../../../components/divide/divide.dart';
import '../../../../components/text_field/text_field_no_border.dart';
import '../../../../components/widget/image/select_images.dart';
import '../../../../components/widget/video_picker_single/video_picker_single.dart';
import '../../../../const/type_image.dart';
import '../../../../model/furniture.dart';
import '../../../../model/image_assset.dart';
import '../../../../model/service.dart';
import '../../../../model/tower.dart';
import '../../../../utils/string_utils.dart';
import '../../choose_service/choose_service_screen.dart';
import '../../contract/add_contract/add_contract_screen.dart';
import '../../post_management/add_update_post_management/add_update_post_management_screen.dart';
import '../choose_tower/choose_tower_screen.dart';
import '../list_motel_room_controller.dart';
import 'add_motel_room_controller.dart';

class AddMotelRoomScreen extends StatelessWidget {
  ListMotelRoomController listMotelRoomController =
      Get.put(ListMotelRoomController());
  late AddMotelRoomController addMotelRoomController;
  MotelRoom? motelRoomInput;
  final _formKey = GlobalKey<FormState>();
  DataAppController dataAppController = Get.find();
  bool? isFromChooseRoom;
  bool? isHaveTower;
  Tower? towerInput;
  bool? isFromPost;

  AddMotelRoomScreen(
      {this.motelRoomInput,
      this.isFromChooseRoom,
      this.isHaveTower,
      this.towerInput,
      this.isFromPost}) {
    addMotelRoomController = AddMotelRoomController(
        motelRoomInput: motelRoomInput,
        towerInput: towerInput,
        isFromPost: isFromPost);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            motelRoomInput != null ? "Sửa thông tin" : "Thêm Phòng trọ",
          ),
          leading: IconButton(
            onPressed: () {
              if (addMotelRoomController.isDraft == true &&
                  motelRoomInput == null) {
                SahaDialogApp.showDialogYesNo(
                    mess:
                        "Bạn chưa thêm phòng, bạn có muốn lưu vào bản nháp không ?",
                    onOK: () {
                      addMotelRoomController.motelRoomRequest.value.status = 3;
                      addMotelRoomController.addMotelRoom();
                    },
                    onClose: () {
                      Get.back();
                    });
              } else {
                Get.back();
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          actions: [
            motelRoomInput != null
                ? GestureDetector(
                    onTap: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: "Bạn có chắc muốn xoá phòng trọ",
                          onClose: () {
                            Get.back();
                          },
                          onOK: () {
                            listMotelRoomController
                                .deleteMotelRoom(
                                    motelRoomId: addMotelRoomController
                                        .motelRoomRequest.value.id!)
                                .then((value) => {
                                      listMotelRoomController.getAllMotelRoom(
                                          isRefresh: true)
                                    });
                          });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: const Icon(
                        FontAwesomeIcons.trashCan,
                      ),
                    ),
                  )
                : Container(),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // begin: Alignment.bottomLeft,
                  // end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SahaTextFieldNoBorder(
                  withAsterisk: true,
                  textInputType: TextInputType.text,
                  controller:
                      addMotelRoomController.roomNumberTextEditingController,
                  onChanged: (v) {
                    addMotelRoomController.motelRoomRequest.value.motelName = v;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Không được để trống';
                    }
                    return null;
                  },
                  labelText: "Số/Tên phòng",
                  hintText: "Nhập số/tên phòng",
                ),
                SahaDivide(),
                SahaTextFieldNoBorder(
                  withAsterisk: true,
                  textInputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: addMotelRoomController.numberFloor,
                  onChanged: (v) {
                    addMotelRoomController.motelRoomRequest.value.numberFloor =
                        int.parse(v!);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Không được để trống';
                    }
                    return null;
                  },
                  labelText: "Tầng",
                  hintText: "Nhập tầng",
                ),
                SahaDivide(),
                SahaTextFieldNoBorder(
                  withAsterisk: true,
                  textInputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                  ],
                  controller: addMotelRoomController.areaTextEditingController,
                  onChanged: (v) {
                    addMotelRoomController.motelRoomRequest.value.area =
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
                  withAsterisk: true,
                  textInputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                  ],
                  controller:
                      addMotelRoomController.capacityTextEditingController,
                  onChanged: (v) {
                    addMotelRoomController.motelRoomRequest.value.capacity =
                        int.parse(v!);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Không được để trống';
                    }
                    return null;
                  },
                  labelText: "Sức chứa (Người/Phòng)",
                  hintText: "Nhập số Người/Phòng",
                ),
                SahaDivide(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SahaTextFieldNoBorder(
                        withAsterisk: true,
                        textInputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [ThousandsFormatter()],
                        controller:
                            addMotelRoomController.moneyTextEditingController,
                        onChanged: (v) {
                          addMotelRoomController.motelRoomRequest.value.money =
                              double.tryParse(SahaStringUtils()
                                  .convertFormatText(addMotelRoomController
                                      .moneyTextEditingController.text));
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
                      margin: const EdgeInsets.only(bottom: 15, right: 10),
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
                        textInputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [ThousandsFormatter()],
                        controller:
                            addMotelRoomController.depositTextEditingController,
                        onChanged: (v) {
                          addMotelRoomController
                                  .motelRoomRequest.value.deposit =
                              double.tryParse(SahaStringUtils()
                                  .convertFormatText(addMotelRoomController
                                      .depositTextEditingController.text));
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
                      margin: const EdgeInsets.only(bottom: 15, right: 10),
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
                //////////////Chọn toà nhà
                ///
                ///
                //if (isHaveTower == true)
                InkWell(
                  onTap: () {
                    Get.to(() => ChooseTowerScreen(
                          towerChoose: addMotelRoomController.towerSelected,
                          onChoose: (Tower tower) {
                            addMotelRoomController.towerName.text =
                                tower.towerName ?? 'Chưa có thông tin';
                            addMotelRoomController.towerSelected = tower;
                            addMotelRoomController
                                .motelRoomRequest.value.towerId = tower.id;
                            addMotelRoomController.convertInfoFromTower();
                          },
                        ));
                  },
                  child: SahaTextFieldNoBorder(
                    enabled: false,
                    controller: addMotelRoomController.towerName,
                    labelText: "Tên toà nhà",
                    hintText: "Chọn toà nhà",
                  ),
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
                Obx(
                  () => Padding(
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
                ),
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
                        addMotelRoomController.doneUploadImage.value = false;
                      },
                      images: addMotelRoomController.listImages.toList(),
                      doneUpload: (List<ImageData> listImages) {
                        print(
                            "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                        addMotelRoomController.listImages(listImages);
                        if ((listImages.map((e) => e.linkImage ?? "x"))
                            .toList()
                            .contains('x')) {
                          SahaAlert.showError(message: 'Lỗi ảnh');
                          return;
                        }
                        addMotelRoomController.motelRoomRequest.value.images =
                            (listImages.map((e) => e.linkImage ?? "x"))
                                .toList();
                        print(addMotelRoomController
                            .motelRoomRequest.value.images);
                        addMotelRoomController.doneUploadImage.value = true;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Obx(
                    () => VideoPickerSingle(
                      linkVideo: addMotelRoomController
                          .motelRoomRequest.value.videoLink,
                      onChange: (File? file) async {
                        addMotelRoomController.file = file;
                        if (file == null) {
                          addMotelRoomController
                              .motelRoomRequest.value.videoLink = null;
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
                        SahaDialogApp.showDialogAddressChoose(
                          hideAll: true,
                          accept: () {},
                          callback: (v) {
                            addMotelRoomController.locationProvince.value = v;
                            addMotelRoomController
                                .motelRoomRequest.value.province = v.id;
                            Get.back();
                            SahaDialogApp.showDialogAddressChoose(
                              hideAll: true,
                              accept: () {},
                              idProvince: addMotelRoomController
                                  .locationProvince.value.id,
                              callback: (v) {
                                addMotelRoomController.locationDistrict.value =
                                    v;
                                addMotelRoomController
                                    .motelRoomRequest.value.district = v.id;
                                Get.back();
                                SahaDialogApp.showDialogAddressChoose(
                                  hideAll: true,
                                  accept: () {},
                                  idDistrict: addMotelRoomController
                                      .locationDistrict.value.id,
                                  callback: (v) {
                                    addMotelRoomController.locationWard.value =
                                        v;
                                    addMotelRoomController
                                        .motelRoomRequest.value.wards = v.id;
                                    Get.back();
                                    SahaDialogApp.showDialogInputNote(
                                        height: 50,
                                        confirm: (v) {
                                          if (v == null || v == "") {
                                            SahaAlert.showToastMiddle(
                                                message:
                                                    "Vui lòng nhập địa chỉ chi tiết");
                                          } else {
                                            addMotelRoomController
                                                .motelRoomRequest
                                                .value
                                                .addressDetail = v;
                                            addMotelRoomController
                                                .motelRoomRequest
                                                .refresh();
                                            var province =
                                                addMotelRoomController
                                                    .locationProvince;
                                            var district =
                                                addMotelRoomController
                                                    .locationDistrict;
                                            var ward = addMotelRoomController
                                                .locationWard;
                                            addMotelRoomController
                                                    .addressTextEditingController
                                                    .text =
                                                "${addMotelRoomController.motelRoomRequest.value.addressDetail} - ${ward.value.name} - ${district.value.name} - ${province.value.name}";
                                          }
                                        },
                                        title: "Địa chỉ chi tiết",
                                        textInput: addMotelRoomController
                                                .motelRoomRequest
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
                        icon: const Icon(
                          Icons.location_pin,
                          color: Colors.transparent,
                        ),
                        labelText: "Địa chỉ",
                        textInputType: TextInputType.text,
                        controller:
                            addMotelRoomController.addressTextEditingController,
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
                            Get.to(() => MapScreen(
                                  selectedAddress: (selectedAddress) {
                                    addMotelRoomController
                                        .addressTextEditingController
                                        .text = selectedAddress;
                                  },
                                ));
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
                      addMotelRoomController.descriptionTextEditingController,
                  onChanged: (v) {
                    addMotelRoomController.motelRoomRequest.value.description =
                        v;
                  },
                  //maxLine: 2,

                  textInputType: TextInputType.multiline,
                  labelText: "Mô tả",
                  hintText: "Nhập mô tả",
                ),
                SahaDivide(),

                SahaTextFieldNoBorder(
                  textInputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: addMotelRoomController.quantityVehicleParked,
                  onChanged: (v) {
                    addMotelRoomController.motelRoomRequest.value
                        .quantityVehicleParked = int.parse(v!);
                  },
                  labelText: "Số chỗ để xe",
                  hintText: "Nhập sô chỗ để xe",
                ),
                SahaDivide(),
                SahaTextFieldNoBorder(
                  withAsterisk: true,
                  textInputType: TextInputType.phone,
                  controller:
                      addMotelRoomController.phoneNumberTextEditingController,
                  onChanged: (v) {
                    addMotelRoomController.motelRoomRequest.value.phoneNumber =
                        v;
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
                          addMotelRoomController.motelRoomRequest.value.sex =
                              sex;
                          addMotelRoomController.motelRoomRequest.refresh();
                        },
                        sex:
                            addMotelRoomController.motelRoomRequest.value.sex ??
                                0,
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
                              addMotelRoomController
                                          .motelRoomRequest.value.sex ==
                                      0
                                  ? "Nam, nữ"
                                  : addMotelRoomController
                                              .motelRoomRequest.value.sex ==
                                          1
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
                              serviceInput: addMotelRoomController.listService,
                              listServiceInput: (addMotelRoomController
                                          .motelRoomRequest
                                          .value
                                          .moServicesReq ??
                                      [])
                                  .toList(),
                              isFromMotelManage: true,
                              onChoose: (List<Service> v, List<Service> t) {
                                addMotelRoomController
                                    .motelRoomRequest.value.moServicesReq = [];
                                (addMotelRoomController.motelRoomRequest.value
                                            .moServicesReq ??
                                        [])
                                    .addAll(v);
                                addMotelRoomController.listService = t;
                                addMotelRoomController.motelRoomRequest
                                    .refresh();
                              }));
                        },
                        child: const Center(child: Icon(Icons.add)),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => (addMotelRoomController
                                  .motelRoomRequest.value.moServicesReq ??
                              [])
                          .isEmpty
                      ? Container()
                      : Center(
                          child: Column(
                            children: [
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  ...(addMotelRoomController.motelRoomRequest
                                              .value.moServicesReq ??
                                          [])
                                      .map((e) {
                                    return itemService(
                                        value: (addMotelRoomController
                                                    .motelRoomRequest
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
                  padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  child: Obx(
                    () => Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasWc ??
                                false,
                            tile: "Nhà vệ sinh",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasWc = !(addMotelRoomController
                                      .motelRoomRequest.value.hasWc ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasMezzanine ??
                                false,
                            tile: "Gác xép",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasMezzanine = !(addMotelRoomController
                                      .motelRoomRequest.value.hasMezzanine ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasBalcony ??
                                false,
                            tile: "Ban công",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasBalcony = !(addMotelRoomController
                                      .motelRoomRequest.value.hasBalcony ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasFingerprint ??
                                false,
                            tile: "Ra vào vân tay",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasFingerprint = !(addMotelRoomController
                                      .motelRoomRequest.value.hasFingerprint ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasOwnOwner ??
                                false,
                            tile: "Không chung chủ",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasOwnOwner = !(addMotelRoomController
                                      .motelRoomRequest.value.hasOwnOwner ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasPet ??
                                false,
                            tile: "Nuôi Pet",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasPet = !(addMotelRoomController
                                      .motelRoomRequest.value.hasPet ??
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
                  padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  child: Obx(
                    () => Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasAirConditioner ??
                                false,
                            tile: "Điều hoà",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasAirConditioner = !(addMotelRoomController
                                      .motelRoomRequest
                                      .value
                                      .hasAirConditioner ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasWaterHeater ??
                                false,
                            tile: "Nóng lạnh",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasWaterHeater = !(addMotelRoomController
                                      .motelRoomRequest.value.hasWaterHeater ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasKitchen ??
                                false,
                            tile: "Kệ bếp",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasKitchen = !(addMotelRoomController
                                      .motelRoomRequest.value.hasKitchen ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasFridge ??
                                false,
                            tile: "Tủ lạnh",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasFridge = !(addMotelRoomController
                                      .motelRoomRequest.value.hasFridge ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasBed ??
                                false,
                            tile: "Giường ngủ",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasBed = !(addMotelRoomController
                                      .motelRoomRequest.value.hasBed ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasWashingMachine ??
                                false,
                            tile: "Máy giặt",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasWashingMachine = !(addMotelRoomController
                                      .motelRoomRequest
                                      .value
                                      .hasWashingMachine ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasKitchenStuff ??
                                false,
                            tile: "Đồ dùng bếp",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasKitchenStuff = !(addMotelRoomController
                                      .motelRoomRequest.value.hasKitchenStuff ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasTable ??
                                false,
                            tile: "Bàn ghế",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasTable = !(addMotelRoomController
                                      .motelRoomRequest.value.hasTable ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController.motelRoomRequest.value
                                    .hasDecorativeLights ??
                                false,
                            tile: "Đèn trang trí",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                      .hasDecorativeLights =
                                  !(addMotelRoomController.motelRoomRequest
                                          .value.hasDecorativeLights ??
                                      false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasPicture ??
                                false,
                            tile: "Tranh trang trí",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasPicture = !(addMotelRoomController
                                      .motelRoomRequest.value.hasPicture ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasTree ??
                                false,
                            tile: "Cây cối trang trí",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasTree = !(addMotelRoomController
                                      .motelRoomRequest.value.hasTree ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasPillow ??
                                false,
                            tile: "Chăn ga gối",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasPillow = !(addMotelRoomController
                                      .motelRoomRequest.value.hasPillow ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasWardrobe ??
                                false,
                            tile: "Tủ quần áo",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasWardrobe = !(addMotelRoomController
                                      .motelRoomRequest.value.hasWardrobe ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasMattress ??
                                false,
                            tile: "Nệm",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasMattress = !(addMotelRoomController
                                      .motelRoomRequest.value.hasMattress ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasShoesRacks ??
                                false,
                            tile: "Kệ giày dép",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasShoesRacks = !(addMotelRoomController
                                      .motelRoomRequest.value.hasShoesRacks ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasCurtain ??
                                false,
                            tile: "Rèm",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasCurtain = !(addMotelRoomController
                                      .motelRoomRequest.value.hasCurtain ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasCeilingFans ??
                                false,
                            tile: "Quạt trần",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasCeilingFans = !(addMotelRoomController
                                      .motelRoomRequest.value.hasCeilingFans ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasMirror ??
                                false,
                            tile: "Gương toàn thân",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasMirror = !(addMotelRoomController
                                      .motelRoomRequest.value.hasMirror ??
                                  false);
                            }),
                        itemUtilities(
                            value: addMotelRoomController
                                    .motelRoomRequest.value.hasSofa ??
                                false,
                            tile: "Sofa",
                            onCheck: () {
                              addMotelRoomController.motelRoomRequest.value
                                  .hasSofa = !(addMotelRoomController
                                      .motelRoomRequest.value.hasSofa ??
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
                            addMotelRoomController
                                .motelRoomRequest.value.furniture!
                                .add(Furniture(
                                    name: name, quantity: int.parse(quantity)));

                            addMotelRoomController.motelRoomRequest.refresh();
                            Get.back();
                          });
                        },
                        child: const Center(child: Icon(Icons.add)),
                      ),
                    ],
                  ),
                ),

                Obx(
                  () => (addMotelRoomController
                                  .motelRoomRequest.value.furniture ??
                              [])
                          .isEmpty
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15, top: 0, bottom: 10),
                          child: Column(
                            children: [
                              ...(addMotelRoomController
                                          .motelRoomRequest.value.furniture ??
                                      [])
                                  .map((e) => itemFurniture(
                                      e,
                                      (addMotelRoomController.motelRoomRequest
                                                  .value.furniture ??
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
        bottomNavigationBar: motelRoomInput == null
            ? Obx(
                () => SizedBox(
                  height: 65,
                  child: Column(
                    children: [
                      SahaButtonFullParent(
                        color: addMotelRoomController.doneUploadImage.value
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        text: 'Thêm phòng trọ',
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          //   addMotelRoomController.addMotelRoom();
                          // }
                          if (addMotelRoomController.doneUploadImage.value ==
                              true) {
                            addMotelRoomController.isDraft = false;
                            addMotelRoomController.addMotelRoom();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox(
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SahaButtonFullParent(
                        color: Theme.of(context).primaryColor,
                        text: 'Chỉnh sửa',
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          //   addMotelRoomController.updateMotelRoom();
                          // }
                          addMotelRoomController.updateMotelRoom();
                        },
                      ),
                    ),
                    if (motelRoomInput?.hasPost != true &&
                        isFromChooseRoom != true &&
                        motelRoomInput?.status != 3 &&
                        motelRoomInput?.towerId == null)
                      SahaButtonFullParent(
                        color: dataAppController
                                        .currentUser.value.decentralization ==
                                    null ||
                                (dataAppController.currentUser.value
                                            .decentralization?.manageMoPost ??
                                        false) ==
                                    true
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        text: 'Đăng tin',
                        onPressed: () {
                          if (motelRoomInput?.userId !=
                              dataAppController.currentUser.value.id) {
                            SahaAlert.showError(
                                message: 'Bạn không có quyền đăng bài');
                            return;
                          }
                          if (dataAppController
                                      .currentUser.value.decentralization ==
                                  null ||
                              (dataAppController.currentUser.value
                                          .decentralization?.manageMoPost ??
                                      false) ==
                                  true) {
                            Get.to(() => AddUpdatePostManagementScreen(
                                  motelRoomInput: motelRoomInput,
                                ));
                            //Navigator.push(context,MaterialPageRoute(builder:(_) => AddUpdatePostManagementScreen(motelRoomInput: motelRoomInput,) ));
                          } else {
                            SahaAlert.showError(
                                message: 'Bạn không có quyền đăng bài');
                          }
                        },
                      ),
                    if (motelRoomInput?.hasContract != true &&
                        isFromChooseRoom != true &&
                        motelRoomInput?.status != 3)
                      Expanded(
                        child: SahaButtonFullParent(
                          color: dataAppController
                                          .currentUser.value.decentralization ==
                                      null ||
                                  (dataAppController
                                              .currentUser
                                              .value
                                              .decentralization
                                              ?.manageContract ??
                                          false) ==
                                      true
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          text: 'Tạo hợp đồng',
                          onPressed: () {
                            if (dataAppController
                                        .currentUser.value.decentralization ==
                                    null ||
                                (dataAppController.currentUser.value
                                            .decentralization?.manageContract ??
                                        false) ==
                                    true) {
                              Get.to(() => AddContractScreen(
                                    motelRoomInput: motelRoomInput,
                                  ));
                            } else {
                              SahaAlert.showError(
                                  message: 'Bạn không có quyền tạo hợp đồng');
                            }
                          },
                        ),
                      ),
                  ],
                ),
              ),
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
                addMotelRoomController.motelRoomRequest.value.moServicesReq!
                    .remove(service);
                addMotelRoomController.motelRoomRequest.refresh();
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
                    SahaDialogApp.showDialogFixService(
                      isNumber: true,
                      textInput:
                          removeDecimalZeroFormat(service.serviceCharge!),
                      onInput: (v) {
                        service.serviceCharge = double.parse(
                            SahaStringUtils().convertFormatText(v));
                        var index = addMotelRoomController
                            .motelRoomRequest.value.moServicesReq
                            ?.indexWhere((element) =>
                                element.serviceName == service.serviceName);
                        addMotelRoomController.motelRoomRequest.value
                                .moServicesReq![index!].serviceCharge =
                            double.parse(
                                SahaStringUtils().convertFormatText(v));
                        addMotelRoomController.motelRoomRequest.refresh();
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
        addMotelRoomController.motelRoomRequest.refresh();
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

  String? textTime(int hour, int minute) {
    return "${hour < 10 ? "0$hour" : hour}:${minute < 10 ? "0$minute" : minute}";
  }

  Widget itemFurniture(Furniture furniture, int index) {
    return InkWell(
      onTap: () {
        DialogAddService.showDialogFurnitureInput(
            isFix: true,
            nameService: furniture.name,
            quantity: furniture.quantity,
            onDone: (name, quantity) {
              (addMotelRoomController.motelRoomRequest.value.furniture ??
                      [])[index] =
                  Furniture(name: name, quantity: int.parse(quantity));

              addMotelRoomController.motelRoomRequest.refresh();
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
                      (addMotelRoomController
                                  .motelRoomRequest.value.furniture ??
                              [])
                          .removeAt(index);
                      addMotelRoomController.motelRoomRequest.refresh();
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

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  Widget itemTypeRoom({required int type, required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          addMotelRoomController.motelRoomRequest.value.type = type;
          addMotelRoomController.motelRoomRequest.refresh();
        },
        child: Stack(
          children: [
            Container(
              width: Get.width / 3 - 26,
              decoration: BoxDecoration(
                border: Border.all(
                    color: addMotelRoomController.motelRoomRequest.value.type ==
                            type
                        ? Theme.of(Get.context!).primaryColor
                        : Colors.grey[200]!),
                color:
                    addMotelRoomController.motelRoomRequest.value.type == type
                        ? Colors.white
                        : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                boxShadow: addMotelRoomController.motelRoomRequest.value.type ==
                        type
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
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            if (addMotelRoomController.motelRoomRequest.value.type == type)
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
