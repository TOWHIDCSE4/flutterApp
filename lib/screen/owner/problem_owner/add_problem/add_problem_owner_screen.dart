import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:intl/intl.dart';
import 'package:video_compress/video_compress.dart';
import '../../../../components/button/saha_button.dart';
import '../../../../components/dialog/dialog.dart';
import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/text_field/text_field_no_border.dart';
import '../../../../components/widget/image/show_image.dart';
import '../../../../components/widget/video_picker_single/video_picker_single.dart';
import '../../../owner/choose_room/choose_room_screen.dart';
import 'add_problem_owner_controller.dart';

class AddProblemOwnerScreen extends StatelessWidget {
  late AddProblemOwnerController addProblemOwnerController;
  final _formKey = GlobalKey<FormState>();
  int? problemId;
  
  AddProblemOwnerScreen({this.problemId}) {
    addProblemOwnerController = AddProblemOwnerController(problemId: problemId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: Text(problemId != null ? 'Xem sự cố' : 'Tạo mới sự cố'),
      ),
      body: Obx(
        () => addProblemOwnerController.isLoading.value
            ? SahaLoadingFullScreen()
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IgnorePointer(
                          ignoring: true,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => ChooseRoomScreen(
                                        onChoose: (v) {
                                          addProblemOwnerController
                                              .motelChoose.value.id = v[0].id;
                                          addProblemOwnerController
                                              .motelChoose.value = v[0];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Phòng",
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
                                                addProblemOwnerController
                                                            .motelChoose
                                                            .value
                                                            .id ==
                                                        null
                                                    ? 'chọn phòng'
                                                    : addProblemOwnerController.motelChoose.value.motelName ?? "",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                ),
                              ),
                              SahaTextFieldNoBorder(
                                withAsterisk: true,
                                controller:
                                    addProblemOwnerController.reasonEdit,
                                onChanged: (v) {
                                  addProblemOwnerController
                                      .problemReq.value.reason = v;
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
                                controller:
                                    addProblemOwnerController.descriptionEdit,
                                onChanged: (v) {
                                  addProblemOwnerController
                                      .problemReq.value.describeProblem = v;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Không được để trống';
                                  }
                                  return null;
                                },
                                labelText: "Mô tả sự cố",
                                hintText:
                                    "Nhập mô tả (ghi chú) khi giải quyết sự cố",
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: addProblemOwnerController
                                        .listImages
                                        .map(
                                          (e) => InkWell(
                                            onTap: () {
                                              ShowImage.seeImage(
                                                  listImageUrl:
                                                      (addProblemOwnerController
                                                          .listImages
                                                          .map((e) =>
                                                              e.linkImage ?? "")
                                                          .toList()),
                                                  index:
                                                      (addProblemOwnerController
                                                              .listImages
                                                              .map((e) =>
                                                                  e.linkImage ??
                                                                  "")
                                                              .toList())
                                                          .indexOf(
                                                              e.linkImage ??
                                                                  ""));
                                            },
                                            child: Container(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                child: CachedNetworkImage(
                                                  height: 95,
                                                  width: 95,
                                                  fit: BoxFit.cover,
                                                  imageUrl: e.linkImage ?? "",
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const SahaEmptyImage(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Obx(
                            () => VideoPickerSingle(
                             
                              isWatch: problemId != null ? true : false,
                              linkVideo: addProblemOwnerController
                                  .problemReq.value.linkVideo,
                              onChange: (File? file) async {
                                // addProblemController.file = file;
                                // print(file);
                              },
                            ),
                          ),
                        ),
                        IgnorePointer(
                          ignoring: true,
                          child: Column(
                            children: [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Obx(
                                              () => Checkbox(
                                                  value:
                                                      addProblemOwnerController
                                                              .problemReq
                                                              .value
                                                              .severity ==
                                                          0,
                                                  onChanged: (v) {
                                                    addProblemOwnerController
                                                        .problemReq
                                                        .value
                                                        .severity = 0;
                                                    addProblemOwnerController
                                                        .problemReq
                                                        .refresh();
                                                  }),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
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
                                                  value:
                                                      addProblemOwnerController
                                                              .problemReq
                                                              .value
                                                              .severity ==
                                                          1,
                                                  onChanged: (v) {
                                                    addProblemOwnerController
                                                        .problemReq
                                                        .value
                                                        .severity = 1;
                                                    addProblemOwnerController
                                                        .problemReq
                                                        .refresh();
                                                  }),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                                                  value:
                                                      addProblemOwnerController
                                                              .problemReq
                                                              .value
                                                              .severity ==
                                                          2,
                                                  onChanged: (v) {
                                                    addProblemOwnerController
                                                        .problemReq
                                                        .value
                                                        .severity = 2;
                                                    addProblemOwnerController
                                                        .problemReq
                                                        .refresh();
                                                  }),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
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
                              if (addProblemOwnerController.problemId != null)
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      const Text('Ngày tạo sự cố'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        DateFormat('dd-MM-yyyy').format(addProblemOwnerController.problemRes.value.createdAt!),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        )
                      ]),
                ),
              ),
      ),
      bottomNavigationBar:
          Obx(() => addProblemOwnerController.problemRes.value.status == 2
              ? SizedBox(
                  height: 65,
                  child: Column(
                    children: [
                      SahaButtonFullParent(
                        color: Colors.red,
                        text: "Xoá sự cố này",
                        onPressed: () {
                          SahaDialogApp.showDialogYesNo(
                              mess: "Bạn có chắc muốn xoá sự cố này",
                              onClose: () {},
                              onOK: () async {
                                addProblemOwnerController.deleteProblemOwner();
                              });
                        },
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: 65,
                  child: Column(
                    children: [
                      SahaButtonFullParent(
                        color: Colors.green,
                        text: "Đã giải quyết",
                        onPressed: () {
                          addProblemOwnerController.updateProblemOwner();
                        },
                      ),
                    ],
                  ),
                )),
    );
  }
}
