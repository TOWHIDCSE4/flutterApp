import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/motel_room.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/image_assset.dart';
import '../../../../model/problem.dart';

class AddProblemOwnerController extends GetxController {
  TextEditingController reasonEdit = TextEditingController();
  TextEditingController descriptionEdit = TextEditingController();
  var motelChoose = MotelRoom().obs;
  var isLoadingUpdate = false.obs;
  bool isEnd = false;
  var isLoading = false.obs;
  var problemRes = Problem().obs;
  var problemReq = Problem().obs;
  var listImages = RxList<ImageData>([]);

  int? problemId;
  DataAppController dataAppController = Get.find();
  AddProblemOwnerController({this.problemId}) {
    problemReq.value.images = [];
    if (problemId != null) {
      getProblem();
    }
  }

  Future<void> getProblem() async {
    try {
      isLoading.value = true;
      var data = await RepositoryManager.manageRepository.getProblemOwner(
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

  Future<void> updateProblemOwner() async {
    isLoadingUpdate.value = true;
    problemReq.value.motelId = motelChoose.value.id;
    try {
      var data = await RepositoryManager.manageRepository.updateProblemOwner(
        problemId: problemId!,
        status: 2,
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
      dataAppController.getBadge();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
  }

  Future<void> deleteProblemOwner() async {
    try {
      var res = await RepositoryManager.manageRepository
          .deleteProblemOwner(problemId: problemId!);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
