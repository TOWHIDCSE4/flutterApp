import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/motel_post.dart';
import '../../../model/motel_room.dart';

class RoomInformationController extends GetxController {
  String? linkPost;
  var isLoading1 = false.obs;
  var roomPost = MotelPost().obs;
  int roomPostId;
  var hourOpen = DateTime(0, 0, 0, 0, 0, 0).obs;
  var hourClose = DateTime(0, 0, 0, 0, 0, 0).obs;
  var isFavourite = false.obs;

  var listSimilarPost = RxList<MotelPost>();
  var changeHeight = 35.0.obs;
  var opacity = .0.obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  String? textSearch;
  
  double? minMoney;
  double? maxMoney;
  var motelRoomChoose = MotelRoom().obs;
  var isTower = false.obs;
  RoomInformationController({required this.roomPostId}) {
    getRoomPost();
    getAllRoomPostSimilar(isRefresh: true);
  }

  Future<void> getAllRoomPostSimilar({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data =
            await RepositoryManager.roomPostRepository.getAllRoomPostSimilar(
          page: currentPage,
          postId: roomPostId,
        );
        if (isRefresh == true) {
          listSimilarPost(data!.data!.data!);
          listSimilarPost.refresh();
        } else {
          listSimilarPost.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getRoomPost() async {
    isLoading1.value = true;
    try {
      var res = await RepositoryManager.roomPostRepository
          .getRoomPost(roomPostId: roomPostId);
      roomPost.value = res!.data!;

      if (roomPost.value.towerId != null) {
        findMaxMinMoney();
        
      }
      if (roomPost.value.motelId != null) {

        motelRoomChoose.value = MotelRoom(
            images: roomPost.value.images,
            videoLink: roomPost.value.linkVideo,
            id: roomPost.value.motelId,
            numberFloor: roomPost.value.numberFloor,
            area: roomPost.value.area,
            deposit: roomPost.value.deposit,
            capacity: roomPost.value.capacity,
            money: roomPost.value.money,
            quantityVehicleParked: roomPost.value.quantityVehicleParked,
            hasAirConditioner: roomPost.value.hasAirConditioner,
            hasBalcony: roomPost.value.hasBalcony,
            hasBed: roomPost.value.hasBed,
            hasCeilingFans: roomPost.value.hasCeilingFans,
            hasCurtain: roomPost.value.hasCurtain,
            hasDecorativeLights: roomPost.value.hasDecorativeLights,
            hasFingerprint: roomPost.value.hasFingerprint,
            hasFreeMove: roomPost.value.hasFreeMove,
            hasFridge: roomPost.value.hasFridge,
            hasKitchen: roomPost.value.hasKitchen,
            hasKitchenStuff: roomPost.value.hasKitchenStuff,
            hasMattress: roomPost.value.hasMattress,
            hasMezzanine: roomPost.value.hasMezzanine,
            hasMirror: roomPost.value.hasMirror,
            hasOwnOwner: roomPost.value.hasOwnOwner,
            hasPark: roomPost.value.hasPark,
            hasPet: roomPost.value.hasPet,
            hasPicture: roomPost.value.hasPicture,
            hasPillow: roomPost.value.hasPillow,
            hasSecurity: roomPost.value.hasSecurity,
            hasShoesRacks:roomPost.value.hasShoesRacks,
            hasSofa: roomPost.value.hasSofa,
            hasTable: roomPost.value.hasTable,
            hasTivi: roomPost.value.hasTivi,
            hasTree: roomPost.value.hasTree,
            hasWardrobe: roomPost.value.hasWardrobe,
            hasWashingMachine: roomPost.value.hasWashingMachine,
            hasWaterHeater: roomPost.value.hasWaterHeater,
            hasWc: roomPost.value.hasWc,
            hasWifi: roomPost.value.hasWifi,
            hasWindow: roomPost.value.hasWindow

            );
      }
      hourOpen.value = DateTime(0, 0, 0, roomPost.value.hourOpen ?? 0,
          roomPost.value.minuteOpen ?? 0);
      hourClose.value = DateTime(0, 0, 0, roomPost.value.hourClose ?? 0,
          roomPost.value.minuteClose ?? 0);
      isFavourite.value = roomPost.value.isFavorite!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading1.value = false;
  }

  Future<void> setFavouritePost({required int id}) async {
    try {
      var res = await RepositoryManager.userManageRepository
          .setFavouritePost(id: id, isFavourite: roomPost.value.isFavorite);
      isFavourite.value = roomPost.value.isFavorite!;
      if (roomPost.value.isFavorite == true) {
        SahaAlert.showSuccess(message: "Đã thêm vào bài đăng yêu thích");
      }
      if (roomPost.value.isFavorite == false) {
        SahaAlert.showSuccess(message: "Đã bỏ yêu thích bài đăng này");
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> callRequest() async {
    try {
      var res = await RepositoryManager.roomPostRepository
          .callRequest(id: roomPostId);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addPotentialUser({required int typeFrom}) async {
    try {
      var res = await RepositoryManager.userManageRepository
          .addPotentialUser(postId: roomPostId, typeFrom: typeFrom);
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  void findMaxMinMoney() {
    if((roomPost.value.listMotel ?? []).isNotEmpty){
       maxMoney = roomPost.value.listMotel!
        .reduce(
            (value, element) => value.money! > element.money! ? value : element)
        .money;
    minMoney = roomPost.value.listMotel!
        .reduce(
            (value, element) => value.money! < element.money! ? value : element)
        .money;
    }
   
  }
Future<void> buildLink() async{
  try {
  final dynamicLinkParams = DynamicLinkParameters(
    
  link: Uri.parse("https://rencity.page.link/post/$roomPostId"),
  uriPrefix: "https://rencity.page.link",
  androidParameters: const AndroidParameters(packageName: "com.ikitech.rencity"),
  iosParameters: const IOSParameters(bundleId: "com.ikitech.rencity",appStoreId: "6443961326"),
  
  );
  final dynamicLink =
    await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  print(dynamicLink.shortUrl);
  linkPost = dynamicLink.shortUrl.toString();
}  catch (e) {
  SahaAlert.showError(message: e.toString());
}
  
}







}
