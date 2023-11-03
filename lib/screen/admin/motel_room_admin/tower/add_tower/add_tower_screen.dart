import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/screen/admin/motel_room_admin/tower/add_tower/map/map_screen.dart';
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
          () {
            if (controller.loadInit.value) {
              return SahaLoadingFullScreen();
            }
            return Form(
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
                        top: 15,
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Image.asset(
                        'assets/icon_host/loai-phong.png',
                        width: 120,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15),
                      child: Wrap(
                        children: [
                          itemTypeRoom(type: MOTEL, title: "Trọ thường"),
                          itemTypeRoom(
                            type: MOTEL_COMPOUND,
                            title: "Nguyên căn",
                          ),
                          itemTypeRoom(type: HOME, title: "Chung cư"),
                          itemTypeRoom(type: VILLA, title: "Chung cư mini"),
                          itemTypeRoom(type: HOMESTAY, title: "Homestay"),
                        ],
                      ),
                    ),
                    Obx(
                      () {
                        return Padding(
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
                              final imageLinks = listImages
                                  .map((e) => e.linkImage ?? "x")
                                  .toList();

                              if (imageLinks.contains('x')) {
                                SahaAlert.showError(message: 'Lỗi ảnh');
                              } else {
                                controller.listImages(listImages);
                                controller.towerReq.value.images = imageLinks;
                                controller.doneUploadImage.value = true;
                              }
                              debugPrint(
                                "done upload image ${listImages.length} images => $imageLinks",
                              );
                            },
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Obx(
                        () {
                          return VideoPickerSingle(
                            linkVideo: controller.towerReq.value.videoLink,
                            onChange: (File? file) async {
                              controller.file = file;
                              if (file == null) {
                                controller.towerReq.value.videoLink = null;
                              }
                            },
                          );
                        },
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
                            icon: const Icon(
                              Icons.location_pin,
                              color: Colors.transparent,
                            ),
                            labelText: "Địa chỉ",
                            textInputType: TextInputType.text,
                            controller: controller.addressTextEditingController,
                            withAsterisk: true,
                            hintText: "Chọn địa chỉ",
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                Get.to(() {
                                  return MapScreen(
                                    selectedAddress: (selectedAddress) {
                                      controller
                                        ..addressTextEditingController.text =
                                            selectedAddress
                                        ..towerReq.value.addressDetail =
                                            selectedAddress;
                                    },
                                  );
                                });
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
                      controller: controller.descriptionTextEditingController,
                      onChanged: (v) {
                        controller.towerReq.value.description = v;
                      },
                      textInputType: TextInputType.multiline,
                      labelText: "Mô tả",
                      hintText: "Nhập mô tả",
                    ),
                    SahaDivide(),
                    SahaTextFieldNoBorder(
                      textInputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      controller: controller.phoneNumberTextEditingController,
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
                      padding: const EdgeInsets.all(16),
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
                    SahaDivide(),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                        left: 10,
                        top: 15,
                        bottom: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/icon_host/phi-dich-vu.png',
                            width: 120,
                          ),
                          InkWell(
                            onTap: _navigateToChooseServiceScreen,
                            child: const Center(child: Icon(Icons.add)),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () {
                        if ((controller.towerReq.value.moServicesReq ?? [])
                            .isEmpty) {
                          return Container();
                        }
                        final moServicesReq =
                            controller.towerReq.value.moServicesReq!;

                        return Center(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(
                              moServicesReq.length,
                              (index) {
                                final service = moServicesReq[index];
                                final isServiceChecked = moServicesReq
                                    .map((service) => service.serviceName)
                                    .contains(service.serviceName);

                                return itemService(
                                  value: isServiceChecked,
                                  service: service,
                                  onCheck: () {},
                                );
                              },
                            ),
                          ),
                        );
                      },
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
                        left: 15,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Obx(
                        () {
                          var tower = controller.towerReq.value;

                          return Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              itemUtilities(
                                value: tower.hasWc ?? false,
                                title: "Nhà vệ sinh",
                                onCheck: () {
                                  tower.hasWc = !(tower.hasWc ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasMezzanine ?? false,
                                title: "Gác xép",
                                onCheck: () {
                                  tower.hasMezzanine =
                                      !(tower.hasMezzanine ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasBalcony ?? false,
                                title: "Ban công",
                                onCheck: () {
                                  tower.hasBalcony =
                                      !(tower.hasBalcony ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasFingerPrint ?? false,
                                title: "Ra vào vân tay",
                                onCheck: () {
                                  tower.hasFingerPrint =
                                      !(tower.hasFingerPrint ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasOwnOwner ?? false,
                                title: "Không chung chủ",
                                onCheck: () {
                                  tower.hasOwnOwner =
                                      !(tower.hasOwnOwner ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasPet ?? false,
                                title: "Nuôi Pet",
                                onCheck: () {
                                  tower.hasPet = !(tower.hasPet ?? false);
                                },
                              ),
                            ],
                          );
                        },
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
                        left: 15,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Obx(
                        () {
                          var tower = controller.towerReq.value;

                          return Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              itemUtilities(
                                value: tower.hasAirConditioner ?? false,
                                title: "Điều hoà",
                                onCheck: () {
                                  tower.hasAirConditioner =
                                      !(tower.hasAirConditioner ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasWaterHeater ?? false,
                                title: "Nóng lạnh",
                                onCheck: () {
                                  tower.hasWaterHeater = !(controller
                                          .towerReq.value.hasWaterHeater ??
                                      false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasKitchen ?? false,
                                title: "Kệ bếp",
                                onCheck: () {
                                  tower.hasKitchen =
                                      !(tower.hasKitchen ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasFridge ?? false,
                                title: "Tủ lạnh",
                                onCheck: () {
                                  tower.hasFridge = !(tower.hasFridge ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasBed ?? false,
                                title: "Giường ngủ",
                                onCheck: () {
                                  tower.hasBed = !(tower.hasBed ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasWashingMachine ?? false,
                                title: "Máy giặt",
                                onCheck: () {
                                  tower.hasWashingMachine =
                                      !(tower.hasWashingMachine ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasKitchenStuff ?? false,
                                title: "Đồ dùng bếp",
                                onCheck: () {
                                  tower.hasKitchenStuff = !(controller
                                          .towerReq.value.hasKitchenStuff ??
                                      false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasTable ?? false,
                                title: "Bàn ghế",
                                onCheck: () {
                                  tower.hasTable = !(tower.hasTable ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasDecorativeLights ?? false,
                                title: "Đèn trang trí",
                                onCheck: () {
                                  tower.hasDecorativeLights =
                                      !(tower.hasDecorativeLights ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasPicture ?? false,
                                title: "Tranh trang trí",
                                onCheck: () {
                                  tower.hasPicture =
                                      !(tower.hasPicture ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasTree ?? false,
                                title: "Cây cối trang trí",
                                onCheck: () {
                                  tower.hasTree = !(tower.hasTree ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasPillow ?? false,
                                title: "Chăn ga gối",
                                onCheck: () {
                                  tower.hasPillow = !(tower.hasPillow ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasWardrobe ?? false,
                                title: "Tủ quần áo",
                                onCheck: () {
                                  tower.hasWardrobe =
                                      !(tower.hasWardrobe ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasMattress ?? false,
                                title: "Nệm",
                                onCheck: () {
                                  tower.hasMattress =
                                      !(tower.hasMattress ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasShoesRasks ?? false,
                                title: "Kệ giày dép",
                                onCheck: () {
                                  tower.hasShoesRasks = !(controller
                                          .towerReq.value.hasShoesRasks ??
                                      false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasCurtain ?? false,
                                title: "Rèm",
                                onCheck: () {
                                  tower.hasCurtain =
                                      !(tower.hasCurtain ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasCeilingFans ?? false,
                                title: "Quạt trần",
                                onCheck: () {
                                  tower.hasCeilingFans =
                                      !(tower.hasCeilingFans ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasMirror ?? false,
                                title: "Gương toàn thân",
                                onCheck: () {
                                  tower.hasMirror = !(tower.hasMirror ?? false);
                                },
                              ),
                              itemUtilities(
                                value: tower.hasSofa ?? false,
                                title: "Sofa",
                                onCheck: () {
                                  tower.hasSofa = !(tower.hasSofa ?? false);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                        left: 10,
                        top: 10,
                        bottom: 15,
                      ),
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
                                      quantity: int.parse(quantity),
                                    ),
                                  );

                                  controller.towerReq.refresh();
                                  Get.back();
                                },
                              );
                            },
                            child: const Center(child: Icon(Icons.add)),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 15.0,
                            left: 15,
                            top: 0,
                            bottom: 10,
                          ),
                          child: Column(
                            children: [
                              for (var furniture
                                  in controller.towerReq.value.furniture ?? [])
                                itemFurniture(
                                  furniture,
                                  controller.towerReq.value.furniture!
                                      .indexOf(furniture),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
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

  Widget itemService({
    required bool value,
    required void Function()? onCheck,
    required Service service,
  }) {
    BoxDecoration buildDecoration(bool isSelected) {
      final primaryColor = Theme.of(Get.context!).primaryColor;

      return BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isSelected ? primaryColor : Colors.grey[200]!,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: onCheck,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: (Get.width - 40) / 3,
            height: 140,
            decoration: buildDecoration(value),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  service.serviceIcon ?? "",
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
                ),
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
                  textInput: removeDecimalZeroFormat(service.serviceCharge!),
                  onInput: (v) {
                    final convertedValue =
                        double.parse(SahaStringUtils().convertFormatText(v));
                    final index = controller.towerReq.value.moServicesReq!
                        .indexWhere((element) =>
                            element.serviceName == service.serviceName);

                    controller.towerReq.value.moServicesReq![index]
                        .serviceCharge = convertedValue;
                    service.serviceCharge = convertedValue;
                    controller.towerReq.refresh();
                  },
                  title: 'Sửa giá',
                );
              },
              icon: Icon(
                Icons.edit,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemUtilities({
    required bool value,
    required String title,
    required Function onCheck,
  }) {
    final primaryColor = Theme.of(Get.context!).primaryColor;
    final isValueTrue = value == true;

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
                color: value ? primaryColor : Colors.grey[200]!,
              ),
            ),
            child: Center(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isValueTrue ? primaryColor : null,
                ),
              ),
            ),
          ),
          if (!isValueTrue)
            Positioned.fill(
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200]!.withOpacity(0.5),
                ),
              ),
            ),
          if (isValueTrue)
            Positioned(
              left: -25,
              top: -20,
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: primaryColor,
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
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget itemFurniture(Furniture furniture, int index) {
    void editFurnitureDetails() {
      DialogAddService.showDialogFurnitureInput(
        isFix: true,
        nameService: furniture.name,
        quantity: furniture.quantity,
        onDone: (name, quantity) {
          controller.towerReq.value.furniture?[index] =
              Furniture(name: name, quantity: int.parse(quantity));
          controller.towerReq.refresh();
          Get.back();
        },
      );
    }

    void removeFurniture() {
      controller.towerReq.value.furniture?.removeAt(index);
      controller.towerReq.refresh();
    }

    return InkWell(
      onTap: editFurnitureDetails,
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
                const SizedBox(width: 10),
                Text(
                  furniture.name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(furniture.quantity.toString()),
                IconButton(
                  onPressed: removeFurniture,
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget itemTypeRoom({required int type, required String title}) {
    final isSelected = controller.towerReq.value.type == type;
    final primaryColor = Theme.of(Get.context!).primaryColor;

    BoxDecoration buildDecoration() {
      return BoxDecoration(
        border: Border.all(
          color: isSelected ? primaryColor : Colors.grey[200]!,
        ),
        color: isSelected ? Colors.white : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected
            ? []
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
      );
    }

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
              decoration: buildDecoration(),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            if (isSelected)
              Positioned(
                left: -25,
                top: -20,
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(color: primaryColor),
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
                        ),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  void onSelectAddress() {
    showDialogForProvince();
  }

  void showDialogForProvince() {
    SahaDialogApp.showDialogAddressChoose(
      hideAll: true,
      accept: () {},
      callback: (v) {
        controller.locationProvince.value = v;
        controller.towerReq.value.province = v.id;
        Get.back();
        showDialogForDistrict();
      },
    );
  }

  void showDialogForDistrict() {
    SahaDialogApp.showDialogAddressChoose(
      hideAll: true,
      accept: () {},
      idProvince: controller.locationProvince.value.id,
      callback: (v) {
        controller.locationDistrict.value = v;
        controller.towerReq.value.district = v.id;
        Get.back();
        showDialogForWard();
      },
    );
  }

  void showDialogForWard() {
    SahaDialogApp.showDialogAddressChoose(
      hideAll: true,
      accept: () {},
      idDistrict: controller.locationDistrict.value.id,
      callback: (v) {
        controller.locationWard.value = v;
        controller.towerReq.value.wards = v.id;
        Get.back();
        showDialogForAddressDetail();
      },
    );
  }

  void showDialogForAddressDetail() {
    SahaDialogApp.showDialogInputNote(
      height: 50,
      confirm: (v) {
        if (v == null || v == "") {
          SahaAlert.showToastMiddle(message: "Vui lòng nhập địa chỉ chi tiết");
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
      textInput: controller.towerReq.value.addressDetail ?? "",
    );
  }

  void _navigateToChooseServiceScreen() {
    Get.to(
      () {
        return ChooseServiceScreen(
          isFromMotelManage: true,
          serviceInput: controller.listService,
          listServiceInput: controller.towerReq.value.moServicesReq ?? [],
          onChoose: (List<Service> v, List<Service> t) {
            controller.towerReq.value.moServicesReq = List.of(v);
            controller.listService = t;
            controller.towerReq.refresh();
          },
        );
      },
    );
  }
}
