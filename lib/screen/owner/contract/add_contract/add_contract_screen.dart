import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/components/text_field/rice_text_field.dart';

import 'package:gohomy/model/motel_room.dart';
import 'package:gohomy/model/renter.dart';
import 'package:gohomy/screen/data_app_controller.dart';

import 'package:gohomy/utils/date_utils.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/button/saha_button.dart';
import '../../../../components/dialog/dialog.dart';
import '../../../../components/divide/divide.dart';
import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../components/text_field/info_input_text_field.dart';
import '../../../../components/text_field/text_field_no_border.dart';
import '../../../../components/widget/image/select_images.dart';
import '../../../../components/widget/image/show_image.dart';
import '../../../../components/widget/image_picker_single/image_picker_single.dart';
import '../../../../const/type_image.dart';
import '../../../../model/furniture.dart';
import '../../../../model/image_assset.dart';
import '../../../../model/service.dart';
import '../../../../model/tower.dart';
import '../../../../utils/string_utils.dart';
import '../../../admin/potential_user/add_renter/add_renter_screen.dart';
import '../../../profile/bill/widget/dialog_add_service.dart';
import '../../choose_renters/choose_renters_screen.dart';
import '../../choose_room/choose_room_screen.dart';
import '../../choose_service/choose_service_screen.dart';
import '../../motel_room/choose_tower/choose_tower_screen.dart';
import '../../renters/add_update_tenants/add_renter_screen.dart';
import '../../renters/renter_details/renter_detail_screen.dart';
import 'add_contract_controller.dart';
import 'add_renter_sidekick.dart';

class AddContractScreen extends StatelessWidget {
  late AddContractController addContractController;
  final _formKey = GlobalKey<FormState>();
  MotelRoom? motelRoomInput;
  bool? ignoring;
  bool? isUser;
  int? contractId;
  DataAppController dataAppController = Get.find();
  Renter? renterInput;
  Tower? tower;

  AddContractScreen({super.key,
    this.ignoring,
    this.isUser,
    this.contractId,
    this.motelRoomInput,
    this.renterInput,
    this.tower,
  }) {
    addContractController = AddContractController(
      ignoring: ignoring,
      isUser: isUser,
      contractId: contractId,
      motelRoomInput: motelRoomInput,
      renterInput: renterInput,
      tower: tower,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
          title: const Text('Hợp đồng'),
          actions: contractId == null
              ? null
              : [
            IconButton(
                onPressed: () {
                  SahaDialogApp.showDialogYesNo(
                      mess: 'Bạn có chắc chắn muốn xoá hợp đồng này chứ',
                      onOK: () {
                        addContractController.deleteContract(
                            contractId: contractId!);
                      });
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: Form(
          key: _formKey,
          child: Obx(
                () =>
            addContractController.isLoading.value
                ? SahaLoadingFullScreen()
                : addContractController.contractRes.value.id == null &&
                contractId != null
                ? const Center(
              child: Text('Hợp đồng không tồn tại'),
            )
                : SingleChildScrollView(
              keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,
              child: IgnorePointer(
                ignoring: contractId == null
                    ? false
                    : addContractController.ignoring == null
                    ? false
                    : addContractController.ignoring!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/icon_contract/thong-tin.png',
                          width: Get.width / 4,
                        )),
                    if (contractId != null)
                      Padding(
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
                            Text(
                              'Chủ nhà',
                              style: TextStyle(
                                  color: Colors.black54,
                                  backgroundColor: Theme
                                      .of(context)
                                      .scaffoldBackgroundColor,
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
                                        () =>
                                        Text(
                                          addContractController
                                              .contractRes
                                              .value
                                              .host
                                              ?.name ??
                                              '',
                                          style: TextStyle(
                                            color: addContractController
                                                .listRenterChoose
                                                .map((e) =>
                                            e.isRepresent)
                                                .contains(true) ==
                                                true
                                                ? null
                                                : Colors.grey,
                                          ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider()
                          ],
                        ),
                      ),
                    InkWell(
                      onTap: () {
                        var index = addContractController
                            .listRenterChoose
                            .indexWhere((e) => e.isRepresent == true);

                        // Get.to(() => AddRenterScreen(
                        //       renterInput: index != -1
                        //           ? addContractController
                        //               .listRenterChoose[index]
                        //           : null,
                        //       onSubmit: (Renter renter) {
                        //         if (index == -1) {
                        //           addContractController
                        //               .representative.value = renter;
                        //           addContractController.representative
                        //               .value.isRepresent = true;
                        //           addContractController
                        //               .listRenterChoose
                        //               .add(addContractController
                        //                   .representative.value);
                        //         } else {
                        //           addContractController
                        //                   .listRenterChoose[index] =
                        //               renter;
                        //         }
                        //       },
                        //     ));
                        Get.to(() =>
                            ChooseRenterScreen(
                              only: true,
                              listRenterInput: addContractController
                                  .listRenterChoose
                                  .where((e) => e.isRepresent == true)
                                  .toList(),
                              onChoose: (List<Renter> v) {
                                var value = v[0];
                                value.isRepresent = true;
                                addContractController
                                    .convertInfoFromRenter(v[0]);
                                var index = addContractController
                                    .listRenterChoose
                                    .indexWhere(
                                        (e) => e.id == value.id);
                                print(index);
                                if (index != -1) {
                                  addContractController
                                      .listRenterChoose
                                      .forEach((e) {
                                    e.isRepresent = false;
                                  });
                                  addContractController
                                      .listRenterChoose[index] =
                                      value;
                                  addContractController
                                      .listRenterChoose[index]
                                      .isRepresent = true;
                                  addContractController
                                      .listRenterChoose
                                      .refresh();
                                } else {
                                  if (addContractController
                                      .listRenterChoose.isNotEmpty) {
                                    addContractController
                                        .listRenterChoose
                                        .removeWhere((e) =>
                                    e.isRepresent == true);
                                  }

                                  addContractController
                                      .listRenterChoose
                                      .add(value);
                                }
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
                            Text(
                              ignoring == true
                                  ? "Đại diện bên thuê"
                                  : "Chọn đại diện bên thuê *",
                              style: TextStyle(
                                  color: Colors.black54,
                                  backgroundColor: Theme
                                      .of(context)
                                      .scaffoldBackgroundColor,
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
                                        () =>
                                        Text(
                                          addContractController
                                              .listRenterChoose
                                              .map((e) =>
                                          e.isRepresent)
                                              .contains(true) ==
                                              true
                                              ? addContractController
                                              .listRenterChoose
                                              .where((e) =>
                                          e.isRepresent ==
                                              true)
                                              .toList()[0]
                                              .name ??
                                              ""
                                              : 'Thêm đại diện bên thuê',
                                          // addContractController
                                          //         .representative
                                          //         .value
                                          //         .name ??
                                          //     'chọn đại diện',`
                                          style: TextStyle(
                                            color: addContractController
                                                .listRenterChoose
                                                .map((e) =>
                                            e.isRepresent)
                                                .contains(true) ==
                                                true
                                                ? null
                                                : Colors.grey,
                                            // addContractController
                                            //             .representative
                                            //             .value
                                            //             .name ==
                                            //         null
                                            //     ? Colors.grey
                                            //     : null
                                          ),
                                        ),
                                  ),
                                ),
                                if (ignoring == false)
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

                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Số chứng minh nhân dân',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          RiceTextField(
                            controller: addContractController.cmnd,
                            onChanged: (v) {
                              addContractController
                                  .contractReq.value.cmndNumber = v;
                            },
                            hintText: "Nhập số CMND/CCCD",
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text('CMND mặt trước'),
                                  Obx(
                                        () =>
                                        ImagePickerSingle(
                                          type: RENTER_FILES_FOLDER,
                                          width: Get.width / 3,
                                          height: Get.width / 4,
                                          linkLogo: addContractController
                                              .contractReq
                                              .value
                                              .cmndFrontImageUrl,
                                          onChange: (link) {
                                            print(link);
                                            addContractController
                                                .contractReq
                                                .value
                                                .cmndFrontImageUrl = link;
                                          },
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'CMND mặt sau',
                                    style: TextStyle(),
                                  ),
                                  Obx(
                                        () =>
                                        ImagePickerSingle(
                                          type: RENTER_FILES_FOLDER,
                                          width: Get.width / 3,
                                          height: Get.width / 4,
                                          linkLogo: addContractController
                                              .contractReq
                                              .value
                                              .cmndBackImageUrl,
                                          onChange: (link) {
                                            print(link);
                                            addContractController
                                                .contractReq
                                                .value
                                                .cmndBackImageUrl = link;
                                          },
                                        ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Obx(
                    //   () => addContractController.listRenterChoose
                    //               .map((e) => e.isRepresent)
                    //               .contains(true) ==
                    //           true
                    //       ? Container(
                    //           margin: const EdgeInsets.all(10),
                    //           decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius:
                    //                 BorderRadius.circular(10),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color:
                    //                     Colors.grey.withOpacity(0.5),
                    //                 spreadRadius: 1,
                    //                 blurRadius: 1,
                    //                 offset: const Offset(0, 3),
                    //               ),
                    //             ],
                    //           ),
                    //           padding: const EdgeInsets.all(10),
                    //           child: Column(
                    //             crossAxisAlignment:
                    //                 CrossAxisAlignment.start,
                    //             children: [
                    //               const Text(
                    //                 'Số chứng minh nhân dân',
                    //                 style: TextStyle(
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.w400,
                    //                 ),
                    //               ),

                    //               Text(addContractController
                    //                       .listRenterChoose
                    //                       .where((e) =>
                    //                           e.isRepresent == true)
                    //                       .toList()[0]
                    //                       .cmndNumber ??
                    //                   ""),
                    //               Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceAround,
                    //                 children: [
                    //                   Column(
                    //                     children: [
                    //                       const Text(
                    //                           'CMND mặt trước'),
                    //                       images(addContractController
                    //                               .listRenterChoose
                    //                               .where((e) =>
                    //                                   e.isRepresent ==
                    //                                   true)
                    //                               .toList()[0]
                    //                               .cmndFrontImageUrl ??
                    //                           ""),
                    //                     ],
                    //                   ),
                    //                   Column(
                    //                     children: [
                    //                       const Text(
                    //                         'CMND mặt sau',
                    //                         style: TextStyle(),
                    //                       ),
                    //                       images(addContractController
                    //                               .listRenterChoose
                    //                               .where((e) =>
                    //                                   e.isRepresent ==
                    //                                   true)
                    //                               .toList()[0]
                    //                               .cmndBackImageUrl ??
                    //                           ""),
                    //                     ],
                    //                   )
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         )
                    //       : const SizedBox(),
                    // ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Obx(
                            () =>
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/icon_contract/nguoi-thue.png',
                                      width: Get.width / 4,
                                    ),
                                    if (ignoring != true)
                                      IconButton(
                                          onPressed: () {
                                            // Get.to(
                                            //     () => ChooseRenterScreen(
                                            //           listRenterInput:
                                            //               addContractController
                                            //                   .listRenterChoose,
                                            //           onChoose: (v) {
                                            //             if (v.length ==
                                            //                 1) {
                                            //               var value =
                                            //                   v[0];
                                            //               value.isRepresent =
                                            //                   true;
                                            //               addContractController
                                            //                   .listRenterChoose(
                                            //                       [value]);
                                            //             } else {
                                            //               addContractController
                                            //                   .listRenterChoose = v;
                                            //               print(addContractController
                                            //                   .listRenterChoose
                                            //                   .map((e) =>
                                            //                       e.isRepresent));
                                            //             }
                                            //           },
                                            //         ));
                                            // Get.to(() =>
                                            //         AddRenterPotentialScreen(
                                            //           onSubmit: (Renter
                                            //               renter) {
                                            //             addContractController
                                            //                 .listRenterChoose
                                            //                 .add(renter);
                                            //           },
                                            //         ))!
                                            //     .then((value) =>
                                            //         addContractController
                                            //             .listRenterChoose
                                            //             .refresh());

                                            Get.to(() =>
                                                AddRenterScreen(
                                                  onSubmit: (Renter
                                                  renter) {
                                                    addContractController
                                                        .listRenterChoose
                                                        .add(renter);
                                                  },
                                                ))!
                                                .then((value) =>
                                                addContractController
                                                    .listRenterChoose
                                                    .refresh());
                                          },
                                          icon: const Icon(Icons.add))
                                  ],
                                ),
                                ...addContractController.listRenterChoose
                                    .map((v) {
                                  return itemRenter(
                                    renter: v,
                                    index: addContractController
                                        .listRenterChoose
                                        .indexOf(v),
                                  );
                                }).toList(),
                              ],
                            ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (motelRoomInput!.towerName == null) {
                          Get.to(() =>
                              ChooseTowerScreen(
                                towerChoose: addContractController
                                    .towerChoose.value,
                                onChoose: (Tower tower) {
                                  addContractController
                                      .towerChoose.value = tower;
                                  addContractController.contractReq
                                      .value.towerId = tower.id;

                                  ///// xoá data phòng đã chọn
                                  addContractController
                                      .motelChoose.value = MotelRoom();
                                  addContractController
                                      .contractReq.value.motelId = null;
                                },
                              ));
                        }
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
                            Text(
                              ignoring == true
                                  ? "Tên toà nhà *"
                                  : "Tên toà nhà *",
                              style: TextStyle(
                                  color: Colors.black54,
                                  backgroundColor: Theme
                                      .of(context)
                                      .scaffoldBackgroundColor,
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
                                        () =>
                                        Text(
                                          motelRoomInput?.towerName != null
                                              ? motelRoomInput!.towerName ?? ""
                                              :
                                          addContractController
                                              .towerChoose
                                              .value
                                              .id ==
                                              null
                                              ? 'chọn toà nhà'
                                              : addContractController
                                              .towerChoose
                                              .value
                                              .towerName ??
                                              "",
                                          style: TextStyle(
                                            color: addContractController
                                                .towerChoose
                                                .value
                                                .id ==
                                                null
                                                ? Colors.grey
                                                : null,
                                          ),
                                        ),
                                  ),
                                ),
                                if (ignoring == false)
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

                    InkWell(
                      onTap: () {
                        Get.to(() =>
                            ChooseRoomScreen(
                              towerId: addContractController
                                  .towerChoose.value.id,
                              isSupporter: addContractController
                                  .towerChoose
                                  .value
                                  .isSupportManageTower ==
                                  true
                                  ? true
                                  : null,
                              isTower: addContractController
                                  .towerChoose.value.id ==
                                  null
                                  ? false
                                  : true,
                              tower: addContractController
                                  .towerChoose.value,
                              isFromChooseRoom: true,
                              listMotelInput: [
                                addContractController
                                    .motelChoose.value
                              ],
                              hasContract: false,
                              onChoose: (List<MotelRoom> v) {
                                addContractController.contractReq
                                    .value.motelId = v[0].id;
                                addContractController
                                    .motelChoose.value = v[0];
                                print(v[0].motelName);
                                addContractController
                                    .convertRequest();
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
                            Text(
                              ignoring == true
                                  ? "Số/tên phòng *"
                                  : "Số/tên phòng *",
                              style: TextStyle(
                                  color: Colors.black54,
                                  backgroundColor: Theme
                                      .of(context)
                                      .scaffoldBackgroundColor,
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
                                        () =>
                                        Text(
                                          addContractController
                                              .motelChoose
                                              .value
                                              .id ==
                                              null
                                              ? 'chọn phòng'
                                              : addContractController
                                              .motelChoose
                                              .value
                                              .motelName ??
                                              "",
                                          style: TextStyle(
                                            color: addContractController
                                                .motelChoose
                                                .value
                                                .id ==
                                                null
                                                ? Colors.grey
                                                : null,
                                          ),
                                        ),
                                  ),
                                ),
                                if (ignoring == false)
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
                    Container(
                      margin:
                      const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Thời hạn *",
                            style: TextStyle(
                                color: Colors.black54,
                                backgroundColor: Theme
                                    .of(context)
                                    .scaffoldBackgroundColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InfoInputTextField(
                                  textEditingController:
                                  addContractController
                                      .dateRangeEdit,
                                  hintText: "Từ ngày",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                  icon: const Icon(
                                      Icons.calendar_today_sharp),
                                  onTap: () async {
                                    var date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate:
                                        DateTime(2000, 1, 1),
                                        lastDate:
                                        DateTime(2100, 1, 1));
                                    if (date != null) {
                                      addContractController.fromTime =
                                          date;

                                      addContractController
                                          .contractReq
                                          .value
                                          .rentFrom = date;

                                      addContractController
                                          .dateRangeEdit.text =
                                          SahaDateUtils()
                                              .getDDMMYY(date);

                                      addContractController
                                          .contractReq
                                          .value
                                          .rentTo =
                                          DateTime(
                                              addContractController
                                                  .fromTime.year + 1,
                                              addContractController
                                                  .fromTime
                                                  .month,
                                              addContractController
                                                  .fromTime.day);

                                      addContractController
                                          .dateRangeToEdit.text =
                                          SahaDateUtils().getDDMMYY(
                                              DateTime(
                                                  addContractController
                                                      .fromTime.year + 1,
                                                  addContractController
                                                      .fromTime
                                                      .month,
                                                  addContractController
                                                      .fromTime.day));
                                    }

                                    // DatePicker.showDatePicker(

                                    //     Get.context!,

                                    //     showTitleActions: true,
                                    //     minTime: DateTime(1999, 1, 1),
                                    //     maxTime: DateTime(2050, 1, 1),
                                    //     theme: const DatePickerTheme(
                                    //       headerColor: Colors.white,
                                    //       backgroundColor:
                                    //           Colors.white,
                                    //       itemStyle: TextStyle(
                                    //           color: Colors.black,
                                    //           fontWeight:
                                    //               FontWeight.bold,
                                    //           fontSize: 18),
                                    //       doneStyle: TextStyle(
                                    //           color: Colors.black,
                                    //           fontSize: 16),
                                    //     ), onConfirm: (date) {
                                    //   addContractController
                                    //       .contractReq
                                    //       .value
                                    //       .rentFrom = date;
                                    //   addContractController
                                    //           .dateRangeEdit.text =
                                    //       SahaDateUtils()
                                    //           .getDDMMYY(date);
                                    // },
                                    //     currentTime: DateTime.now(),
                                    //     locale: LocaleType.vi);
                                  },
                                ),
                              ),
                              Expanded(
                                child: InfoInputTextField(
                                  textEditingController:
                                  addContractController
                                      .dateRangeToEdit,
                                  hintText: "Đến ngày",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                  icon: const Icon(
                                      Icons.calendar_today_sharp),
                                  onTap: () async {
                                    var date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime(
                                            addContractController
                                                .fromTime.year,
                                            addContractController
                                                .fromTime.month +
                                                1,
                                            addContractController
                                                .fromTime.day),
                                        firstDate:
                                        DateTime(2000, 1, 1),
                                        lastDate:
                                        DateTime(2100, 1, 1));
                                    if (date != null) {
                                      if (date ==
                                          addContractController
                                              .fromTime) {
                                        SahaAlert.showError(
                                            message:
                                            'Ngày kết thúc không được trùng ngày bắt đầu');
                                      }
                                      addContractController
                                          .contractReq
                                          .value
                                          .rentTo = date;
                                      addContractController
                                          .dateRangeToEdit.text =
                                          SahaDateUtils()
                                              .getDDMMYY(date);
                                    }
                                    // DatePicker.showDatePicker(
                                    //     Get.context!,
                                    //     showTitleActions: true,
                                    //     minTime: DateTime(1999, 1, 1),
                                    //     maxTime: DateTime(2050, 1, 1),
                                    //     theme: DatePickerTheme(
                                    //         headerColor: Colors.white,
                                    //         backgroundColor:
                                    //             Colors.white,
                                    //         itemStyle: TextStyle(
                                    //             color: Colors.black,
                                    //             fontWeight:
                                    //                 FontWeight.bold,
                                    //             fontSize: 18),
                                    //         doneStyle: TextStyle(
                                    //             color: Colors.black,
                                    //             fontSize: 16)),
                                    //     onConfirm: (date) {
                                    //   addContractController
                                    //       .contractReq
                                    //       .value
                                    //       .rentTo = date;
                                    //   addContractController
                                    //           .dateRangeToEdit.text =
                                    //       SahaDateUtils()
                                    //           .getDDMMYY(date);
                                    // },
                                    //     currentTime: DateTime.now(),
                                    //     locale: LocaleType.vi);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ngày bắt đầu tính tiền *",
                            style: TextStyle(
                                color: Colors.black54,
                                backgroundColor: Theme
                                    .of(context)
                                    .scaffoldBackgroundColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InfoInputTextField(
                            textEditingController:
                            addContractController
                                .dateBeginMoneyEdit,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                            hintText: "Chọn ngày",
                            icon: const Icon(
                                Icons.calendar_today_sharp),
                            onTap: () async {
                              var date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000, 1, 1),
                                  lastDate: DateTime(2100, 1, 1));
                              if (date != null) {
                                addContractController.contractReq
                                    .value.startDate = date;
                                addContractController
                                    .dateBeginMoneyEdit.text =
                                    SahaDateUtils().getDDMMYY(date);
                              }
                              // DatePicker.showDatePicker(Get.context!,
                              //     showTitleActions: true,
                              //     minTime: DateTime(1999, 1, 1),
                              //     maxTime: DateTime(2050, 1, 1),
                              //     theme: DatePickerTheme(
                              //         headerColor: Colors.white,
                              //         backgroundColor: Colors.white,
                              //         itemStyle: TextStyle(
                              //             color: Colors.black,
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 18),
                              //         doneStyle: TextStyle(
                              //             color: Colors.black,
                              //             fontSize: 16)),
                              //     onConfirm: (date) {
                              //   addContractController.contractReq
                              //       .value.startDate = date;
                              //   addContractController
                              //           .dateBeginMoneyEdit.text =
                              //       DateFormat('dd-MM-yyyy')
                              //           .format(date);
                              // },
                              //     currentTime: DateTime.now(),
                              //     locale: LocaleType.vi);
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 5,
                        left: 15,
                        right: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kì thanh toán tiền phòng *",
                            style: TextStyle(
                                color: Colors.black54,
                                backgroundColor: Theme
                                    .of(context)
                                    .scaffoldBackgroundColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              SahaDialogApp.showDialogPaymentTerm(
                                onChoose: (paymentTerm) {
                                  addContractController.contractReq
                                      .value.paymentSpace =
                                  paymentTerm as int;
                                  addContractController.contractReq
                                      .refresh();
                                },
                              );
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(
                                        () =>
                                    addContractController
                                        .contractReq
                                        .value
                                        .paymentSpace ==
                                        1
                                        ? const Text(
                                      "1 Tháng",
                                    )
                                        : addContractController
                                        .contractReq
                                        .value
                                        .paymentSpace ==
                                        2
                                        ? const Text(
                                      "2 Tháng",
                                    )
                                        : addContractController
                                        .contractReq
                                        .value
                                        .paymentSpace ==
                                        3
                                        ? const Text(
                                      "3 Tháng",
                                    )
                                        : addContractController
                                        .contractReq
                                        .value
                                        .paymentSpace ==
                                        4
                                        ? const Text(
                                      "4 Tháng",
                                    )
                                        : addContractController
                                        .contractReq
                                        .value
                                        .paymentSpace ==
                                        5
                                        ? const Text(
                                      "5 Tháng",
                                    )
                                        : addContractController
                                        .contractReq
                                        .value
                                        .paymentSpace ==
                                        6
                                        ? const Text(
                                      "6 Tháng",
                                    )
                                        : addContractController.contractReq
                                        .value.paymentSpace ==
                                        7
                                        ? const Text(
                                      "7",
                                    )
                                        : addContractController.contractReq
                                        .value.paymentSpace == 8
                                        ? const Text(
                                      "8 Tháng",
                                    )
                                        : addContractController.contractReq
                                        .value.paymentSpace == 9
                                        ? const Text(
                                      "9 Tháng",
                                    )
                                        : addContractController.contractReq
                                        .value.paymentSpace == 10
                                        ? const Text(
                                      "10 Tháng",
                                    )
                                        : addContractController.contractReq
                                        .value.paymentSpace == 11
                                        ? const Text(
                                      "11 Tháng",
                                    )
                                        : addContractController.contractReq
                                        .value.paymentSpace == 12
                                        ? const Text(
                                      "12 Tháng",
                                    )
                                        : Container(
                                      child: const Text(
                                        "Chọn kỳ hạn thanh toán",
                                        style: TextStyle(),
                                      ),
                                    ),
                                  ),
                                  if (ignoring == false)
                                    const Icon(
                                      Icons.chevron_right_rounded,
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    SahaDivide(),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/icon_contract/tien-phong.png',
                          width: Get.width / 4,
                        )),
                    SahaTextFieldNoBorder(
                      withAsterisk: true,
                      controller: addContractController
                          .moneyRoomMonthAgentEdit,
                      textInputType: TextInputType.number,
                      inputFormatters: [ThousandsFormatter()],
                      onChanged: (v) {
                        addContractController
                            .contractReq.value.money =
                            double.parse(SahaStringUtils()
                                .convertFormatText(v));
                      },
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          SahaAlert.showError(
                              message: "Chưa nhập tiền phòng");
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      labelText: "Tiền phòng",
                      hintText: "Nhập tiền phòng 1 tháng",
                    ),
                    const Divider(),
                    SahaTextFieldNoBorder(
                      withAsterisk: true,
                      controller: addContractController
                          .depositMoneyMonthAgentEdit,
                      textInputType: TextInputType.number,
                      inputFormatters: [ThousandsFormatter()],
                      onChanged: (v) {
                        addContractController
                            .contractReq.value.depositMoney =
                            double.parse(SahaStringUtils()
                                .convertFormatText(v));
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      labelText: "Tiền cọc",
                      hintText: "Nhập tiền đặt cọc khi khách thuê",
                    ),
                    SahaDivide(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/icon_contract/phi-dich-vu.png',
                            width: Get.width / 4,
                          ),
                          // IconButton(
                          //     onPressed: () {
                          //       Get.to(() => ChooseServiceScreen(
                          //           listServiceInput:
                          //               (addContractController
                          //                           .contractReq
                          //                           .value
                          //                           .moServicesReq ??
                          //                       [])
                          //                   .toList(),
                          //           onChoose: (List<Service> v) {
                          //             addContractController
                          //                 .contractReq
                          //                 .value
                          //                 .moServicesReq = [];
                          //             (addContractController
                          //                         .contractReq
                          //                         .value
                          //                         .moServicesReq ??
                          //                     [])
                          //                 .addAll(v);
                          //             addContractController
                          //                 .contractReq
                          //                 .refresh();
                          //           }));
                          //     },
                          //     icon: const Icon(Icons.add))
                        ],
                      ),
                    ),
                    Obx(
                          () =>
                      (addContractController.contractReq.value
                          .moServicesReq ??
                          [])
                          .isEmpty
                          ? Container()
                          : Center(
                        child: Column(
                          children: [
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                ...(addContractController
                                    .contractReq
                                    .value
                                    .moServicesReq ??
                                    [])
                                    .map((e) {
                                  return itemService(
                                      value: (addContractController
                                          .contractReq
                                          .value
                                          .moServicesReq ??
                                          [])
                                          .map((e) =>
                                      e.serviceName)
                                          .contains(
                                          e.serviceName),
                                      service: e,
                                      onCheck: () {});
                                }).toList()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                          () =>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...(addContractController.contractReq.value
                                  .moServicesReq ??
                                  [])
                                  .map((e) =>
                                  oldQuantity(
                                      e,
                                      (addContractController.contractReq
                                          .value.moServicesReq ??
                                          [])
                                          .indexOf(e)))
                            ],
                          ),
                    ),
                    SahaDivide(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/icon_contract/noi-that.png',
                            width: Get.width / 4,
                          ),
                          IconButton(
                              onPressed: () {
                                DialogAddService
                                    .showDialogFurnitureInput(
                                    onDone: (name, quantity) {
                                      addContractController
                                          .contractReq.value.furniture!
                                          .add(Furniture(
                                          name: name,
                                          quantity:
                                          int.parse(quantity)));

                                      addContractController.contractReq
                                          .refresh();
                                      Get.back();
                                    });
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                    ),
                    Obx(
                          () =>
                      (addContractController
                          .contractReq.value.furniture ??
                          [])
                          .isEmpty
                          ? const SizedBox()
                          : Padding(
                        padding: const EdgeInsets.only(
                            right: 15.0,
                            left: 15,
                            top: 0,
                            bottom: 10),
                        child: Column(
                          children: [
                            ...(addContractController
                                .contractReq
                                .value
                                .furniture ??
                                [])
                                .map((e) =>
                                itemFurniture(
                                    e,
                                    (addContractController
                                        .contractReq
                                        .value
                                        .furniture ??
                                        [])
                                        .indexOf(e)))
                          ],
                        ),
                      ),
                    ),

                    SahaDivide(),
                    Obx(
                          () =>
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SelectImages(
                              type: CONTRACT_FILES_FOLDER,
                              maxImage: 10,
                              title: 'Ảnh hợp đồng',
                              subTitle: 'Tối đa 10 hình',
                              onUpload: () {
                                addContractController
                                    .doneUploadImage.value = false;
                              },
                              images: addContractController.listImages
                                  .toList(),
                              doneUpload: (List<ImageData> listImages) {
                                print(
                                    "done upload image ${listImages
                                        .length} images => ${listImages.toList()
                                        .map((e) => e.linkImage)
                                        .toList()}");
                                addContractController
                                    .listImages(listImages);
                                addContractController.contractReq.value
                                    .images = (listImages
                                    .map((e) => e.linkImage ?? ""))
                                    .toList();
                                print(addContractController
                                    .contractReq.value.images);
                                addContractController
                                    .doneUploadImage.value = true;
                              },
                            ),
                          ),
                    ),
                    if (addContractController
                        .contractRes.value.status !=
                        0 &&
                        addContractController
                            .contractRes.value.status !=
                            null)
                      Obx(
                            () =>
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ảnh thanh toán',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color:
                                      Theme
                                          .of(context)
                                          .primaryColor,
                                    ),
                                  ),
                                  Wrap(
                                    children: [
                                      ...(addContractController
                                          .contractRes
                                          .value
                                          .imagesDeposit ??
                                          [])
                                          .map((e) => imagesPayment(e))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      ),

                    // Container(
                    //     padding: EdgeInsets.all(10),
                    //     child: Text(
                    //       'Ghi chú',
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w700,
                    //         color: Theme.of(context).primaryColor,
                    //       ),
                    //     )),
                    SahaTextFieldNoBorder(
                      controller: addContractController.noteEdit,
                      textInputType: TextInputType.text,
                      onChanged: (v) {
                        addContractController.contractReq.value.note =
                            v;
                      },
                      labelText: "Ghi chú",
                      hintText: "Nhập ghi chú",
                    ),
                    const Divider(),
                    // Container(
                    //   margin: EdgeInsets.only(
                    //     left: 15,
                    //     right: 15,
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Expanded(child: Text('Điều khoản')),
                    //           IconButton(onPressed: () {}, icon: Icon(Icons.add))
                    //         ],
                    //       ),
                    //       Container(
                    //         padding: EdgeInsets.all(10),
                    //         child: Text('Chọn điều khoản'),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Obx(() =>
        ignoring == true &&
            addContractController.contractRes.value.status != 0
            ? Container(
          height: 1,
        )
        // : addContractController.contractRes.value.status == 2
        //     ? Container(
        //         height: 1,
        //       )
            : Row(
          children: [
            if(addContractController.contractRes.value.status != 3)
              Expanded(
                child: Container(
                  height: 65,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Obx(
                            () =>
                            SahaButtonFullParent(
                              text: contractId != null ? 'Chỉnh sửa' : 'Đồng ý',
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                //   if (contractId != null) {
                                //     addContractController.updateContract();
                                //   } else {
                                //     addContractController.addContract();
                                //   }
                                // }
                                if (contractId != null) {
                                  if (addContractController
                                      .doneUploadImage.value ==
                                      true) {
                                    addContractController.updateContract();
                                  }
                                } else {
                                  if (addContractController
                                      .doneUploadImage.value ==
                                      true) {
                                    addContractController.addContract();
                                  }
                                }
                              },
                              color: addContractController.doneUploadImage.value
                                  ? Theme
                                  .of(context)
                                  .primaryColor
                                  : Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            if (addContractController.contractRes.value.status == 0)
              Expanded(
                child: Container(
                  height: 65,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SahaButtonFullParent(
                        text: 'Nhắc thanh toán',
                        onPressed: () {},
                        color: Theme
                            .of(context)
                            .primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            if (addContractController.contractRes.value.status == 3)
              Expanded(
                child: Container(
                  height: 65,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SahaButtonFullParent(
                        text: 'Xác nhận đã thanh toán',
                        onPressed: () {
                          addContractController.confirmDeposit(
                              id: contractId!);
                        },
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            if (addContractController.contractRes.value.status == 2)
              Expanded(
                child: Container(
                  height: 65,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SahaButtonFullParent(
                        text: 'Chấm dứt hợp đồng',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Center(
                                  child: Text(
                                    'Xoá người thuê',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                content: SizedBox(
                                  width: Get.width,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Bạn xác định muốn chấm dứt hợp đồng thuê phòng với ${addContractController
                                            .listRenterChoose
                                            .where((e) =>
                                        e.isRepresent ==
                                            true)
                                            .toList()[0]
                                            .name ?? ""} ?",
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        "Nếu muốn gia hạn thì bạn chỉ cần chỉnh sửa lại thời hạn hợp đồng và up ảnh hợp đồng mới là được nha!",
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets
                                                  .fromLTRB(
                                                  20, 10, 20, 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(12)),
                                              child: const Center(
                                                child: Text(
                                                  "Suy nghĩ lại",
                                                  style: TextStyle(
                                                      color:
                                                      Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              addContractController
                                                  .changeStatus(
                                                  id: contractId!,
                                                  status: 1);
                                            },
                                            child: Container(
                                              padding:
                                              const EdgeInsets.all(
                                                  10),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(12)),
                                              child: const Center(
                                                child: Text(
                                                  "Chấm dứt hợp đồng",
                                                  style: TextStyle(
                                                      color:
                                                      Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        color: Theme
                            .of(context)
                            .primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        )),
      ),
    );
  }

  Widget itemRenter({required Renter renter, required int index}) {
    return renter.isRepresent == true
        ? const SizedBox()
        : GestureDetector(
      onTap: () {
        // Get.to(() => AddUpdateTenantScreen(
        //       tenantInput: renter,
        //       ignoring: true,
        //     ));

        Get.to(() =>
            AddRenterScreen(
              onSubmit: (Renter renter) {
                addContractController.listRenterChoose[index] =
                    renter;
              },
              renterInput: renter,
            ))!
            .then((value) =>
            addContractController.listRenterChoose.refresh());
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            // const SahaEmptyAvata(),
            // const SizedBox(
            //   width: 10,
            // ),
            Expanded(
              child: Text(
                addContractController.listRenterChoose.isNotEmpty
                    ? renter.name ?? "Chưa đặt tên"
                    : "Thêm người cho thuê",
              ),
            ),
            if (renter.isRepresent == true)
              Text(
                'Đại diện',
                style: TextStyle(
                  color: Theme
                      .of(Get.context!)
                      .primaryColor,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget itemService({required bool value,
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
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: value
                      ? Theme
                      .of(Get.context!)
                      .primaryColor
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
                service.serviceIcon != null
                    ? Image.asset(
                  service.serviceIcon != null &&
                      service.serviceIcon!.isNotEmpty
                      ? service.serviceIcon ?? ""
                      : "",
                  width: 25,
                  height: 25,
                )
                    : const SizedBox(),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    service.serviceName ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.2,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                Text(
                  "${SahaStringUtils().convertToMoney(
                      service.serviceCharge ?? "")}đ/${service.serviceUnit ??
                      ""}",
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
          //       addContractController.contractReq.value.moServicesReq!
          //           .remove(service);
          //       addContractController.contractReq.refresh();
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
          //               var index = addContractController
          //                   .contractReq.value.moServicesReq
          //                   ?.indexWhere((element) =>
          //                       element.serviceName == service.serviceName);
          //               addContractController.contractReq.value
          //                       .moServicesReq![index!].serviceCharge =
          //                   double.parse(
          //                       SahaStringUtils().convertFormatText(v));
          //               addContractController.contractReq.refresh();
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

  bool isRepresent() {
    var listRenter = addContractController.contractRes.value.listRenter;
    var renter =
    listRenter?.firstWhere((element) => element.isRepresent == true);
    if (dataAppController.currentUser.value.phoneNumber ==
        renter?.phoneNumber) {
      return true;
    } else {
      return false;
    }
  }

  Widget imagesPayment(String images) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          ShowImage.seeImage(
              listImageUrl:
              (addContractController.contractRes.value.imagesDeposit ?? [])
                  .toList(),
              index:
              (addContractController.contractRes.value.imagesDeposit ?? [])
                  .toList()
                  .indexOf(images));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: CachedNetworkImage(
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            imageUrl: images,
            //placeholder: (context, url) => SahaLoadingWidget(),
            errorWidget: (context, url, error) => const SahaEmptyImage(),
          ),
        ),
      ),
    );
  }

  Widget images(String images) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          ShowImage.seeImage(listImageUrl: [images], index: 0);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: CachedNetworkImage(
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            imageUrl: images,
            //placeholder: (context, url) => SahaLoadingWidget(),
            errorWidget: (context, url, error) => const SahaEmptyImage(),
          ),
        ),
      ),
    );
  }

  Widget itemFurniture(Furniture furniture, int index) {
    return InkWell(
      onTap: () {
        DialogAddService.showDialogFurnitureInput(
            isFix: true,
            nameService: furniture.name,
            quantity: furniture.quantity,
            onDone: (name, quantity) {
              (addContractController.contractReq.value.furniture ?? [])[index] =
                  Furniture(name: name, quantity: int.parse(quantity));

              addContractController.contractReq.refresh();
              Get.back();
            });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: Colors.blue,
                  size: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  furniture.name ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Text(furniture.quantity.toString()),
                IconButton(
                    onPressed: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: 'Bạn có đồng ý xoá nội thất này chứ ?',
                          onOK: () {
                            (addContractController
                                .contractReq.value.furniture ??
                                [])
                                .removeAt(index);
                            addContractController.contractReq.refresh();
                          });
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  Widget oldQuantity(Service service, int index) {
    var oldQuantityEdit = TextEditingController(
        text:
        service.oldQuantity == null ? '' : service.oldQuantity.toString());
    return service.typeUnit == 0
        ? SahaTextFieldNoBorder(
      //withAsterisk: true,
      controller: oldQuantityEdit,
      textInputType: TextInputType.number,
      //inputFormatters: [ThousandsFormatter()],
      onChanged: (v) {
        addContractController.contractReq.value.moServicesReq![index]
            .oldQuantity = int.tryParse(v!);
      },
      validator: (value) {
        if ((value ?? '').isEmpty) {
          SahaAlert.showError(
              message: "Chưa nhập số ${service.serviceName ?? ''}");
          return 'Không được để trống';
        }
        return null;
      },
      labelText: "Chỉ số ${service.serviceName ?? ''} hiện tại",
      hintText: "Nhập số ${service.serviceName ?? ''} hiện tại",
    )
        : const SizedBox();
  }
}
