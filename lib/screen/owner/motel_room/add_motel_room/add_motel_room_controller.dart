import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/dialog/dialog.dart';

import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/motel_room.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/owner/post_management/add_update_post_management/add_update_post_management_screen.dart';

import '../../../../components/loading/loading_widget.dart';
import '../../../../const/type_image.dart';
import '../../../../model/furniture.dart';
import '../../../../model/image_assset.dart';
import '../../../../model/location_address.dart';
import '../../../../model/service.dart';
import '../../../../model/tower.dart';
import '../../../../utils/string_utils.dart';

class AddMotelRoomController extends GetxController {
  var phoneNumberTextEditingController = TextEditingController(
      text: Get.find<DataAppController>().currentUser.value.phoneNumber);
  var titleTextEditingController = TextEditingController();
  var descriptionTextEditingController = TextEditingController();
  var roomNumberTextEditingController = TextEditingController();
  var areaTextEditingController = TextEditingController();
  var capacityTextEditingController = TextEditingController();
  var moneyTextEditingController = TextEditingController();
  var depositTextEditingController = TextEditingController();
  var electricMoneyTextEditingController = TextEditingController();
  var waterMoneyTextEditingController = TextEditingController();
  var wifiMoneyTextEditingController = TextEditingController();
  var parkMoneyTextEditingController = TextEditingController();
  var addressTextEditingController = TextEditingController();
  var quantityVehicleParked = TextEditingController();
  var numberFloor = TextEditingController();
  var towerName = TextEditingController();
  // var moneyCommissionAdmin = TextEditingController();
  var hourOpen = DateTime(0, 0, 0, 0, 0, 0).obs;
  var hourClose = DateTime(0, 0, 0, 0, 0, 0).obs;

  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;
  var furniture = Furniture().obs;
  MotelRoom? motelRoomInput;
  var doneUploadImage = true.obs;
  var isLoadingUpdate = false.obs;
  var motelRoomRequest = MotelRoom(sex: 0).obs;

  var isLoading = false.obs;
  var listImages = RxList<ImageData>([]);

  var isDraft = true;

  Tower? towerSelected;
  Tower? towerInput;

  File? file;
  bool? isFromPost;
  ///
  var listService = <Service>[];
  AddMotelRoomController({required this.motelRoomInput, this.towerInput, this.isFromPost}) {
    motelRoomRequest.value.phoneNumber =
        Get.find<DataAppController>().currentUser.value.phoneNumber ?? '';
    motelRoomRequest.value.images = [];
    motelRoomRequest.value.moServicesReq = [];
    motelRoomRequest.value.furniture = [];

    if (towerInput != null) {
      towerSelected = towerInput;
      convertInfoFromTower();
    }

    if (motelRoomInput != null) {
    
      listService = motelRoomInput!.moServicesReq ?? [];
      towerSelected = Tower(id: motelRoomInput?.towerId);
      towerName.text = motelRoomInput?.towerName ?? '';
      motelRoomRequest.value = motelRoomInput!;
      motelRoomRequest.value.images = motelRoomInput!.images ?? [];
      listImages((motelRoomInput!.images ?? [])
          .map((e) => ImageData(linkImage: e))
          .toList());
      motelRoomRequest.value.moServicesReq = motelRoomInput!.moServices ?? [];
      phoneNumberTextEditingController.text = motelRoomInput?.phoneNumber ?? "";
      titleTextEditingController.text = motelRoomInput?.title ?? "";
      descriptionTextEditingController.text = motelRoomInput?.description ?? "";
      roomNumberTextEditingController.text = motelRoomInput?.motelName ?? "";
      areaTextEditingController.text =
          motelRoomInput?.area == null ? '' : motelRoomInput!.area.toString();
      capacityTextEditingController.text = motelRoomInput?.capacity == null
          ? ''
          : motelRoomInput!.capacity.toString();
      moneyTextEditingController.text = motelRoomInput?.money == null
          ? ''
          : SahaStringUtils().convertToUnit(motelRoomInput?.money);
      depositTextEditingController.text = motelRoomInput?.deposit == null
          ? ''
          : SahaStringUtils().convertToUnit(motelRoomInput?.deposit);
      electricMoneyTextEditingController.text =
          motelRoomInput?.electricMoney == null
              ? ''
              : SahaStringUtils().convertToUnit(motelRoomInput?.electricMoney);

      waterMoneyTextEditingController.text = motelRoomInput?.waterMoney == null
          ? ''
          : SahaStringUtils().convertToUnit(motelRoomInput?.waterMoney ?? "");

      wifiMoneyTextEditingController.text = motelRoomInput?.wifiMoney == null
          ? ''
          : SahaStringUtils().convertToUnit(motelRoomInput?.wifiMoney ?? "");

      parkMoneyTextEditingController.text = motelRoomInput?.parkMoney == null
          ? ''
          : SahaStringUtils().convertToUnit(motelRoomInput?.parkMoney ?? "");
      addressTextEditingController.text = (motelRoomInput?.addressDetail ==
                  null ||
              motelRoomInput?.wardsName == null ||
              motelRoomInput?.districtName == null ||
              motelRoomInput?.provinceName == null)
          ? ""
          : "${motelRoomInput?.addressDetail} - ${motelRoomInput?.wardsName} - ${motelRoomInput?.districtName} - ${motelRoomInput?.provinceName}";
      hourOpen.value = DateTime(0, 0, 0, motelRoomInput?.hourOpen ?? 0,
          motelRoomInput!.minuteOpen ?? 0);
      hourClose.value = DateTime(0, 0, 0, motelRoomInput?.hourClose ?? 0,
          motelRoomInput!.minuteClose ?? 0);
      quantityVehicleParked.text =
          motelRoomInput?.quantityVehicleParked == null ||
                  motelRoomInput?.quantityVehicleParked == 0
              ? ''
              : '${motelRoomInput?.quantityVehicleParked}';
      numberFloor.text = motelRoomInput?.numberFloor == null
          ? ''
          : motelRoomInput?.numberFloor.toString() ?? '';
      // moneyCommissionAdmin.text = motelRoomInput?.moneyCommissionAdmin != null
      //     ? SahaStringUtils()
      //         .convertToUnit(motelRoomInput?.moneyCommissionAdmin)
      //     : '';
     
      getAllService();
    } else {
      getAllService();
    }
  }

  Future<void> getAllService() async {
    try {
      isLoading.value = true;
      var data = await RepositoryManager.manageRepository.getAllService();
      if (motelRoomInput == null && towerInput == null) {
        motelRoomRequest.value.moServicesReq = [];
        motelRoomRequest.value.moServicesReq!.addAll(data!.data!);
        listService.addAll(data.data!);
      }
    
     
      motelRoomRequest.refresh();
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addMotelRoom() async {
    if (isDraft == false) {
      if (motelRoomRequest.value.wards == null ||
          motelRoomRequest.value.province == null ||
          motelRoomRequest.value.district == null) {
        SahaAlert.showError(message: "Chưa chọn địa chỉ");
        return;
      }
      if ((motelRoomRequest.value.images ?? []).isEmpty) {
        SahaAlert.showError(message: "Chọn tối thiểu 1 ảnh");
        return;
      }
      if (motelRoomRequest.value.type == null) {
        SahaAlert.showError(message: "Chưa chọn loại phòng, mời bạn chọn lại");
        return;
      }

      if (motelRoomRequest.value.motelName == null ||
          motelRoomRequest.value.motelName == '') {
        SahaAlert.showError(message: "Chưa đặt tên phòng");
        return;
      }
      if (motelRoomRequest.value.addressDetail == null) {
        SahaAlert.showError(message: "Chưa nhập địa chỉ");
        return;
      }
      if (motelRoomRequest.value.capacity == null) {
        SahaAlert.showError(message: "Chưa nhập sức chứa");
        return;
      }
      if (motelRoomRequest.value.area == null) {
        SahaAlert.showError(message: "Chưa nhập diện tích");
        return;
      }
      if (motelRoomRequest.value.numberFloor == null) {
        SahaAlert.showError(message: "Chưa nhập tầng");
        return;
      }
      if (motelRoomRequest.value.phoneNumber == null) {
        SahaAlert.showError(message: "Chưa nhập số diện thoại");
        return;
      }
      if (motelRoomRequest.value.money == null) {
        SahaAlert.showError(message: "Chưa nhập giá phòng");
        return;
      }
      if (motelRoomRequest.value.deposit == null) {
        SahaAlert.showError(message: "Chưa nhập tiền cọc");
        return;
      }
    } else {
      if (motelRoomRequest.value.motelName == null) {
        SahaAlert.showError(message: "Mời bạn nhập tên phòng");
        return;
      }
    }

    try {
      if (file != null) {
        showDialogSuccess('Đang tạo video');
        await upVideo();
        Get.back();
      }
      // motelRoomRequest.value.province = locationProvince.value.id;
      // motelRoomRequest.value.district = locationDistrict.value.id;
      // motelRoomRequest.value.wards = locationWard.value.id;
      motelRoomRequest.value.hourOpen = hourOpen.value.hour;
      motelRoomRequest.value.minuteOpen = hourOpen.value.minute;
      motelRoomRequest.value.hourClose = hourClose.value.hour;
      motelRoomRequest.value.minuteClose = hourClose.value.minute;
      motelRoomRequest.value.hasCollaborator = true;
      var data = await RepositoryManager.manageRepository.addMotelRoom(
        motelRoom: motelRoomRequest.value,
      );
      SahaAlert.showSuccess(message: "Thêm thành công");
      if(data != null) {
        SahaDialogApp.showDialogYesNo(mess: "Bạn có muốn tạo tin đăng không?", onOK: () {
          Get.to(() => AddUpdatePostManagementScreen(
            motelRoomInput: data!.data,
          ));
        }, onClose: () {
          Get.back();
        });
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      isDraft = false;
    }
  }

  Future<void> updateMotelRoom() async {
    isLoadingUpdate.value = true;
   
    if ((motelRoomRequest.value.images ?? []).isEmpty) {
      SahaAlert.showError(message: "Chọn tối thiểu 1 ảnh");
      return;
    }
      print("abc");
    if (motelRoomRequest.value.motelName == null ||
        motelRoomRequest.value.motelName == '') {
      SahaAlert.showError(message: "Chưa đặt tên phòng");
      return;
    }
    if (motelRoomRequest.value.addressDetail == null) {
      SahaAlert.showError(message: "Chưa nhập địa chỉ");
      return;
    }
    if (motelRoomRequest.value.capacity == null) {
      SahaAlert.showError(message: "Chưa nhập sức chứa");
      return;
    }
    if (motelRoomRequest.value.area == null) {
      SahaAlert.showError(message: "Chưa nhập diện tích");
      return;
    }
    if (motelRoomRequest.value.numberFloor == null) {
      SahaAlert.showError(message: "Chưa nhập tầng");
      return;
    }
    if (motelRoomRequest.value.phoneNumber == null) {
      SahaAlert.showError(message: "Chưa nhập số diện thoại");
      return;
    }
    if (motelRoomRequest.value.money == null) {
      SahaAlert.showError(message: "Chưa nhập giá phòng");
      return;
    }
    if (motelRoomRequest.value.deposit == null) {
      SahaAlert.showError(message: "Chưa nhập tiền cọc");
      return;
    }
       

    try {
      if (file != null) {
        showDialogSuccess('Đang tạo video');
        await upVideo();
        Get.back();
      }
      // motelRoomRequest.value.province = locationProvince.value.id;
      // motelRoomRequest.value.district = locationDistrict.value.id;
      // motelRoomRequest.value.wards = locationWard.value.id;
      motelRoomRequest.value.hourOpen = hourOpen.value.hour;
      motelRoomRequest.value.minuteOpen = hourOpen.value.minute;
      motelRoomRequest.value.hourClose = hourClose.value.hour;
      motelRoomRequest.value.minuteClose = hourClose.value.minute;
      motelRoomRequest.value.hasCollaborator = true;
      var data = await RepositoryManager.manageRepository.updateMotelRoom(
        motelRoomId: motelRoomInput!.id!,
        motelRoom: motelRoomRequest.value,
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
      if(isFromPost == true) {
        Get.back();
        Get.back();
      }
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
  }

  void convertInfoFromTower() {
    //////
    
    phoneNumberTextEditingController.text = towerSelected?.phoneNumber ?? '';
    descriptionTextEditingController.text = towerSelected?.description ?? '';
    towerName.text = towerSelected?.towerName ?? '';
    addressTextEditingController.text =
        '${towerSelected?.addressDetail ?? ''} - ${towerSelected?.wardsName ?? ''} - ${towerSelected?.districtName ?? ''} - ${towerSelected?.provinceName ?? ''}';
    quantityVehicleParked.text = towerSelected?.quantityVehicleParked == null
        ? ''
        : towerSelected!.quantityVehicleParked.toString();
    listService = towerSelected?.moServicesReq ?? [];
    // for (int i = (towerSelected!.images ?? []).length - 1; i >= 0; i--) {
    //   listImages.insert(
    //       0, ImageData(linkImage: (towerSelected!.images ?? [])[i]));
    // }

    // listImages((towerSelected!.images ?? [])
    //     .map((e) => ImageData(linkImage: e))
    //     .toList());

    motelRoomRequest.value = MotelRoom(
        motelName: roomNumberTextEditingController.text,
        numberFloor: (numberFloor.text == null || numberFloor.text == '')
            ? null
            : int.tryParse(numberFloor.text),

        
        area:
            (areaTextEditingController.text == null || areaTextEditingController.text == '')
                ? null
                : int.tryParse(areaTextEditingController.text),
        capacity: (capacityTextEditingController.text == null ||
                capacityTextEditingController.text == '')
            ? null
            : int.tryParse(capacityTextEditingController.text),
        money: (moneyTextEditingController.text == null ||
                moneyTextEditingController.text == '')
            ? null
            : double.tryParse(SahaStringUtils()
                .convertFormatText(moneyTextEditingController.text)),
        deposit: (depositTextEditingController.text == null ||
                depositTextEditingController.text == '')
            ? null
            : double.tryParse(SahaStringUtils().convertFormatText(depositTextEditingController.text)),
        
        towerId: towerSelected?.id,
        
        images: (listImages.map((e) => e.linkImage ?? "x")).toList(),
        sex: towerSelected?.sex,
        phoneNumber: towerSelected?.phoneNumber,
        description: towerSelected?.description,
        type: towerSelected?.type,
        addressDetail: towerSelected?.addressDetail,
        wardsName: towerSelected?.wardsName,
        provinceName: towerSelected?.provinceName,
        districtName: towerSelected?.districtName,
        wards: towerSelected?.wards,
        province: towerSelected?.province,
        district: towerSelected?.district,
        moServicesReq: towerSelected?.moServicesReq ?? [],
        quantityVehicleParked: towerSelected?.quantityVehicleParked,
        hasWifi: towerSelected?.hasWifi,
        hasPark: towerSelected?.hasPark,
        hasAirConditioner: towerSelected?.hasAirConditioner,
        hasBalcony: towerSelected?.hasBalcony,
        hasBed: towerSelected?.hasBed,
        hasCeilingFans: towerSelected?.hasCeilingFans,
        hasCurtain: towerSelected?.hasCurtain,
        hasDecorativeLights: towerSelected?.hasDecorativeLights,
        hasFingerprint: towerSelected?.hasFingerPrint,
        hasFreeMove: towerSelected?.hasFreeMove,
        hasFridge: towerSelected?.hasFridge,
        hasKitchen: towerSelected?.hasKitchen,
        hasKitchenStuff: towerSelected?.hasKitchenStuff,
        hasMattress: towerSelected?.hasMattress,
        hasMezzanine: towerSelected?.hasMezzanine,
        hasMirror: towerSelected?.hasMirror,
        hasOwnOwner: towerSelected?.hasOwnOwner,
        hasPet: towerSelected?.hasPet,
        hasPicture: towerSelected?.hasPicture,
        hasPillow: towerSelected?.hasPillow,
        hasSecurity: towerSelected?.hasSecurity,
        hasShoesRacks: towerSelected?.hasShoesRasks,
        hasSofa: towerSelected?.hasSofa,
        hasTable: towerSelected?.hasTable,
        hasTivi: towerSelected?.hasTivi,
        hasTree: towerSelected?.hasTree,
        hasWardrobe: towerSelected?.hasWardrobe,
        hasWashingMachine: towerSelected?.hasWashingMachine,
        hasWaterHeater: towerSelected?.hasWaterHeater,
        hasWc: towerSelected?.hasWc,
        hasWindow: towerSelected?.hasWindow,
        furniture: towerSelected?.furniture ?? []);
       
  }

  void showDialogSuccess(String title) {
    var alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Colors.grey[200],
      elevation: 0.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SahaLoadingWidget(),
          const SizedBox(
            height: 1,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(Get.context!).primaryColor,
            ),
          ),
        ],
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext c) {
          return alert;
        });
  }

  Future<String?> upVideo() async {
    try {
      var link = await RepositoryManager.imageRepository
          .uploadVideo(video: file, type: MOTEL_FILES_FOLDER);
      motelRoomRequest.value.videoLink = link;
      return link;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    return null;
  }
}
