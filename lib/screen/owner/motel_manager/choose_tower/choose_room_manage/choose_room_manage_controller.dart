import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/motel_room/motal_room_res.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/motel_room.dart';

class ChooseRoomManageController extends GetxController {
  var listMotelRoomSelected = RxList<MotelRoom>();
  var listMotelRoom = RxList<MotelRoom>();
  var isAll = false.obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;
  List<MotelRoom>? listMotelInput;
  String? textSearch;
  bool isAdd;
  int? supportId;

  var status = 0.obs;

  int? towerId;

  var floorFromEdit = TextEditingController();
  var floorToEdit = TextEditingController();
  int? floorFrom;
  int? floorTo; 
  

  ChooseRoomManageController({
    this.listMotelInput,
    this.towerId,
    this.supportId,
    required this.isAdd
  }) {
    if (listMotelInput != null) {
      listMotelRoomSelected(listMotelInput);
    }
    getAllMotelSupport(isRefresh: true);
  }

  Future<void> getAllMotelSupport({
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

        data = await RepositoryManager.manageRepository.getAllMotelSupport(
            search: textSearch,
            page: currentPage,
            limit: 100,
            towerId: towerId,
            isHaveTower: true,floorFrom: floorFrom,floorTo: floorTo,
            isHaveSupperter : isAdd == true ? false : null,
            manageSupporterId: supportId
            );

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
