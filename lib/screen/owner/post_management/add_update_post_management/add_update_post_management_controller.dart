import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/motel_post.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../const/type_image.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/image_assset.dart';
import '../../../../model/location_address.dart';
import '../../../../model/motel_room.dart';
import '../../../../model/service.dart';
import '../../../../model/tower.dart';

class AddUpdatePostManagementController extends GetxController {
  var phoneNumberTextEditingController = TextEditingController();
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
  var provinceNameTextEditingController = TextEditingController();
  var districtNameTextEditingController = TextEditingController();
  var wardsNameTextEditingController = TextEditingController();
  var addressTextEditingController = TextEditingController();
  var moneyCommissionAdmin = TextEditingController();
  var quantityVehicleParked = TextEditingController();
  var moneyCommissionUser = TextEditingController();
  var percentCommmissionUser = TextEditingController();
  var numberFloor = TextEditingController();
  var hourOpen = DateTime(0, 0, 0, 0, 0, 0).obs;
  var hourClose = DateTime(0, 0, 0, 0, 0, 0).obs;

  var doneUploadImage = true.obs;

  /////////
  ///
  var towerChoose = Tower().obs;
  var motelChoose = MotelRoom().obs;

  //////////////////
  var percentCommission =
      Get.find<DataAppController>().currentUser.value.hostRank == 2
          ? '30%'.obs
          : '0%'.obs;
  List<String> listCommission = <String>[
    '0%',
    '10%',
    '20%',
    '30%',
    '40%',
    '50%',
    '60%',
    '70%',
    '80%',
    '90%',
    '100%'
  ];
  List<String> listCommissionVip = <String>[
    '30%',
    '40%',
    '50%',
    '60%',
    '70%',
    '80%',
    '90%',
    '100%'
  ];
  File? file;
  var type = MO_POST_FILES_FOLDER;

  var isLoadingUpdate = false.obs;
  var motelPostRequest = MotelPost(id: 0).obs;
  var listImages = RxList<ImageData>([]);

  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;
  MotelRoom? motelRoomInput;
  var listService = RxList<Service>();
  var motelPostRes = MotelPost().obs;
  bool? isHome;
  int? id;
  var isAdd = false.obs;

  var loading = false.obs;

  AddUpdatePostManagementController({
    this.motelRoomInput,
    this.id,
    this.isHome,
  }) {
    motelPostRequest.value.images = [];
    motelPostRequest.value.moServicesReq = [];
    if (motelRoomInput != null) {
      motelChoose.value = motelRoomInput!;
      convertRequestRoomPost();
    }
    if (id != null) {
      getPostManagement(id: id!);
    }
  }

  Future<void> getPostManagement({required int id}) async {
    loading.value = true;
    try {
      var res =
          await RepositoryManager.manageRepository.getPostManagement(id: id);

      motelPostRequest.value = res!.data!;

      motelPostRes.value = res.data!;
      convertResponse();
      loading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deletePostManagement({required int postManagementId}) async {
    try {
      var data = await RepositoryManager.manageRepository
          .deletePostManagement(postManagementId: postManagementId);
      Get.back();
      SahaAlert.showSuccess(message: "Đã xoá bài đăng");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }

  void convertRequestRoomPost() {
    motelPostRequest.value = MotelPost(status: motelPostRequest.value.status);
    towerChoose.value = Tower();
    motelPostRequest.value.title = titleTextEditingController.text;
    motelPostRequest.value.images = motelChoose.value.images ?? [];
    /////khi chọn phòng mới clear data điền sẵn
     //titleTextEditingController.text = '';
    percentCommmissionUser.text = "";
    percentCommission =
      Get.find<DataAppController>().currentUser.value.hostRank == 2
          ? '30%'.obs
          : '0%'.obs;
          /////
    motelPostRequest.value.towerId = null;
    motelPostRequest.value.listMotel = [];

    listImages((motelChoose.value.images ?? [])
        .map((e) => ImageData(linkImage: e))
        .toList());
    motelPostRequest.value.moServicesReq = motelChoose.value.moServices ?? [];
    motelPostRequest.value.motelId = motelChoose.value.id;

    motelPostRequest.value.description = motelChoose.value.description;
    descriptionTextEditingController.text = motelChoose.value.description ?? "";

    motelPostRequest.value.capacity = motelChoose.value.capacity;
    capacityTextEditingController.text =
        (motelChoose.value.capacity ?? "").toString();

    motelPostRequest.value.motelName = motelChoose.value.motelName ?? "";
    roomNumberTextEditingController.text =
        (motelChoose.value.motelName ?? "").toString();

    motelPostRequest.value.sex = motelChoose.value.sex;
    motelPostRequest.value.linkVideo = motelChoose.value.videoLink;
    print('================>>>>>>>>>>> ${ motelChoose.value.videoLink}');

    motelPostRequest.value.area = motelChoose.value.area;
    areaTextEditingController.text = (motelChoose.value.area ?? "").toString();

    motelPostRequest.value.phoneNumber = motelChoose.value.phoneNumber;
    phoneNumberTextEditingController.text = motelChoose.value.phoneNumber ?? "";

    motelPostRequest.value.money = motelChoose.value.money;
    moneyTextEditingController.text =
        SahaStringUtils().convertToUnit(motelChoose.value.money ?? "0");

    motelPostRequest.value.deposit = motelChoose.value.deposit;
    depositTextEditingController.text =
        SahaStringUtils().convertToUnit(motelChoose.value.deposit ?? "0");
    // moneyCommissionAdmin.text = SahaStringUtils()
    //     .convertToUnit(motelChoose.value.moneyCommissionAdmin ?? "0");
    // moneyCommissionUser.text = SahaStringUtils()
    //     .convertToUnit(motelChoose.value.moneyCommissionUser ?? "0");

    motelPostRequest.value.hasWifi = motelChoose.value.hasWifi;
    motelPostRequest.value.hasWifi = motelChoose.value.hasWifi ?? true;

    motelPostRequest.value.addressDetail = motelChoose.value.addressDetail;
    addressTextEditingController.text =
        "${motelChoose.value.addressDetail} - ${motelChoose.value.wardsName} - ${motelChoose.value.districtName} - ${motelChoose.value.provinceName}";

    motelPostRequest.value.wards = motelChoose.value.wards;
    motelPostRequest.value.district = motelChoose.value.district;
    motelPostRequest.value.province = motelChoose.value.province;

    motelPostRequest.value.hasWc = motelChoose.value.hasWc;

    motelPostRequest.value.hasWindow = motelChoose.value.hasWindow;

    motelPostRequest.value.hasSecurity = motelChoose.value.hasSecurity;

    motelPostRequest.value.hasFreeMove = motelChoose.value.hasFreeMove;

    motelPostRequest.value.hasOwnOwner = motelChoose.value.hasOwnOwner;

    motelPostRequest.value.type = motelChoose.value.type;

    motelPostRequest.value.hasAirConditioner =
        motelChoose.value.hasAirConditioner;

    motelPostRequest.value.hasWaterHeater = motelChoose.value.hasWaterHeater;

    motelPostRequest.value.hasKitchen = motelChoose.value.hasKitchen;

    motelPostRequest.value.hasFridge = motelChoose.value.hasFridge;

    motelPostRequest.value.hasWashingMachine =
        motelChoose.value.hasWashingMachine;

    motelPostRequest.value.hasMezzanine = motelChoose.value.hasMezzanine;

    motelPostRequest.value.hasBed = motelChoose.value.hasBed;

    motelPostRequest.value.hasWardrobe = motelChoose.value.hasWardrobe;

    motelPostRequest.value.hasTivi = motelChoose.value.hasTivi;

    motelPostRequest.value.hasPet = motelChoose.value.hasPet;

    motelPostRequest.value.hasBalcony = motelChoose.value.hasBalcony;

    motelPostRequest.value.hourOpen = motelChoose.value.hourOpen;

    motelPostRequest.value.hourClose = motelChoose.value.hourClose;
    hourOpen.value = DateTime(0, 0, 0, motelChoose.value.hourOpen ?? 0,
        motelChoose.value.minuteOpen ?? 0);
    hourClose.value = DateTime(0, 0, 0, motelChoose.value.hourClose ?? 0,
        motelChoose.value.minuteClose ?? 0);
    motelPostRequest.value.numberFloor = motelChoose.value.numberFloor;
    numberFloor.text = motelChoose.value.numberFloor.toString();

    motelPostRequest.value.quantityVehicleParked =
        motelChoose.value.quantityVehicleParked;
    quantityVehicleParked.text =
        motelChoose.value.quantityVehicleParked == null ||
                motelChoose.value.quantityVehicleParked == 0
            ? ''
            : '${motelChoose.value.quantityVehicleParked}';
    motelPostRequest.value.hasFingerprint = motelChoose.value.hasFingerprint;
    motelPostRequest.value.hasKitchenStuff = motelChoose.value.hasKitchenStuff;
    motelPostRequest.value.hasCeilingFans = motelChoose.value.hasCeilingFans;
    motelPostRequest.value.hasCurtain = motelChoose.value.hasCurtain;
    motelPostRequest.value.hasDecorativeLights =
        motelChoose.value.hasDecorativeLights;
    motelPostRequest.value.hasMattress = motelChoose.value.hasMattress;
    motelPostRequest.value.hasMirror = motelChoose.value.hasMirror;
    motelPostRequest.value.hasPicture = motelChoose.value.hasPicture;
    motelPostRequest.value.hasPillow = motelChoose.value.hasPillow;
    motelPostRequest.value.hasShoesRacks = motelChoose.value.hasShoesRacks;
    motelPostRequest.value.hasSofa = motelChoose.value.hasSofa;
    motelPostRequest.value.hasTable = motelChoose.value.hasTable;
    motelPostRequest.value.hasTree = motelChoose.value.hasTree;

    motelPostRequest.value.moneyCommissionAdmin =
        motelChoose.value.moneyCommissionAdmin;

    motelPostRequest.refresh();
  }

  Future<void> addPostManagement() async {
   
    if (motelChoose.value.id == null && towerChoose.value.id == null) {
      SahaAlert.showError(message: 'Bạn chưa chọn toà nhà/phòng');
      return;
    }
    if (motelChoose.value.id != null) {
       
      if ((motelPostRequest.value.images ?? []).isEmpty) {
        SahaAlert.showError(message: 'Bài đăng chưa có ảnh');
        return;
      }
      if (motelPostRequest.value.images!.isEmpty) {
        SahaAlert.showError(message: 'Chọn tối thiểu 1 ảnh');
        return;
      }
      if (motelPostRequest.value.title == null ||
          motelPostRequest.value.title!.isEmpty) {
        SahaAlert.showError(message: "Chưa nhập tiêu đề bài đăng");
        return;
      }
      if (motelPostRequest.value.title!.length > 50) {
        SahaAlert.showError(
            message: 'Tiêu đề bài đăng không được vượt quá 50 ký tự');
        return;
      }
      if (motelPostRequest.value.motelName == null ||
          motelPostRequest.value.motelName!.isEmpty) {
        SahaAlert.showError(message: "Chưa nhập tên phòng");
        return;
      }
      if (motelPostRequest.value.type == null) {
        SahaAlert.showError(message: "Chưa nhập loại phòng");
        return;
      }
      if (motelPostRequest.value.capacity == null) {
        SahaAlert.showError(message: "Chưa nhập sức chứa");
        return;
      }
      if (motelPostRequest.value.area == null) {
        SahaAlert.showError(message: "Chưa nhập diện tích");
        return;
      }
      if (motelPostRequest.value.numberFloor == null) {
        SahaAlert.showError(message: "Chưa nhập số tầng");
        return;
      }
      if (motelPostRequest.value.phoneNumber == null) {
        SahaAlert.showError(message: "Chưa nhập số diện thoại");
        return;
      }
      if (motelPostRequest.value.money == null) {
        SahaAlert.showError(message: "Chưa nhập giá phòng");
        return;
      }
      if (motelPostRequest.value.deposit == null) {
        SahaAlert.showError(message: "Chưa nhập tiền đặt cọc");
        return;
      }
      if (motelPostRequest.value.quantityVehicleParked == null) {
        SahaAlert.showError(message: "Chưa nhập số chỗ để xe");
        return;
      }
    }

    if (towerChoose.value.id != null) {
      print('=========>${towerChoose.value.id}');
      if (motelPostRequest.value.title == null ||
          motelPostRequest.value.title!.isEmpty) {
        SahaAlert.showError(message: "Chưa nhập tiêu đề bài đăng");
        return;
      }

      if ((motelPostRequest.value.images ?? []).isEmpty) {
        SahaAlert.showError(message: 'Bài đăng chưa có ảnh');
        return;
      }
      if (motelPostRequest.value.images!.isEmpty) {
        SahaAlert.showError(message: 'Chọn tối thiểu 1 ảnh');
        return;
      }
      if (motelPostRequest.value.title!.length > 50) {
        SahaAlert.showError(
            message: 'Tiêu đề bài đăng không được vượt quá 50 ký tự');
        return;
      }
      // if (motelPostRequest.value.capacity == null) {
      //   SahaAlert.showError(message: "Chưa nhập sức chứa");
      //   return;
      // }
      if (motelPostRequest.value.type == null) {
        SahaAlert.showError(message: "Chưa nhập loại phòng");
        return;
      }
      // if (motelPostRequest.value.capacity == null) {
      //   SahaAlert.showError(message: "Chưa nhập sức chứa");
      //   return;
      // }
      if (motelPostRequest.value.quantityVehicleParked == null) {
        SahaAlert.showError(message: "Chưa nhập số chỗ để xe");
        return;
      }
      if (motelPostRequest.value.listMotel == null ||
          motelPostRequest.value.listMotel!.isEmpty) {
        SahaAlert.showError(message: "Toà nhà này chưa có phòng nào");
        return;
      }
    }

    try {
      if (file != null) {
        showDialogSuccess('Đang tạo bài đăng');
        await upVideo();
        Get.back();
      }
      motelPostRequest.value.moneyCommissionUser =
          motelPostRequest.value.percentCommissionCollaborator == null
              ? null
              : motelPostRequest.value.money! *
                  (motelPostRequest.value.percentCommissionCollaborator! / 100);
      motelPostRequest.value.percentCommission =
          int.parse(percentCommission.value.replaceAll("%", ''));
      motelPostRequest.value.moneyCommissionAdmin =
          motelPostRequest.value.money! *
              (int.parse(percentCommission.value.replaceAll('%', '')) / 100);
      motelPostRequest.value.hourOpen = hourOpen.value.hour;
      motelPostRequest.value.minuteOpen = hourOpen.value.minute;
      motelPostRequest.value.hourClose = hourClose.value.hour;
      motelPostRequest.value.minuteClose = hourClose.value.minute;
      motelPostRequest.value.hasCollaborator = true;
      var data = await RepositoryManager.manageRepository.addPostManagement(
        motelPost: motelPostRequest.value,
      );
      SahaAlert.showSuccess(message: "Thêm thành công");
      isAdd.value = true;
      if (isHome != true) {
        Get.back();
      }
      if (motelRoomInput != null) {
        Get.back();
      }
      Get.find<DataAppController>().getBadge();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updatePostManagement() async {
    if (motelChoose.value.id == null && towerChoose.value.id == null) {
      SahaAlert.showError(message: 'Bạn chưa chọn toà nhà/phòng');
      return;
    }
    if (motelChoose.value.id != null) {
      if ((motelPostRequest.value.images ?? []).isEmpty) {
        SahaAlert.showError(message: 'Bài đăng chưa có ảnh');
        return;
      }
      if (motelPostRequest.value.images!.isEmpty) {
        SahaAlert.showError(message: 'Chọn tối thiểu 1 ảnh');
        return;
      }
      if (motelPostRequest.value.title == null ||
          motelPostRequest.value.title!.isEmpty) {
        SahaAlert.showError(message: "Chưa nhập tiêu đề bài đăng");
        return;
      }
      if (motelPostRequest.value.title!.length > 50) {
        SahaAlert.showError(
            message: 'Tiêu đề bài đăng không được vượt quá 50 ký tự');
        return;
      }
      if (motelPostRequest.value.motelName == null ||
          motelPostRequest.value.motelName!.isEmpty) {
        SahaAlert.showError(message: "Chưa nhập tên phòng");
        return;
      }
      if (motelPostRequest.value.capacity == null) {
        SahaAlert.showError(message: "Chưa nhập sức chứa");
        return;
      }

      if (motelPostRequest.value.type == null) {
        SahaAlert.showError(message: "Chưa nhập loại phòng");
        return;
      }
      if (motelPostRequest.value.area == null) {
        SahaAlert.showError(message: "Chưa nhập diện tích");
        return;
      }
      if (motelPostRequest.value.numberFloor == null) {
        SahaAlert.showError(message: "Chưa nhập số tầng");
        return;
      }
      if (motelPostRequest.value.phoneNumber == null) {
        SahaAlert.showError(message: "Chưa nhập số diện thoại");
        return;
      }
      if (motelPostRequest.value.money == null) {
        SahaAlert.showError(message: "Chưa nhập giá phòng");
        return;
      }
      if (motelPostRequest.value.deposit == null) {
        SahaAlert.showError(message: "Chưa nhập tiền đặt cọc");
        return;
      }
      if (motelPostRequest.value.quantityVehicleParked == null) {
        SahaAlert.showError(message: "Chưa nhập số chỗ để xe");
        return;
      }
    }

    if (towerChoose.value.id != null) {
      if (motelPostRequest.value.title == null ||
          motelPostRequest.value.title!.isEmpty) {
        SahaAlert.showError(message: "Chưa nhập tiêu đề bài đăng");
        return;
      }

      if ((motelPostRequest.value.images ?? []).isEmpty) {
        SahaAlert.showError(message: 'Bài đăng chưa có ảnh');
        return;
      }
      if (motelPostRequest.value.images!.isEmpty) {
        SahaAlert.showError(message: 'Chọn tối thiểu 1 ảnh');
        return;
      }
      if (motelPostRequest.value.title!.length > 50) {
        SahaAlert.showError(
            message: 'Tiêu đề bài đăng không được vượt quá 50 ký tự');
        return;
      }
  
      if (motelPostRequest.value.type == null) {
        SahaAlert.showError(message: "Chưa nhập loại phòng");
        return;
      }

      if (motelPostRequest.value.quantityVehicleParked == null) {
        SahaAlert.showError(message: "Chưa nhập số chỗ để xe");
        return;
      }
      if (motelPostRequest.value.listMotel == null ||
          motelPostRequest.value.listMotel!.isEmpty) {
        SahaAlert.showError(message: "Toà nhà này chưa có phòng nào");
        return;
      }
    }
    isLoadingUpdate.value = true;
    try {
      if (file != null) {
        showDialogSuccess('Đang cập nhật bài đăng');
        await upVideo();
        Get.back();
      }
      motelPostRequest.value.moneyCommissionUser =
          motelPostRequest.value.percentCommissionCollaborator == null
              ? null
              : motelPostRequest.value.money! *
                  (motelPostRequest.value.percentCommissionCollaborator! / 100);
      motelPostRequest.value.percentCommission =
          int.parse(percentCommission.value.replaceAll("%", ''));
      motelPostRequest.value.moneyCommissionAdmin =
          motelPostRequest.value.money! *
              (int.parse(percentCommission.value.replaceAll('%', '')) / 100);
      motelPostRequest.value.hourOpen = hourOpen.value.hour;
      motelPostRequest.value.minuteOpen = hourOpen.value.minute;
      motelPostRequest.value.hourClose = hourClose.value.hour;
      motelPostRequest.value.minuteClose = hourClose.value.minute;
      motelPostRequest.value.hasCollaborator = true;
      var data = await RepositoryManager.manageRepository.updatePostManagement(
        postManagementId: id!,
        motelPost: motelPostRequest.value,
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
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
          .uploadVideo(video: file, type: type);
      motelPostRequest.value.linkVideo = link;
      return link;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    return null;
  }

  Future<void> changePostStatus({required int status}) async {
    try {
      var res = await RepositoryManager.manageRepository
          .changePostStatus(postManagementId: id!, status: status);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  void convertTowerRequest() {
    motelChoose.value = MotelRoom();
    motelPostRequest.value = MotelPost(title: (titleTextEditingController.text == '' || titleTextEditingController.text == null) ? null : titleTextEditingController.text,status: motelPostRequest.value.status);
    ////
    //titleTextEditingController.text = '';
    percentCommmissionUser.text = "";
    percentCommission =
      Get.find<DataAppController>().currentUser.value.hostRank == 2
          ? '30%'.obs
          : '0%'.obs;
    ////

    motelPostRequest.value.listMotel = (towerChoose.value.listMotelRoom ?? []).where((e) => e.status == 0 && e.isSupportManageMotel == true).toList();    
    motelPostRequest.value.motelId = null;
    motelPostRequest.value.towerName = towerChoose.value.towerName;
    motelPostRequest.value.images = towerChoose.value.images ?? [];
    listImages((towerChoose.value.images ?? [])
        .map((e) => ImageData(linkImage: e))
        .toList());
    motelPostRequest.value.moServicesReq =
        towerChoose.value.moServicesReq ?? [];
    motelPostRequest.value.towerId = towerChoose.value.id;

    motelPostRequest.value.description = towerChoose.value.description;
    descriptionTextEditingController.text = towerChoose.value.description ?? "";

    motelPostRequest.value.capacity = towerChoose.value.capacity;
    capacityTextEditingController.text =
        (towerChoose.value.capacity ?? "").toString();

    motelPostRequest.value.motelName = null;
    // roomNumberTextEditingController.text =
    //     (towerChoose.value.motelName ?? "").toString();

    motelPostRequest.value.sex = towerChoose.value.sex;
    motelPostRequest.value.linkVideo = towerChoose.value.videoLink;
    motelPostRequest.value.area = towerChoose.value.area;
    areaTextEditingController.text = (motelChoose.value.area ?? "").toString();

    motelPostRequest.value.phoneNumber = towerChoose.value.phoneNumber;
    phoneNumberTextEditingController.text = towerChoose.value.phoneNumber ?? "";

    motelPostRequest.value.money = towerChoose.value.money;
    // moneyTextEditingController.text =
    //     SahaStringUtils().convertToUnit(towerChoose.value.money ?? "0");

    motelPostRequest.value.deposit = towerChoose.value.deposit;
    // depositTextEditingController.text =
    //     SahaStringUtils().convertToUnit(motelChoose.value.deposit ?? "0");
    // moneyCommissionAdmin.text = SahaStringUtils()
    //     .convertToUnit(motelChoose.value.moneyCommissionAdmin ?? "0");
    // moneyCommissionUser.text = SahaStringUtils()
    //     .convertToUnit(motelChoose.value.moneyCommissionUser ?? "0");

    motelPostRequest.value.hasWifi = towerChoose.value.hasWifi;

    motelPostRequest.value.addressDetail = towerChoose.value.addressDetail;
    addressTextEditingController.text = (towerChoose.value.addressDetail ==
                null ||
            towerChoose.value.wardsName == null ||
            towerChoose.value.districtName == null ||
            towerChoose.value.provinceName == null)
        ? ''
        : "${towerChoose.value.addressDetail} - ${towerChoose.value.wardsName} - ${towerChoose.value.districtName} - ${towerChoose.value.provinceName}";

    motelPostRequest.value.wards = towerChoose.value.wards;
    motelPostRequest.value.district = towerChoose.value.district;
    motelPostRequest.value.province = towerChoose.value.province;

    motelPostRequest.value.hasWc = towerChoose.value.hasWc;

    motelPostRequest.value.hasWindow = towerChoose.value.hasWindow;

    motelPostRequest.value.hasSecurity = towerChoose.value.hasSecurity;

    motelPostRequest.value.hasFreeMove = towerChoose.value.hasFreeMove;

    motelPostRequest.value.hasOwnOwner = towerChoose.value.hasOwnOwner;

    motelPostRequest.value.type = towerChoose.value.type;

    motelPostRequest.value.hasAirConditioner =
        towerChoose.value.hasAirConditioner;

    motelPostRequest.value.hasWaterHeater = towerChoose.value.hasWaterHeater;

    motelPostRequest.value.hasKitchen = towerChoose.value.hasKitchen;

    motelPostRequest.value.hasFridge = towerChoose.value.hasFridge;

    motelPostRequest.value.hasWashingMachine =
        towerChoose.value.hasWashingMachine;

    motelPostRequest.value.hasMezzanine = towerChoose.value.hasMezzanine;

    motelPostRequest.value.hasBed = towerChoose.value.hasBed;

    motelPostRequest.value.hasWardrobe = towerChoose.value.hasWardrobe;

    motelPostRequest.value.hasTivi = towerChoose.value.hasTivi;

    motelPostRequest.value.hasPet = towerChoose.value.hasPet;

    motelPostRequest.value.hasBalcony = towerChoose.value.hasBalcony;

    motelPostRequest.value.hourOpen = towerChoose.value.hourOpen;

    // motelPostRequest.value.hourClose = motelChoose.value.hourClose;
    // hourOpen.value = DateTime(0, 0, 0, motelChoose.value.hourOpen ?? 0,
    //     motelChoose.value.minuteOpen ?? 0);
    // hourClose.value = DateTime(0, 0, 0, motelChoose.value.hourClose ?? 0,
    //     motelChoose.value.minuteClose ?? 0);
    motelPostRequest.value.numberFloor = towerChoose.value.numberFloor;
    // numberFloor.text = motelChoose.value.numberFloor.toString();

    motelPostRequest.value.quantityVehicleParked =
        towerChoose.value.quantityVehicleParked;
    quantityVehicleParked.text =
        towerChoose.value.quantityVehicleParked == null ||
                towerChoose.value.quantityVehicleParked == 0
            ? ''
            : '${towerChoose.value.quantityVehicleParked}';
    motelPostRequest.value.hasFingerprint = towerChoose.value.hasFingerPrint;
    motelPostRequest.value.hasKitchenStuff = towerChoose.value.hasKitchenStuff;
    motelPostRequest.value.hasCeilingFans = towerChoose.value.hasCeilingFans;
    motelPostRequest.value.hasCurtain = motelChoose.value.hasCurtain;
    motelPostRequest.value.hasDecorativeLights =
        towerChoose.value.hasDecorativeLights;
    motelPostRequest.value.hasMattress = towerChoose.value.hasMattress;
    motelPostRequest.value.hasMirror = towerChoose.value.hasMirror;
    motelPostRequest.value.hasPicture = towerChoose.value.hasPicture;
    motelPostRequest.value.hasPillow = towerChoose.value.hasPillow;
    motelPostRequest.value.hasShoesRacks = towerChoose.value.hasShoesRasks;
    motelPostRequest.value.hasSofa = towerChoose.value.hasSofa;
    motelPostRequest.value.hasTable = towerChoose.value.hasTable;
    motelPostRequest.value.hasTree = towerChoose.value.hasTree;

    motelPostRequest.value.moneyCommissionAdmin = null;

    motelPostRequest.refresh();
  }

  void convertResponse() {
    if (motelPostRequest.value.towerId == null) {
      motelChoose(MotelRoom(
          id: motelPostRes.value.motelId,
          motelName: motelPostRes.value.motelName));
      motelPostRequest.value = motelPostRes.value;
      motelPostRequest.value.images = motelPostRes.value.images ?? [];
      listImages((motelPostRes.value.images ?? [])
          .map((e) => ImageData(linkImage: e))
          .toList());
      motelPostRequest.value.moServicesReq =
          motelPostRes.value.moServices ?? [];
      phoneNumberTextEditingController.text =
          motelPostRes.value.phoneNumber ?? "";
      titleTextEditingController.text = motelPostRes.value.title ?? "";
      descriptionTextEditingController.text =
          motelPostRes.value.description ?? "";
      roomNumberTextEditingController.text = motelPostRes.value.motelName ?? "";
      areaTextEditingController.text = motelPostRes.value.area.toString();
      capacityTextEditingController.text =
          motelPostRes.value.capacity.toString();
      moneyTextEditingController
              .text = /* motelPostInput?.money.toString() ?? "";*/
          SahaStringUtils()
              .removeDecimalZeroFormat(motelPostRes.value.money!)
              .toString();
      depositTextEditingController.text = SahaStringUtils()
          .removeDecimalZeroFormat(motelPostRes.value.deposit!)
          .toString();
      electricMoneyTextEditingController.text =
          motelPostRes.value.electricMoney.toString();
      waterMoneyTextEditingController.text =
          motelPostRes.value.waterMoney.toString();
      wifiMoneyTextEditingController.text =
          motelPostRes.value.wifiMoney.toString();
      parkMoneyTextEditingController.text =
          motelPostRes.value.parkMoney.toString();
      provinceNameTextEditingController.text =
          motelPostRes.value.provinceName ?? "";
      districtNameTextEditingController.text =
          motelPostRes.value.districtName ?? "";
      wardsNameTextEditingController.text = motelPostRes.value.wardsName ?? "";
      addressTextEditingController.text =
          "${motelPostRes.value.addressDetail} - ${motelPostRes.value.wardsName} - ${motelPostRes.value.districtName} - ${motelPostRes.value.provinceName}";
      hourOpen.value = DateTime(0, 0, 0, motelPostRes.value.hourOpen ?? 0,
          motelPostRes.value.minuteOpen ?? 0);
      hourClose.value = DateTime(0, 0, 0, motelPostRes.value.hourClose ?? 0,
          motelPostRes.value.minuteClose ?? 0);
      quantityVehicleParked.text =
          motelPostRes.value.quantityVehicleParked == null ||
                  motelPostRes.value.quantityVehicleParked == 0
              ? ''
              : '${motelPostRes.value.quantityVehicleParked}';

      numberFloor.text = motelPostRes.value.numberFloor.toString();

      moneyCommissionAdmin.text =
          motelPostRes.value.moneyCommissionAdmin != null
              ? SahaStringUtils()
                  .convertToUnit(motelPostRes.value.moneyCommissionAdmin)
              : '';
      moneyCommissionUser.text = motelPostRes.value.moneyCommissionUser != null
          ? SahaStringUtils()
              .convertToUnit(motelPostRes.value.moneyCommissionUser)
          : '';
      percentCommission.value = '${motelPostRes.value.percentCommission}%';
      percentCommmissionUser.text =
          '${motelPostRes.value.percentCommissionCollaborator ?? 0}';
    } else {
      towerChoose.value =
          Tower(id: motelPostRequest.value.towerId, towerName:  motelPostRequest.value.towerName);

      listImages((motelPostRes.value.images ?? [])
          .map((e) => ImageData(linkImage: e))
          .toList());

      phoneNumberTextEditingController.text =
          motelPostRes.value.phoneNumber ?? "";
      titleTextEditingController.text = motelPostRes.value.title ?? "";
      descriptionTextEditingController.text =
          motelPostRes.value.description ?? "";

      capacityTextEditingController.text =
          motelPostRes.value.capacity.toString();

      provinceNameTextEditingController.text =
          motelPostRes.value.provinceName ?? "";
      districtNameTextEditingController.text =
          motelPostRes.value.districtName ?? "";
      wardsNameTextEditingController.text = motelPostRes.value.wardsName ?? "";
      addressTextEditingController.text =
          "${motelPostRes.value.addressDetail} - ${motelPostRes.value.wardsName} - ${motelPostRes.value.districtName} - ${motelPostRes.value.provinceName}";
      // hourOpen.value = DateTime(0, 0, 0, motelPostRes.value.hourOpen ?? 0,
      //     motelPostRes.value.minuteOpen ?? 0);
      // hourClose.value = DateTime(0, 0, 0, motelPostRes.value.hourClose ?? 0,
      //     motelPostRes.value.minuteClose ?? 0);
      quantityVehicleParked.text =
          motelPostRes.value.quantityVehicleParked == null ||
                  motelPostRes.value.quantityVehicleParked == 0
              ? ''
              : '${motelPostRes.value.quantityVehicleParked}';

      //numberFloor.text = motelPostRes.value.numberFloor.toString();

      moneyCommissionAdmin.text =
          motelPostRes.value.moneyCommissionAdmin != null
              ? SahaStringUtils()
                  .convertToUnit(motelPostRes.value.moneyCommissionAdmin)
              : '';
      moneyCommissionUser.text = motelPostRes.value.moneyCommissionUser != null
          ? SahaStringUtils()
              .convertToUnit(motelPostRes.value.moneyCommissionUser)
          : '';
      percentCommission.value = '${motelPostRes.value.percentCommission}%';
      percentCommmissionUser.text =
          '${motelPostRes.value.percentCommissionCollaborator ?? 0}';
    }
  }
}
