import 'package:get/get.dart';

import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/motel_room.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../model/image_assset.dart';
import '../../../../model/service.dart';

class MotelRoomDetailsController extends GetxController {
  var motelRoom = MotelRoom().obs;
  var isLoadInit = true.obs;
  var listImages = RxList<ImageData>([]);
  var listService = RxList<Service>();
  var hourOpen = DateTime(0, 0, 0, 0, 0, 0).obs;
  var hourClose = DateTime(0, 0, 0, 0, 0, 0).obs;
  MotelRoomDetailsController();
  Future<void> getAdminMotelRoom(int id) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .getAdminMotelRoom(id: id);
      motelRoom.value = res!.data!;
      listImages((motelRoom.value.images ?? [])
          .map((e) => ImageData(linkImage: e))
          .toList());
      hourOpen.value = DateTime(0, 0, 0, motelRoom.value.hourOpen ?? 0,
          motelRoom.value.minuteOpen ?? 0);
      hourClose.value = DateTime(0, 0, 0, motelRoom.value.hourClose ?? 0,
          motelRoom.value.minuteClose ?? 0);
      isLoadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllService() async {
    try {
      var data = await RepositoryManager.manageRepository.getAllService();
      listService(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteAdminMotelRoom({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .deleteAdminMotelRoom(id: id);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
