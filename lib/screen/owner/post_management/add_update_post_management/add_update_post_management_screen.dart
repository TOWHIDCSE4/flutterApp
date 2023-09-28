import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/components/text_field/rice_text_field.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/motel_post.dart';
import 'package:gohomy/model/tower.dart';

import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/owner/motel_room/add_motel_room/add_motel_room_screen.dart';
import 'package:gohomy/screen/owner/motel_room/list_motel_room_controller.dart';
import 'package:gohomy/screen/owner/motel_room/list_motel_room_screen.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/button/saha_button.dart';
import '../../../../components/dialog/dialog.dart';
import '../../../../components/divide/divide.dart';
import '../../../../components/text_field/text_field_no_border.dart';
import '../../../../components/widget/check_customer_login/check_customer_login_screen.dart';
import '../../../../components/widget/image/select_images.dart';
import '../../../../components/widget/video_picker_single/video_picker_single.dart';
import '../../../../const/motel_type.dart';
import '../../../../const/type_image.dart';
import '../../../../model/image_assset.dart';
import '../../../../model/motel_room.dart';
import '../../../../model/service.dart';
import '../../../../utils/string_utils.dart';

import '../../choose_room/choose_room_screen.dart';
import '../../choose_service/choose_service_screen.dart';

import '../list_post_management_screen.dart';
import 'add_update_post_management_controller.dart';
import 'choose_tower_or_room_screen.dart';

class AddUpdatePostManagementLockScreen extends StatelessWidget {
  final MotelPost? motelPostInput;
  final bool? isHome;
  

   AddUpdatePostManagementLockScreen({
    Key? key,
    this.motelPostInput,
    this.isHome,
  });
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(child: ListPostManagementScreen());
  }
}

class AddUpdatePostManagementScreen extends StatefulWidget {
  MotelRoom? motelRoomInput;

  bool? isHome;
  int? id;
  late AddUpdatePostManagementController addUpdatePostManagementController;

  AddUpdatePostManagementScreen({this.isHome, this.id, this.motelRoomInput}) {
    addUpdatePostManagementController = Get.put(
        AddUpdatePostManagementController(
            motelRoomInput: motelRoomInput, isHome: isHome, id: id));
  }
  @override
  State<AddUpdatePostManagementScreen> createState() =>
      _AddUpdatePostManagementScreenState();
}

class _AddUpdatePostManagementScreenState
    extends State<AddUpdatePostManagementScreen> {
  final _formKey = GlobalKey<FormState>();

  DataAppController dataAppController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // begin: Alignment.bottomLeft,
                  // end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
          title: Text(
            widget.id != null ? 'Sửa thông tin' : 'Thêm bài đăng',
          ),
          actions: widget.id == null
              ? null
              : [
                  IconButton(
                      onPressed: () {
                        SahaDialogApp.showDialogYesNo(
                            mess:
                                'Bạn có chắc chắn muốn xoá bài đăng này chứ ?',
                            onOK: () {
                              widget.addUpdatePostManagementController
                                  .deletePostManagement(
                                      postManagementId: widget.id!);
                            });
                      },
                      icon: const Icon(Icons.delete))
                ],
        ),
        bottomNavigationBar: widget.id != null
            ? SizedBox(
                height: 65,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SahaButtonFullParent(
                            color: Theme.of(context).primaryColor,
                            text: 'Chỉnh sửa bài đăng',
                            onPressed: () {
                              // if (_formKey.currentState!.validate()) {
                              //   SahaDialogApp.showDialogYesNo(
                              //       mess:
                              //           "Bạn có chắc muốn cập nhật bài đăng này",
                              //       onClose: () {},
                              //       onOK: () {
                              //         addUpdatePostManagementController
                              //             .updatePostManagement();
                              //       });
                              // }
                              SahaDialogApp.showDialogYesNo(
                                  mess:
                                      "Bạn có chắc muốn cập nhật bài đăng này",
                                  onClose: () {},
                                  onOK: () {
                                    widget.addUpdatePostManagementController
                                        .updatePostManagement();
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => widget.addUpdatePostManagementController
                                  .motelPostRes.value.status ==
                              1
                          ? Expanded(
                              child: Column(
                                children: [
                                  SahaButtonFullParent(
                                    color: Colors.red,
                                    text: 'Hiển thị bài đăng',
                                    onPressed: () {
                                      SahaDialogApp.showDialogYesNo(
                                          mess:
                                              "Bạn có chắc muốn hiện lại bài đăng này",
                                          onClose: () {},
                                          onOK: () {
                                            widget
                                                .addUpdatePostManagementController
                                                .changePostStatus(status: 0);
                                          });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: Column(
                                children: [
                                  SahaButtonFullParent(
                                    color: Colors.red,
                                    text: 'Ẩn bài đăng',
                                    onPressed: () {
                                      SahaDialogApp.showDialogYesNo(
                                          mess:
                                              "Bạn có chắc muốn ẩn bài đăng này",
                                          onClose: () {},
                                          onOK: () {
                                            widget
                                                .addUpdatePostManagementController
                                                .changePostStatus(status: 1);
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ),
                    )
                  ],
                ),
              )
            : SizedBox(
                height: 80,
                child: Column(
                  children: [
                    Obx(
                      () => SahaButtonFullParent(
                          color: widget.addUpdatePostManagementController.isAdd
                                      .value ==
                                  false
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          text: 'Thêm bài đăng',
                          onPressed: widget.addUpdatePostManagementController
                                      .isAdd.value ==
                                  false
                              ? () {
                                  // if (_formKey.currentState!.validate()) {
                                  //   if (widget.id != null) {
                                  //     addUpdatePostManagementController
                                  //         .updatePostManagement();
                                  //   } else {
                                  //     addUpdatePostManagementController
                                  //         .addPostManagement();
                                  //   }
                                  // }
                                  if (widget.id != null) {
                                    widget.addUpdatePostManagementController
                                        .updatePostManagement();
                                  } else {
                                    widget.addUpdatePostManagementController
                                        .addPostManagement();
                                  }
                                }
                              : () {}),
                    ),
                  ],
                ),
              ),
        body: Form(
          key: _formKey,
          child: Obx(
            () => widget.addUpdatePostManagementController.loading.value
                ? SahaLoadingFullScreen()
                : SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (Get.find<DataAppController>()
                                  .badge
                                  .value
                                  .user
                                  ?.isHost ==
                              true)
                            InkWell(
                              onTap: () async {
                                if (widget.id != null &&
                                    dataAppController.currentUser.value.id !=
                                        widget.addUpdatePostManagementController
                                            .motelPostRes.value.userId) {
                                  SahaAlert.showError(
                                      message: 'Bạn không phải chủ phòng');
                                  return;
                                }
                                if(widget.addUpdatePostManagementController.motelPostRes.value.towerId != null) {
                                  Get.to(() => ListMotelRoomScreen(
                                    towerId: widget.addUpdatePostManagementController.motelPostRes.value.towerId
                                  ));
                                }
                                else if(widget.addUpdatePostManagementController.motelPostRes.value.motelId != null) {
                                  var motelRoom = await RepositoryManager.manageRepository.getMotelRoom(motelRoomId: widget.addUpdatePostManagementController.motelPostRes.value.motelId as int);
                                  widget
                                      .addUpdatePostManagementController
                                      .motelChoose
                                      .value = motelRoom!.data!;
                                  widget
                                      .addUpdatePostManagementController
                                      .convertRequestRoomPost();
                                  Get.to(() => AddMotelRoomScreen(
                                    motelRoomInput: motelRoom!.data,
                                    isFromPost: true,
                                  ));
                                }
                                else {
                                  Get.to(() => ChooseTowerOrRoomScreen(
                                    tower: widget
                                        .addUpdatePostManagementController
                                        .towerChoose
                                        .value,
                                    room: widget
                                        .addUpdatePostManagementController
                                        .motelChoose
                                        .value,
                                    onChoose: (v) {
                                      if (v is Tower) {
                                        widget
                                            .addUpdatePostManagementController
                                            .towerChoose
                                            .value = v;
                                        widget
                                            .addUpdatePostManagementController
                                            .motelChoose
                                            .value = MotelRoom();
                                        widget
                                            .addUpdatePostManagementController
                                            .convertTowerRequest();
                                      } else {
                                        widget
                                            .addUpdatePostManagementController
                                            .motelChoose
                                            .value = v[0];
                                        widget
                                            .addUpdatePostManagementController
                                            .towerChoose
                                            .value = Tower();
                                        widget
                                            .addUpdatePostManagementController
                                            .convertRequestRoomPost();
                                      }
                                    },
                                  ));
                                }

                                // Get.to(() => ChooseRoomScreen(
                                //       isFromChooseRoom: true,
                                //       hasPost: false,
                                //       listMotelInput: [
                                //         addUpdatePostManagementController
                                //             .motelChoose.value
                                //       ],
                                //       onChoose: (v) {
                                //         addUpdatePostManagementController
                                //             .motelChoose.value.id = v[0].id;
                                //         addUpdatePostManagementController
                                //             .motelChoose.value = v[0];
                                //         addUpdatePostManagementController
                                //             .convertRequest();
                                //         // addContractController.contractReq.value.
                                //       },
                                //     ));
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
                                      "Chọn toà nhà/phòng *",
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
                                              widget.addUpdatePostManagementController
                                                              .motelChoose.value.id ==
                                                          null &&
                                                      widget
                                                              .addUpdatePostManagementController
                                                              .towerChoose
                                                              .value
                                                              .id ==
                                                          null
                                                  ? 'Chọn toà nhà/phòng'
                                                  : widget
                                                          .addUpdatePostManagementController
                                                          .motelChoose
                                                          .value
                                                          .motelName ??
                                                      widget
                                                          .addUpdatePostManagementController
                                                          .towerChoose
                                                          .value
                                                          .towerName ??
                                                      "",
                                            ),
                                          ),
                                        ),
                                        widget.id != null ? Row(
                                          children: const [
                                            Icon(
                                              Icons.edit,
                                              size: 15,
                                              color: Colors.orange,
                                            ),
                                            Text("Sửa", style: TextStyle(
                                              color: Colors.orange
                                            )),
                                          ],
                                        ) : const Icon(
                                          Icons.arrow_forward_ios_outlined,
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
                            controller: widget.addUpdatePostManagementController
                                .titleTextEditingController,
                            onChanged: (v) {
                              widget.addUpdatePostManagementController
                                  .motelPostRequest.value.title = v;
                              if(v!.length > 50){
                                SahaAlert.showError(message: "Không được vượt quá 50 ký tự");
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Không được để trống';
                              }
                              return null;
                            },
                            labelText: "Tiêu đề bài đăng",
                            hintText: "Nhập tiêu đề bài đăng",
                          ),
                          Get.find<
                                              DataAppController>() //////check là admin tự thêm và chỉnh sửa bài đăng của chính mình thì ẩn đi
                                          .currentUser
                                          .value
                                          .isAdmin ==
                                      true &&
                                  widget.id == null
                              ? const SizedBox()
                              : Get.find<DataAppController>()
                                              .currentUser
                                              .value
                                              .id ==
                                          widget
                                              .addUpdatePostManagementController
                                              .motelPostRes
                                              .value
                                              .userId &&
                                      Get.find<DataAppController>()
                                              .currentUser
                                              .value
                                              .isAdmin ==
                                          true
                                  ? const SizedBox()
                                  :
                                  // Row(
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.end,
                                  //     children: [
                                  //       Expanded(
                                  //         child: SahaTextFieldNoBorder(
                                  //           textInputType:
                                  //               const TextInputType.numberWithOptions(
                                  //                   decimal: true),
                                  //           inputFormatters: [
                                  //             ThousandsFormatter()
                                  //           ],
                                  //           controller:
                                  //               addUpdatePostManagementController
                                  //                   .moneyCommissionAdmin,
                                  //           onChanged: (v) {
                                  //             addUpdatePostManagementController
                                  //                     .motelPostRequest
                                  //                     .value
                                  //                     .moneyCommissionAdmin =
                                  //                 double.tryParse(SahaStringUtils()
                                  //                     .convertFormatText(
                                  //                         addUpdatePostManagementController
                                  //                             .moneyCommissionAdmin
                                  //                             .text));
                                  //           },
                                  //           labelText: "Tiền hoa hồng",
                                  //           hintText: "Nhập tiền hoa hồng",
                                  //         ),
                                  //       ),
                                  //       Container(
                                  //         margin: const EdgeInsets.only(
                                  //             bottom: 15, right: 10),
                                  //         child: const Text(
                                  //           "VNĐ",
                                  //           style: TextStyle(
                                  //               color: Colors.black54,
                                  //               fontWeight: FontWeight.w500,
                                  //               fontSize: 14),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 8, 15, 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Chọn mức hoa hồng :'),
                                          Obx(
                                            () => DropdownButton<String>(
                                              items: dataAppController
                                                          .currentUser
                                                          .value
                                                          .hostRank ==
                                                      2
                                                  ? widget
                                                      .addUpdatePostManagementController
                                                      .listCommissionVip
                                                      .map<DropdownMenuItem<String>>(
                                                          (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList()
                                                  : widget
                                                      .addUpdatePostManagementController
                                                      .listCommission
                                                      .map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                              onChanged: (String? v) {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .percentCommission
                                                    .value = v!;
                                              },
                                              value: widget
                                                  .addUpdatePostManagementController
                                                  .percentCommission
                                                  .value,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                          if (Get.find<DataAppController>()
                                  .currentUser
                                  .value
                                  .isAdmin ==
                              true)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: SahaTextFieldNoBorder(
                                    textInputType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: widget
                                        .addUpdatePostManagementController
                                        .percentCommmissionUser,
                                    onChanged: (v) {
                                      widget
                                              .addUpdatePostManagementController
                                              .motelPostRequest
                                              .value
                                              .percentCommissionCollaborator =
                                          int.parse(v!);
                                      // addUpdatePostManagementController
                                      //         .motelPostRequest
                                      //         .value
                                      //         .moneyCommissionUser =
                                      //     double.tryParse(SahaStringUtils()
                                      //         .convertFormatText(
                                      //             addUpdatePostManagementController
                                      //                 .moneyCommissionUser
                                      //                 .text));
                                    },
                                    labelText: "Phần trăm hoa hồng cho CTV",
                                    hintText: "Nhập % hoa hồng cho CTV",
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 15, right: 10),
                                  child: const Text(
                                    "%",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          SahaDivide(),
                          InkWell(
                            onTap: widget.addUpdatePostManagementController
                                            .motelChoose.value.id ==
                                        null &&
                                    widget.addUpdatePostManagementController
                                            .towerChoose.value.id ==
                                        null
                                ? () {
                                    SahaAlert.showError(
                                        message: 'Bạn hãy chọn phòng trước');
                                  }
                                : null,
                            child: IgnorePointer(
                              ignoring: false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          left: 10,
                                          right: 10,
                                          bottom: 10),
                                      child: Image.asset(
                                        'assets/icon_host/loai-phong.png',
                                        width: Get.width / 3.5,
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15.0, left: 15),
                                      child: Wrap(
                                        children: [
                                          itemTypeRoom(
                                              type: MOTEL, title: "Trọ thường"),
                                          itemTypeRoom(
                                              type: MOTEL_COMPOUND,
                                              title: "Nguyên căn"),
                                          itemTypeRoom(
                                              type: HOME, title: "Chung cư"),
                                          itemTypeRoom(
                                              type: VILLA,
                                              title: "Chung cư mini"),
                                          itemTypeRoom(
                                              type: HOMESTAY,
                                              title: "Homestay"),
                                        ],
                                      )),
                                  Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SelectImages(
                                        maxImage: 10,
                                        type: MO_POST_FILES_FOLDER,
                                        title: 'Ảnh phòng trọ',
                                        subTitle: 'Tối đa 10 hình',
                                        onUpload: () {
                                          widget
                                              .addUpdatePostManagementController
                                              .doneUploadImage
                                              .value = false;
                                        },
                                        images: widget
                                            .addUpdatePostManagementController
                                            .listImages
                                            .toList(),
                                        doneUpload:
                                            (List<ImageData> listImages) {
                                          print(
                                              "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                                          widget
                                              .addUpdatePostManagementController
                                              .listImages(listImages);
                                          if ((listImages.map(
                                                  (e) => e.linkImage ?? "x"))
                                              .toList()
                                              .contains('x')) {
                                            SahaAlert.showError(
                                                message: 'Lỗi ảnh');
                                            return;
                                          }
                                          widget
                                              .addUpdatePostManagementController
                                              .motelPostRequest
                                              .value
                                              .images = (listImages.map(
                                                  (e) => e.linkImage ?? ""))
                                              .toList();

                                          print(widget
                                              .addUpdatePostManagementController
                                              .motelPostRequest
                                              .value
                                              .images);
                                          widget
                                              .addUpdatePostManagementController
                                              .doneUploadImage
                                              .value = true;
                                        },
                                      ),
                                    ),
                                  ),
                                  // if (widget.addUpdatePostManagementController
                                  //         .motelPostRequest.value.towerId !=
                                  //     null)
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Obx(
                                        () => VideoPickerSingle(
                                          
                                          linkVideo: widget
                                              .addUpdatePostManagementController
                                              .motelPostRequest
                                              .value
                                              .linkVideo,
                                             
                                          onChange: (File? file) async {
                                            widget
                                                .addUpdatePostManagementController
                                                .file = file;
                                            if (file == null) {
                                              widget
                                                  .addUpdatePostManagementController
                                                  .motelPostRequest
                                                  .value
                                                  .linkVideo = null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  SahaDivide(),

                                  Obx(() => widget
                                              .addUpdatePostManagementController
                                              .motelPostRequest
                                              .value
                                              .towerId ==
                                          null
                                      ? const SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Số/tên phòng",
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    ...(widget
                                                                .addUpdatePostManagementController
                                                                .motelPostRequest
                                                                .value
                                                                .listMotel ??
                                                            [])
                                                        .map((e) => nameMotel(
                                                            motelRoom: e))
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Tầng",
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    ...(widget
                                                                .addUpdatePostManagementController
                                                                .motelPostRequest
                                                                .value
                                                                .listMotel ??
                                                            [])
                                                        .map((e) =>
                                                            numberFloorMotel(
                                                                motelRoom: e))
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Diện tích(m2)",
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    ...(widget
                                                                .addUpdatePostManagementController
                                                                .motelPostRequest
                                                                .value
                                                                .listMotel ??
                                                            [])
                                                        .map((e) => areaMotel(
                                                            motelRoom: e))
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Giá phòng",
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    ...(widget
                                                                .addUpdatePostManagementController
                                                                .motelPostRequest
                                                                .value
                                                                .listMotel ??
                                                            [])
                                                        .map((e) => priceMotel(
                                                            motelRoom: e))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // SahaTextFieldNoBorder(
                                  //   readOnly: true,
                                  //   withAsterisk: true,
                                  //   textInputType: TextInputType.text,
                                  //   controller:
                                  //       addUpdatePostManagementController
                                  //           .roomNumberTextEditingController,
                                  //   onChanged: (v) {
                                  //     addUpdatePostManagementController
                                  //         .motelPostRequest.value.motelName = v;
                                  //   },
                                  //   validator: (value) {
                                  //     if (value!.isEmpty) {
                                  //       return 'Không được để trống';
                                  //     }
                                  //     return null;
                                  //   },
                                  //   labelText: "Số/Tên phòng",
                                  //   hintText: "Nhập tên phòng",
                                  // ),
                                  // SahaDivide(),
                                  InkWell(
                                    onTap: () {
                                      // SahaDialogApp.showDialogAddressChoose(
                                      //   hideAll: true,
                                      //   accept: () {},
                                      //   callback: (v) {
                                      //     addUpdatePostManagementController
                                      //         .locationProvince.value = v;
                                      //     Get.back();
                                      //     SahaDialogApp.showDialogAddressChoose(
                                      //       hideAll: true,
                                      //       accept: () {},
                                      //       idProvince:
                                      //           addUpdatePostManagementController
                                      //               .locationProvince.value.id,
                                      //       callback: (v) {
                                      //         addUpdatePostManagementController
                                      //             .locationDistrict.value = v;
                                      //         Get.back();
                                      //         SahaDialogApp
                                      //             .showDialogAddressChoose(
                                      //           hideAll: true,
                                      //           accept: () {},
                                      //           idDistrict:
                                      //               addUpdatePostManagementController
                                      //                   .locationDistrict
                                      //                   .value
                                      //                   .id,
                                      //           callback: (v) {
                                      //             addUpdatePostManagementController
                                      //                 .locationWard.value = v;
                                      //             Get.back();
                                      //             SahaDialogApp
                                      //                 .showDialogInputNote(
                                      //                     height: 50,
                                      //                     confirm: (v) {
                                      //                       if (v == null ||
                                      //                           v == "") {
                                      //                         SahaAlert
                                      //                             .showToastMiddle(
                                      //                                 message:
                                      //                                     "Vui lòng nhập địa chỉ chi tiết");
                                      //                       } else {
                                      //                         var province =
                                      //                             addUpdatePostManagementController
                                      //                                 .locationProvince;
                                      //                         addUpdatePostManagementController
                                      //                                 .motelPostRequest
                                      //                                 .value
                                      //                                 .province =
                                      //                             province
                                      //                                 .value.id;
                                      //                         var district =
                                      //                             addUpdatePostManagementController
                                      //                                 .locationDistrict;
                                      //                         addUpdatePostManagementController
                                      //                                 .motelPostRequest
                                      //                                 .value
                                      //                                 .district =
                                      //                             district
                                      //                                 .value.id;
                                      //                         var ward =
                                      //                             addUpdatePostManagementController
                                      //                                 .locationWard;
                                      //                         addUpdatePostManagementController
                                      //                                 .motelPostRequest
                                      //                                 .value
                                      //                                 .wards =
                                      //                             ward.value.id;
                                      //                         addUpdatePostManagementController
                                      //                             .motelPostRequest
                                      //                             .value
                                      //                             .addressDetail = v;

                                      //                         addUpdatePostManagementController
                                      //                             .motelPostRequest
                                      //                             .refresh();
                                      //                         addUpdatePostManagementController
                                      //                                 .addressTextEditingController
                                      //                                 .text =
                                      //                             "${addUpdatePostManagementController.motelPostRequest.value.addressDetail} - ${ward.value.name} - ${district.value.name} - ${province.value.name}";
                                      //                       }
                                      //                     },
                                      //                     title:
                                      //                         "Địa chỉ chi tiết",
                                      //                     textInput: addUpdatePostManagementController
                                      //                             .motelPostRequest
                                      //                             .value
                                      //                             .addressDetail ??
                                      //                         "");
                                      //           },
                                      //         );
                                      //       },
                                      //     );
                                      //   },
                                      // );
                                    },
                                    child: SahaTextFieldNoBorder(
                                      enabled: false,
                                      labelText: "Địa chỉ",
                                      textInputType: TextInputType.text,
                                      controller: widget
                                          .addUpdatePostManagementController
                                          .addressTextEditingController,
                                      withAsterisk: true,
                                      onChanged: (v) {
                                        //addPostController.postReq.value.name = v;
                                      },
                                      hintText: "Chọn địa chỉ",
                                    ),
                                  ),
                                  SahaDivide(),
                                  SahaTextFieldNoBorder(
                                  
                                    withAsterisk: false,
                                    controller: widget
                                        .addUpdatePostManagementController
                                        .descriptionTextEditingController,
                                    onChanged: (v) {
                                      widget
                                          .addUpdatePostManagementController
                                          .motelPostRequest
                                          .value
                                          .description = v;
                                    },
                                    textInputType: TextInputType.multiline,
                                    labelText: "Mô tả",
                                    hintText: "Nhập mô tả",
                                    //maxLine: 2,
                                  ),
                                  SahaDivide(),
                                    if (widget.addUpdatePostManagementController
                                          .motelPostRequest.value.motelId !=
                                      null)
                                  Column(
                                    children: [
                                      SahaTextFieldNoBorder(
                                        withAsterisk: true,
                                        textInputType:
                                            const TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9.,]+')),
                                        ],
                                        controller: widget
                                            .addUpdatePostManagementController
                                            .capacityTextEditingController,
                                        onChanged: (v) {
                                          widget
                                              .addUpdatePostManagementController
                                              .motelPostRequest
                                              .value
                                              .capacity = int.parse(v!);
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Không được để trống';
                                          }
                                          return null;
                                        },
                                        labelText: "Sức chứa (Người/Phòng)",
                                        hintText: "Nhập số Người/Phòng",
                                      ),
                                       SahaDivide(),
                                    ],
                                  ),
                                 
                                  if (widget.addUpdatePostManagementController
                                          .motelPostRequest.value.motelId !=
                                      null)
                                    Column(
                                      children: [
                                        SahaTextFieldNoBorder(
                                          readOnly: true,
                                          withAsterisk: true,
                                          textInputType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9.,]+')),
                                          ],
                                          controller: widget
                                              .addUpdatePostManagementController
                                              .areaTextEditingController,
                                          onChanged: (v) {
                                            widget
                                                .addUpdatePostManagementController
                                                .motelPostRequest
                                                .value
                                                .area = int.parse(v!);
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Không được để trống';
                                            }
                                            return null;
                                          },
                                          labelText: "Diện tích (m²)",
                                          hintText: "Nhập diện tích",
                                        ),
                                        SahaDivide(),
                                      ],
                                    ),

                                  SahaTextFieldNoBorder(
                                    readOnly: true,
                                    textInputType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: widget
                                        .addUpdatePostManagementController
                                        .quantityVehicleParked,
                                    onChanged: (v) {
                                      widget
                                              .addUpdatePostManagementController
                                              .motelPostRequest
                                              .value
                                              .quantityVehicleParked =
                                          int.parse(v!);
                                    },
                                    labelText: "Số chỗ để xe",
                                    hintText: "Nhập sô chỗ để xe",
                                  ),
                                  SahaDivide(),
                                  if (widget.addUpdatePostManagementController
                                          .motelPostRequest.value.motelId !=
                                      null)
                                    Column(
                                      children: [
                                        SahaTextFieldNoBorder(
                                          readOnly: true,
                                          withAsterisk: true,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textInputType: TextInputType.number,
                                          controller: widget
                                              .addUpdatePostManagementController
                                              .numberFloor,
                                          onChanged: (v) {
                                            widget
                                                .addUpdatePostManagementController
                                                .motelPostRequest
                                                .value
                                                .numberFloor = int.parse(v!);
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Không được để trống';
                                            }
                                            return null;
                                          },
                                          labelText: "Tầng",
                                          hintText: "Nhập số tầng",
                                        ),
                                        SahaDivide(),
                                      ],
                                    ),
                                  SahaDivide(),

                                  Column(
                                    children: [
                                      SahaTextFieldNoBorder(
                                        readOnly: true,
                                        withAsterisk: true,
                                        textInputType: TextInputType.phone,
                                        controller: widget
                                            .addUpdatePostManagementController
                                            .phoneNumberTextEditingController,
                                        onChanged: (v) {
                                          widget
                                              .addUpdatePostManagementController
                                              .motelPostRequest
                                              .value
                                              .phoneNumber = v;
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Không được để trống';
                                          }
                                          return null;
                                        },
                                        labelText: "Số điện thoại",
                                        hintText: "Nhập số điện thoại",
                                      ),
                                      SahaDivide(),
                                    ],
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(
                                      16,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        // SahaDialogApp.showDialogSex(
                                        //   onChoose: (sex) {
                                        //     addUpdatePostManagementController
                                        //         .motelPostRequest
                                        //         .value
                                        //         .sex = sex;
                                        //     addUpdatePostManagementController
                                        //         .motelPostRequest
                                        //         .refresh();
                                        //   },
                                        //   sex: addUpdatePostManagementController
                                        //           .motelPostRequest.value.sex ??
                                        //       0,
                                        // );
                                      },
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Giới tính: ",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Expanded(
                                            child: Obx(
                                              () => Text(
                                                widget
                                                            .addUpdatePostManagementController
                                                            .motelPostRequest
                                                            .value
                                                            .sex ==
                                                        0
                                                    ? "Nam, nữ"
                                                    : widget
                                                                .addUpdatePostManagementController
                                                                .motelPostRequest
                                                                .value
                                                                .sex ==
                                                            1
                                                        ? "Nam"
                                                        : widget
                                                                    .addUpdatePostManagementController
                                                                    .motelPostRequest
                                                                    .value
                                                                    .sex ==
                                                                2
                                                            ? "Nữ"
                                                            : "Nam, nữ",
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                              Icons.keyboard_arrow_down_rounded)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SahaDivide(),

                                  // Container(
                                  //   padding: EdgeInsets.all(10),
                                  //   child: Text(
                                  //     "Các loại khoản tiền",
                                  //     style: TextStyle(
                                  //       fontSize: 16,
                                  //       fontWeight: FontWeight.w700,
                                  //       color: Theme.of(context).primaryColor,
                                  //     ),
                                  //   ),
                                  // ),

                                  if (widget.addUpdatePostManagementController
                                          .motelPostRequest.value.motelId !=
                                      null)
                                    Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: SahaTextFieldNoBorder(
                                                readOnly: true,
                                                withAsterisk: true,
                                                textInputType:
                                                    const TextInputType
                                                            .numberWithOptions(
                                                        decimal: true),
                                                inputFormatters: [
                                                  ThousandsFormatter()
                                                ],
                                                controller: widget
                                                    .addUpdatePostManagementController
                                                    .moneyTextEditingController,
                                                onChanged: (v) {
                                                  widget
                                                          .addUpdatePostManagementController
                                                          .motelPostRequest
                                                          .value
                                                          .money =
                                                      double.tryParse(SahaStringUtils()
                                                          .convertFormatText(widget
                                                              .addUpdatePostManagementController
                                                              .moneyTextEditingController
                                                              .text));
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Không được để trống';
                                                  }
                                                  return null;
                                                },
                                                labelText: "Giá phòng",
                                                hintText: "Nhập giá phòng",
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 15, right: 10),
                                              child: const Text(
                                                "VNĐ",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SahaDivide(),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: SahaTextFieldNoBorder(
                                                readOnly: true,
                                                withAsterisk: true,
                                                textInputType:
                                                    const TextInputType
                                                            .numberWithOptions(
                                                        decimal: true),
                                                inputFormatters: [
                                                  ThousandsFormatter()
                                                ],
                                                controller: widget
                                                    .addUpdatePostManagementController
                                                    .depositTextEditingController,
                                                onChanged: (v) {
                                                  widget
                                                          .addUpdatePostManagementController
                                                          .motelPostRequest
                                                          .value
                                                          .deposit =
                                                      double.tryParse(SahaStringUtils()
                                                          .convertFormatText(widget
                                                              .addUpdatePostManagementController
                                                              .depositTextEditingController
                                                              .text));
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Không được để trống';
                                                  }
                                                  return null;
                                                },
                                                labelText: "Tiền đặt cọc",
                                                hintText: "Nhập tiền đặt cọc",
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 15, right: 10),
                                              child: const Text(
                                                "VNĐ",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                  SahaDivide(),

                                  SahaDivide(),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/icon_host/phi-dich-vu.png',
                                          width: Get.width / 3.5,
                                        ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     Get.to(() => ChooseServiceScreen(
                                        //         listServiceInput:
                                        //             (addUpdatePostManagementController
                                        //                         .motelPostRequest
                                        //                         .value
                                        //                         .moServicesReq ??
                                        //                     [])
                                        //                 .toList(),
                                        //         onChoose: (List<Service> v) {
                                        //           addUpdatePostManagementController
                                        //               .motelPostRequest
                                        //               .value
                                        //               .moServicesReq = [];
                                        //           (addUpdatePostManagementController
                                        //                       .motelPostRequest
                                        //                       .value
                                        //                       .moServicesReq ??
                                        //                   [])
                                        //               .addAll(v);
                                        //           addUpdatePostManagementController
                                        //               .motelPostRequest
                                        //               .refresh();
                                        //         }));
                                        //   },
                                        //   child: Container(
                                        //     child: const Center(
                                        //         child: Icon(Icons.add)),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => (widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .moServicesReq ??
                                                [])
                                            .isEmpty
                                        ? const SizedBox()
                                        : Center(
                                            child: Column(
                                              children: [
                                                Wrap(
                                                  spacing: 10,
                                                  runSpacing: 10,
                                                  children: [
                                                    ...(widget
                                                                .addUpdatePostManagementController
                                                                .motelPostRequest
                                                                .value
                                                                .moServicesReq ??
                                                            [])
                                                        .map((e) {
                                                      return itemService(
                                                          value: (widget
                                                                      .addUpdatePostManagementController
                                                                      .motelPostRequest
                                                                      .value
                                                                      .moServicesReq ??
                                                                  [])
                                                              .map((e) =>
                                                                  e.serviceName)
                                                              .contains(e
                                                                  .serviceName),
                                                          service: e,
                                                          onCheck: () {});
                                                    }).toList()
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      'assets/icon_host/tien-nghi.png',
                                      width: Get.width / 4,
                                    ),
                                  ),
                                  Container(
                                    width: Get.width,
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10, bottom: 10),
                                    child: Obx(
                                      () => Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        children: [
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasWc ??
                                                  false,
                                              tile: "Vệ sinh khép kín",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasWc = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasWc ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasMezzanine ??
                                                  false,
                                              tile: "Gác xép",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasMezzanine = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasMezzanine ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasBalcony ??
                                                  false,
                                              tile: "Ban công",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasBalcony = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasBalcony ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasFingerprint ??
                                                  false,
                                              tile: "Ra vào vân tay",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasFingerprint = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasFingerprint ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasOwnOwner ??
                                                  false,
                                              tile: "Không chung chủ",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasOwnOwner = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasOwnOwner ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasPet ??
                                                  false,
                                              tile: "Nuôi pet",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasPet = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasPet ??
                                                    false);
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SahaDivide(),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      'assets/icon_host/noi-that.png',
                                      width: Get.width / 4,
                                    ),
                                  ),
                                  Container(
                                    width: Get.width,
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10, bottom: 10),
                                    child: Obx(
                                      () => Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        children: [
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasAirConditioner ??
                                                  false,
                                              tile: "Điều hoà",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasAirConditioner = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasAirConditioner ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasWaterHeater ??
                                                  false,
                                              tile: "Bình nóng lạnh",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasWaterHeater = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasWaterHeater ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasKitchen ??
                                                  false,
                                              tile: "Kệ bếp",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasKitchen = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasKitchen ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasFridge ??
                                                  false,
                                              tile: "Tủ lạnh",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasFridge = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasFridge ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasBed ??
                                                  false,
                                              tile: "Giường ngủ",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasBed = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasBed ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasWashingMachine ??
                                                  false,
                                              tile: "Máy giặt",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasWashingMachine = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasWashingMachine ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasKitchenStuff ??
                                                  false,
                                              tile: "Đồ dùng bếp",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasKitchenStuff = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasKitchenStuff ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasTable ??
                                                  false,
                                              tile: "Bàn ghế",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasTable = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasTable ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasDecorativeLights ??
                                                  false,
                                              tile: "Đèn trang trí",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasDecorativeLights = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasDecorativeLights ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasPicture ??
                                                  false,
                                              tile: "Tranh trang trí",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasPicture = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasPicture ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasTree ??
                                                  false,
                                              tile: "Cây cối trang trí",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasTree = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasTree ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasPillow ??
                                                  false,
                                              tile: "Chăn,ga gối",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasPillow = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasPillow ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasWardrobe ??
                                                  false,
                                              tile: "Tủ quần áo",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasWardrobe = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasWardrobe ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasMattress ??
                                                  false,
                                              tile: "Nệm",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasMattress = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasMattress ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasShoesRacks ??
                                                  false,
                                              tile: "Kệ giày dép",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasShoesRacks = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasShoesRacks ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasCurtain ??
                                                  false,
                                              tile: "Rèm",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasCurtain = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasCurtain ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasCeilingFans ??
                                                  false,
                                              tile: "Quạt tràn",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasCeilingFans = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasCeilingFans ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasMirror ??
                                                  false,
                                              tile: "Gương toàn thân",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasMirror = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasMirror ??
                                                    false);
                                              }),
                                          itemUtilities(
                                              value: widget
                                                      .addUpdatePostManagementController
                                                      .motelPostRequest
                                                      .value
                                                      .hasSofa ??
                                                  false,
                                              tile: "Sofa",
                                              onCheck: () {
                                                widget
                                                    .addUpdatePostManagementController
                                                    .motelPostRequest
                                                    .value
                                                    .hasSofa = !(widget
                                                        .addUpdatePostManagementController
                                                        .motelPostRequest
                                                        .value
                                                        .hasSofa ??
                                                    false);
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget itemService(
      {required bool value,
      required Function onCheck,
      required Service service}) {
    return GestureDetector(
      onTap: () {
        onCheck();
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: (Get.width - 40) / 3,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: value
                      ? Theme.of(Get.context!).primaryColor
                      : Colors.grey[200]!),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  service.serviceIcon != null && service.serviceIcon!.isNotEmpty
                      ? service.serviceIcon ?? ""
                      : "",
                  width: 25,
                  height: 25,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    service.serviceName ?? "",
                  ),
                ),
                Text(
                  "${SahaStringUtils().convertToMoney(service.serviceCharge ?? "")}đ/${service.serviceUnit ?? ""}",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          // Positioned(
          //   right: -5,
          //   top: -5,
          //   child: InkWell(
          //     onTap: () {
          //       addUpdatePostManagementController
          //           .motelPostRequest.value.moServicesReq!
          //           .remove(service);
          //       addUpdatePostManagementController.motelPostRequest.refresh();
          //     },
          //     child: Container(
          //       padding: const EdgeInsets.all(3),
          //       decoration: const BoxDecoration(
          //         color: Colors.red,
          //         shape: BoxShape.circle,
          //       ),
          //       child: const Icon(
          //         Icons.clear_rounded,
          //         color: Colors.white,
          //         size: 15,
          //       ),
          //     ),
          //   ),
          // ),
          // Positioned(
          //     top: -5,
          //     left: -5,
          //     child: IconButton(
          //         onPressed: () {
          //           SahaDialogApp.showDialogInput(
          //             isNumber: true,
          //             textInput:
          //                 removeDecimalZeroFormat(service.serviceCharge!),
          //             onInput: (v) {
          //               service.serviceCharge = double.parse(
          //                   SahaStringUtils().convertFormatText(v));
          //               var index = addUpdatePostManagementController
          //                   .motelPostRequest.value.moServicesReq
          //                   ?.indexWhere((element) => element == service);
          //               addUpdatePostManagementController.motelPostRequest.value
          //                       .moServicesReq![index!].serviceCharge =
          //                   double.parse(
          //                       SahaStringUtils().convertFormatText(v));
          //               addUpdatePostManagementController.motelPostRequest
          //                   .refresh();
          //             },
          //             title: 'Sửa giá',
          //           );
          //         },
          //         icon: Icon(
          //           Icons.edit,
          //           color: Colors.grey[600],
          //         )))
        ],
      ),
    );
  }

  Widget itemUtilities(
      {required bool value, required String tile, required Function onCheck}) {
    return InkWell(
      onTap: () {
        // onCheck();
        // addUpdatePostManagementController.motelPostRequest.refresh();
      },
      child: Stack(
        children: [
          Container(
            width: (Get.width - 40) / 2,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: value
                        ? Theme.of(Get.context!).primaryColor
                        : Colors.grey[200]!)),
            child: Center(
              child: Text(
                tile,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: value ? Theme.of(Get.context!).primaryColor : null),
              ),
            ),
          ),
          if (value == false)
            Positioned.fill(
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200]!.withOpacity(0.5),
                ),
              ),
            ),
          if (value == true)
            Positioned(
              left: -25,
              top: -20,
              child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Theme.of(Get.context!).primaryColor,
                  ),
                  transform: Matrix4.rotationZ(-0.5),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: const <Widget>[
                      Positioned(
                          bottom: -0,
                          right: 20,
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation(20 / 360),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 13,
                            ),
                          ))
                    ],
                  )),
            )
        ],
      ),
    );
  }

  String? textTime(int hour, int minute) {
    return "${hour < 10 ? "0$hour" : hour}:${minute < 10 ? "0$minute" : minute}";
  }

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  Widget nameMotel({required MotelRoom motelRoom}) {
    return Column(
      children: [
        Text(motelRoom.motelName ?? ''),
        const SizedBox(
          height: 2,
        ),
        SahaDivide()
      ],
    );
  }

  Widget numberFloorMotel({required MotelRoom motelRoom}) {
    return Column(
      children: [
        Text("${motelRoom.numberFloor ?? ""}"),
        const SizedBox(
          height: 2,
        ),
        SahaDivide()
      ],
    );
  }

  Widget areaMotel({required MotelRoom motelRoom}) {
    return Column(
      children: [
        Text("${motelRoom.area ?? ""}"),
        const SizedBox(
          height: 2,
        ),
        SahaDivide()
      ],
    );
  }

  Widget priceMotel({required MotelRoom motelRoom}) {
    return Column(
      children: [
        Text("${SahaStringUtils().convertToUnit(motelRoom.money)} VNĐ"),
        const SizedBox(
          height: 2,
        ),
        SahaDivide()
      ],
    );
  }

  Widget itemTypeRoom({required int type, required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          widget.addUpdatePostManagementController.motelPostRequest.value.type =
              type;
          widget.addUpdatePostManagementController.motelPostRequest.refresh();
        },
        child: Stack(
          children: [
            Container(
                width: Get.width / 3 - 26,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.addUpdatePostManagementController
                                  .motelPostRequest.value.type ==
                              type
                          ? Theme.of(Get.context!).primaryColor
                          : Colors.grey[200]!),
                  color: widget.addUpdatePostManagementController
                              .motelPostRequest.value.type ==
                          type
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: widget.addUpdatePostManagementController
                              .motelPostRequest.value.type ==
                          type
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                ),
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: widget.addUpdatePostManagementController
                                    .motelPostRequest.value.type ==
                                type
                            ? Theme.of(Get.context!).primaryColor
                            : null),
                  ),
                )),
            if (widget.addUpdatePostManagementController.motelPostRequest.value
                    .type ==
                type)
              Positioned(
                left: -25,
                top: -20,
                child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(Get.context!).primaryColor,
                    ),
                    transform: Matrix4.rotationZ(-0.5),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: const <Widget>[
                        Positioned(
                            bottom: -0,
                            right: 20,
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation(20 / 360),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 13,
                              ),
                            ))
                      ],
                    )),
              )
          ],
        ),
      ),
    );
  }
}
