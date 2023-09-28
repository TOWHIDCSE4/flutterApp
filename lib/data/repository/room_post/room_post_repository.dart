import 'package:gohomy/data/remote/response-request/success/success_response.dart';
import 'package:gohomy/model/find_fast_motel.dart';
import 'package:gohomy/model/reservation_motel.dart';

import '../../remote/response-request/room_post/all_room_post_res.dart';
import '../../remote/response-request/room_post/find_fast_motel_res.dart';
import '../../remote/response-request/room_post/location_find_req.dart';
import '../../remote/response-request/room_post/reservation_motel_res.dart';
import '../../remote/response-request/room_post/room_post_res.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class RoomPostRepository {
  Future<AllRoomPost?> getAllRoomPost({
    required int page,
    String? search,
    int? wards,
    int? district,
    int? province,

    ///Tien nghi
    bool? hasWc,
    bool? hasMezzanine,
    bool? hasBalcony,
    bool? hasFingerprint, ////
    bool? hasOwnOwner,
    bool? hasPet,
    ////Noi that
    bool? hasAirConditioner,
    bool? hasWaterHeater,
    bool? hasKitchen,
    bool? hasWindow,
    bool? hasSecurity,
    bool? hasFreeMove,
    bool? hasFridge,
    bool? hasBed,
    bool? hasWashingMachine,
    bool? hasKitchenStuff, ////
    bool? hasTable, /////
    bool? hasDecorativeLights, /////
    bool? hasPicture, /////
    bool? hasTree, /////
    bool? hasPillow, ////
    bool? hasWardrobe,
    bool? hasMattress, ////
    bool? hasShoesRacks, ////
    bool? hasCurtain, ////
    bool? hasCeilingFans, ////
    bool? hasMirror, ////
    bool? hasSofa,

    ///
    bool? hasTivi,
    double? fromMoney,
    double? maxMoney,
    bool? descending,
    String? sortBy,
    String? phoneNumber,
    String? listType,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getAllRoomPost(
            page,
            search,
            wards,
            district,
            province,
            hasPet,
            hasTivi,
            hasWc,
            hasWindow,
            hasSecurity,
            hasFreeMove,
            hasOwnOwner,
            hasAirConditioner,
            hasWaterHeater,
            hasKitchen,
            hasFridge,
            hasWashingMachine,
            hasMezzanine,
            hasBed,
            hasWardrobe,
            hasBalcony,
            hasFingerprint,
            hasKitchenStuff,
            hasCeilingFans,
            hasCurtain,
            hasDecorativeLights,
            hasMattress,
            hasMirror,
            hasSofa,
            hasPicture,
            hasPillow,
            hasTable,
            hasShoesRacks,
            hasTree,
            fromMoney,
            maxMoney,
            descending,
            sortBy,
            phoneNumber,
            listType,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllRoomPost?> getAllMoPostLocationFind(
      {required int page, required LocationFindReq locationFindReq}) async {
    try {
      var res = await SahaServiceManager().service!.getAllMoPostLocationFind(
            page,
            locationFindReq.toJson(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllRoomPost?> getAllRoomPostSimilar({
    required int page,
    required int postId,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getAllRoomPostSimilar(
            postId,
            page,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<RoomPostRes?> getRoomPost({required int roomPostId}) async {
    try {
      var res = await SahaServiceManager().service!.getRoomPost(roomPostId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<FindFastMotelRes?> addFindFastMotel(
      {required FindFastMotel findFastMotel}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addFindFastMotel(findFastMotel.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReservationMotelRes?> addReservationMotel(
      {required ReservationMotel reservationMotel}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addReservationMotel(reservationMotel.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> callRequest({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.callRequest(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> callFindRoom({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.callFindRoom(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
   Future<SuccessResponse?> callPostRoommate({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.callPostRoommate(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}
