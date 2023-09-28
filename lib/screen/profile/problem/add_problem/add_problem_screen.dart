import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/components/widget/video_picker_single/video_picker_single.dart';

import 'package:gohomy/screen/profile/problem/add_problem/add_problem_controller.dart';

import 'package:intl/intl.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/button/saha_button.dart';
import '../../../../components/dialog/dialog.dart';
import '../../../../components/text_field/text_field_no_border.dart';
import '../../../../components/widget/image/select_images.dart';
import '../../../../const/type_image.dart';
import '../../../../model/image_assset.dart';
import '../../../owner/choose_room/choose_room_screen.dart';

class AddProblemScreen extends StatelessWidget {
  late AddProblemController addProblemController;
  final _formKey = GlobalKey<FormState>();
  int? problemId;

  AddProblemScreen({this.problemId}) {
    addProblemController = AddProblemController(problemId: problemId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Color(0xFFEF4355),
                    Color(0xFFFF964E),
                  ]),
            ),
          ),
          actions: [
            Obx(() => addProblemController.problemRes.value.status == 0
                ? IconButton(
                    onPressed: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: 'Bạn có chắc chắn muốn xoá báo cáo này chứ ?',
                          onOK: () {
                            addProblemController.deleteProblem(
                                problemId: problemId!);
                          });
                    },
                    icon: const Icon(Icons.delete))
                : const SizedBox())
          ],
          title: Text(problemId != null ? 'Chỉnh sửa sự cố' : 'Tạo mới sự cố'),
        ),
        body: Obx(
          () => addProblemController.isLoading.value
              ? SahaLoadingFullScreen()
              : Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => ChooseRoomScreen(
                                isUser: true,
                                hasContract: true,
                                listMotelInput:
                                    addProblemController.listRoomChoose,
                                isChooseFromBill: true,
                                onChoose: (v) {
                                  addProblemController.motelChoose.value.id =
                                      v[0].id;
                                  addProblemController.motelChoose.value = v[0];
                                  addProblemController.listRoomChoose(
                                      [addProblemController.motelChoose.value]);
                                },
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 15,
                            right: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Chọn phòng *",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => Text(
                                        addProblemController
                                                    .motelChoose.value.id ==
                                                null
                                            ? 'chọn phòng'
                                            : addProblemController.motelChoose
                                                    .value.motelName ??
                                                "",
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                  )
                                ],
                              ),
                              const Divider()
                            ],
                          ),
                        ),
                      ),
                      SahaTextFieldNoBorder(
                        withAsterisk: true,
                        controller: addProblemController.reasonEdit,
                        onChanged: (v) {
                          addProblemController.problemReq.value.reason = v;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        labelText: "Sự cố",
                        hintText: "Nhập tóm tắt sự cố",
                      ),
                      SahaTextFieldNoBorder(
                        withAsterisk: true,
                        controller: addProblemController.descriptionEdit,
                        onChanged: (v) {
                          addProblemController
                              .problemReq.value.describeProblem = v;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        labelText: "Mô tả sự cố",
                        hintText: "Nhập mô tả (ghi chú) khi giải quyết sự cố",
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectImages(
                            type: PROBLEM_FILES_FOLDER,
                            maxImage: 10,
                            title: 'Ảnh sự cố',
                            subTitle: 'Tối đa 10 hình',
                            onUpload: () {},
                            images: addProblemController.listImages.toList(),
                            doneUpload: (List<ImageData> listImages) {
                              print(
                                  "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");

                              addProblemController.listImages(listImages);
                              if ((listImages.map((e) => e.linkImage ?? "x"))
                                  .toList()
                                  .contains('x')) {
                                SahaAlert.showError(message: 'Lỗi ảnh');
                                return;
                              }
                              addProblemController.problemReq.value.images =
                                  (listImages.map((e) => e.linkImage ?? ""))
                                      .toList();

                              print(
                                  addProblemController.problemReq.value.images);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Obx(
                          () => VideoPickerSingle(
                           
                            linkVideo:
                                addProblemController.problemReq.value.linkVideo,
                            onChange: (File? file) async {
                              if (file == null) {
                                addProblemController
                                    .problemReq.value.linkVideo = null;
                              }
                              addProblemController.file = file;
                              print(file);
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Mức độ nghiêm trọng'),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Obx(
                                      () => Checkbox(
                                          value: addProblemController
                                                  .problemReq.value.severity ==
                                              0,
                                          onChanged: (v) {
                                            addProblemController
                                                .problemReq.value.severity = 0;
                                            addProblemController.problemReq
                                                .refresh();
                                          }),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.red,
                                      ),
                                      child: const Text(
                                        'Cao',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Obx(
                                      () => Checkbox(
                                          value: addProblemController
                                                  .problemReq.value.severity ==
                                              1,
                                          onChanged: (v) {
                                            addProblemController
                                                .problemReq.value.severity = 1;
                                            addProblemController.problemReq
                                                .refresh();
                                          }),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: const Text(
                                        'Trung bình',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Obx(
                                      () => Checkbox(
                                          value: addProblemController
                                                  .problemReq.value.severity ==
                                              2,
                                          onChanged: (v) {
                                            addProblemController
                                                .problemReq.value.severity = 2;
                                            addProblemController.problemReq
                                                .refresh();
                                          }),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.amber,
                                      ),
                                      child: const Text(
                                        'Thấp',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      if (problemId != null)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              const Text('Ngày tạo sự cố'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy').format(
                                    addProblemController
                                        .problemRes.value.createdAt!),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                    ]),
                  ),
                ),
        ),
        bottomNavigationBar: Obx(
          () => addProblemController.problemRes.value.status == 2
              ? Container(
                  height: 1,
                )
              : SizedBox(
                  height: 65,
                  child: Column(
                    children: [
                      SahaButtonFullParent(
                        color: const Color(0xFFEF4355),
                        text: problemId != null ? "Xác nhận" : "Báo cáo sự cố",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (problemId != null) {
                              addProblemController.updateProblem();
                            } else {
                              addProblemController.addProblem();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
