import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/text_field/rice_text_field.dart';
import 'package:gohomy/screen/owner/renters/renter_details/renter_detail_controller.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../components/appbar/saha_appbar.dart';
import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../model/motel_room.dart';
import '../../../../model/renter.dart';
import '../../../../model/tower.dart';
import '../../../../model/user.dart';
import '../../../../utils/call.dart';
import '../../../../utils/string_utils.dart';
import '../../../chat/chat_detail/chat_detail_screen.dart';
import '../../../profile/bill/add_bill/add_bill_screen.dart';
import '../../../profile/bill/bill_details/bill_details_screen.dart';
import '../../choose_room/choose_room_screen.dart';
import '../../contract/add_contract/add_contract_screen.dart';
import '../../motel_room/choose_tower/choose_tower_screen.dart';

class RenterDetailScreen extends StatelessWidget {
  RenterDetailScreen({super.key,required this.renterId,}) {
    controller = RenterDetailController(renterId: renterId,);
  }
  final int renterId;
  late RenterDetailController controller;
  ScrollController billScrollController = ScrollController();
  ScrollController contractScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: 'Người thuê',
          actions: [
            IconButton(
                onPressed: () {
                  if (controller.renterReq.value.hasContract == false) {
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Bạn xác định muốn xoá người thuê ${controller.renterReq.value.name ?? ""} khỏi danh sách người thuê ?",
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: const Center(
                                          child: Text(
                                            "Suy nghĩ lại",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.deleteRenter(
                                            renterId:
                                                controller.renterReq.value.id!);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: const Center(
                                          child: Text(
                                            "Xoá",
                                            style:
                                                TextStyle(color: Colors.white),
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
                  } else {
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Bạn xác định muốn xoá người thuê ${controller.renterReq.value.name ?? ""} khỏi danh sách người thuê ?",
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Hãy chấm dứt hợp đồng trước nha!",
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: const Center(
                                          child: Text(
                                            "Suy nghĩ lại",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                         Get.to(()=>AddContractScreen(
                                                      contractId: controller.renterReq.value.contractActive?.id!,
                                                    ));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: const Center(
                                          child: Text(
                                            "Chấm dứt hợp đồng",
                                            style:
                                                TextStyle(color: Colors.white),
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
                  }
                },
                icon: const Icon(FontAwesomeIcons.trashCan))
          ],
        ),
        body: Obx(
          () => controller.loadInit.value
              ? SahaLoadingFullScreen()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        child: CachedNetworkImage(
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                          imageUrl: controller.renterReq.value
                                                  .avatarImage ??
                                              '',
                                          // placeholder: (context, url) =>
                                          //     SahaLoadingWidget(),
                                          errorWidget: (context, url, error) =>
                                              const SahaEmptyAvata(
                                            height: 100,
                                            width: 100,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Call.call(controller
                                              .renterReq.value.phoneNumber ??
                                          '');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Row(children: const [
                                        Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Gọi',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ]),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (controller.renterReq.value.user ==
                                          null) {
                                        SahaAlert.showError(
                                            message:
                                                "Người thuê chưa tạo tài khoản");
                                        return;
                                      }
                                      Get.to(() => ChatDetailScreen(
                                            toUser: controller
                                                    .renterReq.value.user ??
                                                User(),
                                          ));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Row(children: const [
                                        Icon(
                                          Icons.chat,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'SMS',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      item(
                          icon: const Icon(Icons.person),
                          child: RiceTextField(
                            controller: controller.name,
                            hintText: "Nhập tên người thuê",
                            onChanged: (v) {
                              controller.renterReq.value.name = v;
                            },
                          )),
                      item(
                          icon: const Icon(Icons.phone),
                          child: RiceTextField(
                            controller: controller.phone,
                            hintText: "Nhập số điện thoại",
                            onChanged: (v) {
                              controller.renterReq.value.phoneNumber = v;
                            },
                          )),
                      item(
                          icon: const Icon(Icons.email),
                          child: RiceTextField(
                            hintText: "Nhập email",
                            controller: controller.email,
                            onChanged: (v) {
                              controller.renterReq.value.email = v;
                            },
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      if (controller.renterReq.value.hasContract == false)
                        Column(
                          children: [
                            textField(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ChooseTowerScreen(
                                        towerChoose: controller.towerSelected,
                                        onChoose: (Tower tower) {
                                          controller.nameTower.text =
                                              tower.towerName ?? "Chưa có tên";
                                          controller.towerSelected = tower;
                                          controller.renterReq.value
                                                  .nameTowerExpected =
                                              tower.towerName;
                                          controller.renterReq.value.towerId = tower.id;

                                          ///// xoá data phòng đã chọn
                                          controller.roomName.text = '';
                                          controller.motelRoomSelected = null;
                                          controller.renterReq.value.motelName =
                                              null;
                                              controller.renterReq.value.motelId =
                                              null;
                                        },
                                      ));
                                },
                                child: RiceTextField(
                                  enabled: false,
                                  hintText: "Chọn toà nhà",
                                  controller: controller.nameTower,
                                ),
                              ),
                              labelText: "Tên toà nhà",
                            ),
                            textField(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ChooseRoomScreen(
                                        hasContract: false,
                                        listMotelInput: controller
                                                    .motelRoomSelected ==
                                                null
                                            ? []
                                            : [controller.motelRoomSelected!],
                                        towerId: controller.towerSelected?.id,
                                        isTower:
                                            controller.towerSelected?.id == null
                                                ? false
                                                : true,
                                        tower: controller.towerSelected,
                                        onChoose: (v) {
                                          if (v.isNotEmpty) {
                                            controller.roomName.text =
                                                v[0].motelName;
                                            controller.motelRoomSelected = v[0];
                                            controller.renterReq.value
                                                .motelName = v[0].motelName;
                                                 controller.renterReq.value
                                                .motelId = v[0].id;
                                          }
                                        },
                                      ));
                                },
                                child: RiceTextField(
                                  enabled: false,
                                  hintText: "Chọn số phòng",
                                  controller: controller.roomName,
                                ),
                              ),
                              labelText: "Số/tên phòng",
                            ),
                            textField(
                              child: RiceTextField(
                                hintText: "Tiền phòng dự kiến",
                                controller: controller.priceExpected,
                                textInputType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [ThousandsFormatter()],
                                onChanged: (v) {
                                  controller.renterReq.value.priceExpected =
                                      
                                  double.tryParse(SahaStringUtils()
                                  .convertFormatText(v!));
                                },
                                suffixText: "VNĐ",
                              ),
                              labelText: "Tiền phòng dự kiến",
                            ),
                            textField(
                              child: Stack(
                                children: [
                                  RiceTextField(
                                    hintText: "Nhập thời hạn thuê dự kiến",
                                    controller: controller.intendTimeHire,
                                    onChanged: (v) {
                                      controller.renterReq.value
                                          .estimateRentalPeriod = v;
                                    },
                                  ),
                                  const Positioned(
                                      right: 5, top: 5, child: Text("(Tháng)"))
                                ],
                              ),
                              labelText: "Thời hạn thuê dự kiến",
                            ),
                            textField(
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      var date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2022, 1, 1),
                                          lastDate: DateTime(2050, 1, 1));
                                      if (date != null) {
                                        controller.intendDayHire.text =
                                            DateFormat('dd-MM-yyyy')
                                                .format(date);
                                        controller.renterReq.value
                                            .estimateRentalDate = date;
                                      }
                                    },
                                    child: RiceTextField(
                                      enabled: false,
                                      hintText: "Chọn ngày thuê dự kiến",
                                      controller: controller.intendDayHire,
                                    ),
                                  ),
                                  const Positioned(
                                      right: 5,
                                      top: 5,
                                      child: Icon(Icons.calendar_month))
                                ],
                              ),
                              labelText: "Ngày thuê dự kiến",
                            ),
                          ],
                        ),
                      if (controller.renterReq.value.hasContract == true)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              itemMotel(
                                  title: "Tên toà nhà",
                                  subTitle: controller
                                          .renterReq.value.contractActive?.tower?.towerName ??
                                      "Chưa có thông tin"),
                              itemMotel(
                                  title: "Số/tên phòng",
                                  subTitle:
                                      controller.renterReq.value.contractActive?.motelRoom?.motelName ??
                                          "Chưa có thông tin"),
                              Text(
                                'Hoá đơn : ${(controller.renterReq.value.listBill ?? []).length}',
                                style: const TextStyle(color: Colors.blue),
                              ),
                              if ((controller.renterReq.value.listBill ?? [])
                                  .isNotEmpty)
                                Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: RawScrollbar(
                                    controller: billScrollController,
                                    thumbVisibility: true,
                                    thumbColor: Colors.deepOrange,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ...(controller.renterReq.value
                                                      .listBill ??
                                                  [])
                                              .map((e) => InkWell(
                                                    onTap: () {
                                                      Get.to(() => BillDetails(
                                                            billId: e.id!,
                                                          ));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.circle,
                                                          color: Colors.black,
                                                          size: 5,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                              "Tháng ${e.content}: ${SahaStringUtils().convertToUnit(e.totalFinal)}đ"),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Hợp đồng : ${(controller.renterReq.value.listContract ?? []).length}',
                                style: const TextStyle(color: Colors.blue),
                              ),
                              if ((controller.renterReq.value.listContract ??
                                      [])
                                  .isNotEmpty)
                                Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: RawScrollbar(
                                    controller: contractScrollController,
                                    thumbVisibility: true,
                                    thumbColor: Colors.deepOrange,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ...(controller.renterReq.value
                                                      .listContract ??
                                                  [])
                                              .map((e) => InkWell(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          AddContractScreen(
                                                            contractId: e.id,
                                                          ));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.circle,
                                                          color: Colors.blue,
                                                          size: 5,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "Hợp đồng thuê phòng ${e.motelRoom?.motelName ?? 'Chưa có thông tin'} từ ${DateFormat('dd-MM-yyyy').format(e.rentFrom ?? DateTime.now())} đến ${DateFormat('dd-MM-yyyy').format(e.rentTo ?? DateTime.now())}",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
        ),
        bottomNavigationBar: Obx(
          () => controller.loadInit.value == true
              ? const SizedBox()
              : Container(
                padding: const EdgeInsets.only(left: 15,right: 15),
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (controller.renterReq.value.hasContract == true)
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                   Get.to(()=>AddBillScreen());
                                },
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.only(left: 8, right: 8),
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(8)),
                                      child: const Center(
                                        child: Text(
                                          'Tạo hoá đơn',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      left: 10,
                                      child:  Icon(
                                          Icons.note_add,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          if (controller.renterReq.value.hasContract == false)
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => AddContractScreen(
                                        renterInput: controller.renterReq.value,
                                        motelRoomInput: controller
                                                    .renterReq.value.motelId ==
                                                null
                                            ? null
                                            : controller
                                                .renterReq.value.motelRoom,
                                        tower: controller
                                                    .renterReq.value.towerId ==
                                                null
                                            ? null
                                            : Tower(
                                                id: controller
                                                    .renterReq.value.towerId,
                                                towerName: controller.renterReq
                                                    .value.nameTowerExpected),
                                      ));
                                },
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.only(left: 8, right: 8),
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(8)),
                                      child:const Center(
                                        child: Text(
                                          'Tạo hợp đồng',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      left: 10,
                                      child:   Icon(
                                          Icons.note_alt,
                                          color: Colors.white,
                                        ),)
                                  ],
                                ),
                              ),
                            ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                               
                                  controller.updateTenant();
                                
                                
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Center(
                                  child: Text(
                                    'Chỉnh sửa',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget item({required Widget icon, required Widget child}) {
    return Card(
      child: ListTile(
        leading: icon,
        title: child,
      ),
    );
  }

  Widget textField({required Widget child, required String labelText}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          child,
          const Divider()
        ],
      ),
    );
  }

  Widget itemMotel({required String title, required String subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 8,
        ),
        Text(subTitle),
        const Divider()
      ],
    );
  }
}
