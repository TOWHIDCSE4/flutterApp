import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/motel_post.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../model/motel_room.dart';

class PostDetailsController extends GetxController {
  var motelPost = MotelPost().obs;
  var loadInit = true.obs;
  var isVerified = false.obs;
  int id;
  //var motelPostRequest = MotelPost(id: 0).obs;
  double? minMoney;
  double? maxMoney;
  var motelRoomChoose = MotelRoom().obs;

  PostDetailsController({required this.id}) {
    getMotelPost();
  }

  Future<void> getMotelPost() async {
    try {
      loadInit.value = true;
      var res = await RepositoryManager.roomPostRepository
          .getRoomPost(roomPostId: id);
      motelPost.value = res!.data!;

      if (motelPost.value.towerId != null) {
        findMaxMinMoney();
      }
      if (motelPost.value.motelId != null) {

        motelRoomChoose.value = MotelRoom(
            id: motelPost.value.motelId,
            images: motelPost.value.images,
            numberFloor: motelPost.value.numberFloor,
            videoLink: motelPost.value.linkVideo,
            area: motelPost.value.area,
            deposit: motelPost.value.deposit,
            capacity: motelPost.value.capacity,
            money: motelPost.value.money,
            quantityVehicleParked: motelPost.value.quantityVehicleParked,
            hasAirConditioner: motelPost.value.hasAirConditioner,
            hasBalcony: motelPost.value.hasBalcony,
            hasBed: motelPost.value.hasBed,
            hasCeilingFans: motelPost.value.hasCeilingFans,
            hasCurtain: motelPost.value.hasCurtain,
            hasDecorativeLights: motelPost.value.hasDecorativeLights,
            hasFingerprint: motelPost.value.hasFingerprint,
            hasFreeMove: motelPost.value.hasFreeMove,
            hasFridge: motelPost.value.hasFridge,
            hasKitchen: motelPost.value.hasKitchen,
            hasKitchenStuff: motelPost.value.hasKitchenStuff,
            hasMattress: motelPost.value.hasMattress,
            hasMezzanine: motelPost.value.hasMezzanine,
            hasMirror: motelPost.value.hasMirror,
            hasOwnOwner: motelPost.value.hasOwnOwner,
            hasPark: motelPost.value.hasPark,
            hasPet: motelPost.value.hasPet,
            hasPicture: motelPost.value.hasPicture,
            hasPillow: motelPost.value.hasPillow,
            hasSecurity: motelPost.value.hasSecurity,
            hasShoesRacks:motelPost.value.hasShoesRacks,
            hasSofa: motelPost.value.hasSofa,
            hasTable: motelPost.value.hasTable,
            hasTivi: motelPost.value.hasTivi,
            hasTree: motelPost.value.hasTree,
            hasWardrobe: motelPost.value.hasWardrobe,
            hasWashingMachine: motelPost.value.hasWashingMachine,
            hasWaterHeater: motelPost.value.hasWaterHeater,
            hasWc: motelPost.value.hasWc,
            hasWifi: motelPost.value.hasWifi,
            hasWindow: motelPost.value.hasWindow
            );
      }

      isVerified.value = res.data!.adminVerified!;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteMotelPost() async {
    try {
      var res =
          await RepositoryManager.adminManageRepository.deleteMotelPost(id: id);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> approvePost({required int stt}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .approvePost(id: id, stt: stt);
      Get.back();
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> verify({required bool verifyPost, bool? isBack}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .verify(id: id, adminVerified: verifyPost);
      SahaAlert.showSuccess(message: "Thành công");
      if (isBack == false) return;
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void findMaxMinMoney() {
    if((motelPost.value.listMotel ?? []).isNotEmpty){
       maxMoney = motelPost.value.listMotel!
        .reduce(
            (value, element) => value.money! > element.money! ? value : element)
        .money;
        minMoney = motelPost.value.listMotel!
        .reduce(
            (value, element) => value.money! < element.money! ? value : element)
        .money;
    }
   
  }
}
