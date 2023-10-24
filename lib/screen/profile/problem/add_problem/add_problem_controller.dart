import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_widget.dart';
import 'package:gohomy/model/motel_room.dart';
import 'package:gohomy/screen/data_app_controller.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../const/type_image.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/image_assset.dart';
import '../../../../model/problem.dart';

class AddProblemController extends GetxController {
  var listRoomChoose = RxList<MotelRoom>();
  TextEditingController reasonEdit = TextEditingController();
  TextEditingController descriptionEdit = TextEditingController();
  var motelChoose = MotelRoom().obs;
  var motelChoose2 = MotelRoom().obs;
  var isLoadingUpdate = false.obs;
  bool isEnd = false;
  var isLoading = false.obs;
  var problemRes = Problem().obs;
  var problemReq = Problem().obs;
  var listImages = RxList<ImageData>([]);

  File? file;
  var type = PROBLEM_FILES_FOLDER;
  int? problemId;

  DataAppController dataAppController = Get.find();

  AddProblemController({this.problemId}) {
    problemReq.value.images = [];
    if (problemId != null) {
      getProblem();
    }
  }

  Future<void> getProblem() async {
    try {
      isLoading.value = true;
      var data = await RepositoryManager.userManageRepository.getProblem(
        problemId: problemId!,
      );

      problemReq.value.images = data!.data!.images ?? [];
      listImages((data.data?.images ?? [])
          .map((e) => ImageData(linkImage: e))
          .toList());
      problemReq.value = data.data!;
      problemRes.value = data.data!;
      motelChoose.value = data.data!.motel ?? MotelRoom();
      reasonEdit.text = data.data!.reason ?? "";
      descriptionEdit.text = data.data!.describeProblem ?? "";
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addProblem() async {
    problemReq.value.motelId = motelChoose.value.id;
    if (motelChoose.value.id == null) {
      SahaAlert.showError(message: 'Chưa chọn phòng');
      return;
    }
    try {
      if (file != null) {
        showDialogSuccess('Đang tạo sự cố');
        await upVideo();
        Get.back();
      }
      var data = await RepositoryManager.userManageRepository.addProblem(
        problem: problemReq.value,
      );
      SahaAlert.showSuccess(message: "Thêm thành công");
      dataAppController.getBadge();
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
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
      problemReq.value.linkVideo = link;
      return link;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    return null;
  }

  Future<void> updateProblem() async {
    isLoadingUpdate.value = true;
    problemReq.value.motelId = motelChoose.value.id;
    try {
      if (file != null) {
        showDialogSuccess('Đang cập nhật sự cố');
        await upVideo();
        Get.back();
      }
      var data = await RepositoryManager.userManageRepository.updateProblem(
        problemId: problemId!,
        problem: problemReq.value,
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
      dataAppController.getBadge();
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
  }

  Future<void> deleteProblem({required int problemId}) async {
    try {
      var res = await RepositoryManager.userManageRepository
          .deleteProblem(problemId: problemId);
      SahaAlert.showSuccess(message: "Xoá thành công");
      dataAppController.getBadge();
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
