import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/motel_room/motal_room_res.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/motel_room.dart';

class ChooseRoomController extends GetxController {
  var listMotelRoomSelected = RxList<MotelRoom>();
  var listMotelRoom = RxList<MotelRoom>();
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;
  List<MotelRoom>? listMotelInput;
  String? textSearch;

  var status = 0.obs;
  bool? hasContract;
  bool? isUser;
  bool? hasPost;
  int? towerId;
  bool? isTower;
  bool? isSupporter;

  ChooseRoomController(
      {this.listMotelInput,
      this.isSupporter,
      this.hasContract,
      this.isUser,
      this.hasPost,
      this.towerId,
      this.isTower}) {
    if (listMotelInput != null) {
      listMotelRoomSelected(listMotelInput);
    }
    getAllMotelRoom(isRefresh: true);
  }

  Future<void> getAllMotelRoom({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        AllMotelRoomRes? data;
        if (isUser == true) {
          data = await RepositoryManager.userManageRepository.getUserMotelRoom(
              search: textSearch, page: currentPage, hasContract: hasContract);
        } else {
          data = await RepositoryManager.manageRepository.getAllMotelRoom(
              search: textSearch,
              page: currentPage,
              hasContract: hasContract,
              hasPost: hasPost,
              towerId: towerId,
              isHaveTower: isTower,isSupporter: isSupporter);
        }

        if (isRefresh == true) {
          listMotelRoom(data!.data!.data!);
          listMotelRoom.refresh();
        } else {
          listMotelRoom.addAll(data!.data!.data!);
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
