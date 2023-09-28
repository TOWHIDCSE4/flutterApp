import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/manage/post_roommate_filter.dart';
import 'package:gohomy/model/post_roommate.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/remote/response-request/manage/motel_post_req.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/location_address.dart';

class ListPostRoommateController extends GetxController{
  var listAllPostRoommate = RxList<PostRoommate>();
  var changeHeight = 35.0.obs;
  var opacity = .0.obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;
  String? textSearch;
  double? fromMoney;
  double? maxMoney;
  String? phoneNumber;
  var motelPostFilter = PostRoommateFilter().obs;
  var heightFilter = 50.0.obs;
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;
  bool? isNewest;
  void changeOpacitySearch(double va) {
    opacity.value = va;
  }

  void changeHeightAppbar(double va) {
    changeHeight.value = va;
  }

  
  LocationAddress? locationProvinceInput;
  LocationAddress? locationDistrictInput;

  ListPostRoommateController(
      {
      this.locationDistrictInput,
      this.locationProvinceInput,
      this.phoneNumber,
      this.isNewest}) {
    if (locationDistrictInput != null) {
      locationDistrict.value = locationDistrictInput!;
    }

    if (locationProvinceInput != null) {
      locationProvince.value = locationProvinceInput!;
    }
    if (isNewest == true) {
      motelPostFilter.value.sortBy = 'created_at';
    }

    getAllPostRoommate(isRefresh: true);
  }

  Future<void> getAllPostRoommate({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    motelPostFilter.value.province = locationProvince.value.id;
    motelPostFilter.value.district = locationDistrict.value.id;
    motelPostFilter.value.wards = locationWard.value.id;

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.userManageRepository.getAllPostRoommate(
          page: currentPage,
          search: textSearch,
          isAll: true,
          district: motelPostFilter.value.district,
          province: motelPostFilter.value.province,
          wards: motelPostFilter.value.wards,
          hasPet: motelPostFilter.value.hasPet == true ? true : null,
          hasTivi: motelPostFilter.value.hasTivi == true ? true : null,
          hasWc: motelPostFilter.value.hasWc == true ? true : null,
          hasWindow: motelPostFilter.value.hasWindow == true ? true : null,
          hasSecurity: motelPostFilter.value.hasSecurity == true ? true : null,
          hasFreeMove: motelPostFilter.value.hasFreeMove == true ? true : null,
          hasOwnOwner: motelPostFilter.value.hasOwnOwner == true ? true : null,
          hasAirConditioner:
              motelPostFilter.value.hasAirConditioner == true ? true : null,
          hasWaterHeater:
              motelPostFilter.value.hasWaterHeater == true ? true : null,
          hasKitchen: motelPostFilter.value.hasKitchen == true ? true : null,
          hasFridge: motelPostFilter.value.hasFridge == true ? true : null,
          hasWashingMachine:
              motelPostFilter.value.hasWashingMachine == true ? true : null,
          hasMezzanine:
              motelPostFilter.value.hasMezzanine == true ? true : null,
          hasBed: motelPostFilter.value.hasBed == true ? true : null,
          hasWardrobe: motelPostFilter.value.hasWardrobe == true ? true : null,
          hasBalcony: motelPostFilter.value.hasBalcony == true ? true : null,
          hasCeilingFans:
              motelPostFilter.value.hasCeilingFans == true ? true : null,
          hasCurtain: motelPostFilter.value.hasCurtain == true ? true : null,
          hasDecorativeLights:
              motelPostFilter.value.hasDecorativeLights == true ? true : null,
          hasFingerprint:
              motelPostFilter.value.hasFingerprint == true ? true : null,
          hasKitchenStuff:
              motelPostFilter.value.hasKitchenStuff == true ? true : null,
          hasMattress: motelPostFilter.value.hasMattress == true ? true : null,
          hasMirror: motelPostFilter.value.hasMirror == true ? true : null,
          hasPicture: motelPostFilter.value.hasPicture == true ? true : null,
          hasPillow: motelPostFilter.value.hasPillow == true ? true : null,
          hasShoesRacks:
              motelPostFilter.value.hasShoesRacks == true ? true : null,
          hasSofa: motelPostFilter.value.hasSofa == true ? true : null,
          hasTable: motelPostFilter.value.hasTable == true ? true : null,
          hasTree: motelPostFilter.value.hasTree == true ? true : null,
          fromMoney: motelPostFilter.value.fromMoney,
          maxMoney: motelPostFilter.value.maxMoney,
          descending: motelPostFilter.value.descending,
          sortBy: motelPostFilter.value.sortBy,
          phoneNumber: phoneNumber,
          listType: motelPostFilter.value.listType == null
              ? null
              : motelPostFilter.value.listType.toString().replaceAll(" ", ""),
          
        );
       
        if (isRefresh == true) {
          listAllPostRoommate(data!.data!.data!);
          listAllPostRoommate.refresh();
        } else {
          listAllPostRoommate.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      loadInit.value = false;
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}