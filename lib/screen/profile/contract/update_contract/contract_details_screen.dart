import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/renter.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/profile/contract/contract_deposit_payment/contract_deposit_screen.dart';
import 'package:gohomy/screen/profile/contract/update_contract/contract_details_controller.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../components/divide/divide.dart';
import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../components/text_field/info_input_text_field.dart';
import '../../../../components/text_field/text_field_no_border.dart';
import '../../../../components/widget/image/select_images.dart';
import '../../../../components/widget/image/show_image.dart';
import '../../../../const/type_image.dart';
import '../../../../model/furniture.dart';
import '../../../../model/image_assset.dart';
import '../../../../model/service.dart';
import '../../../../utils/string_utils.dart';
import '../contract_deposit_payment/payment_screen.dart';

class UpdateContractScreen extends StatelessWidget {
  late UpdateContractController updateContractController;
  final _formKey = GlobalKey<FormState>();

  DataAppController dataAppController = Get.find();
  int? id;

  UpdateContractScreen({this.id}) {
    updateContractController = UpdateContractController(contractId: id);
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
                    colors: <Color>[Colors.deepOrange, Colors.orange]),
              ),
            ),
            title: const Text('Hợp đồng'),
          ),
          body: Obx(
            () => updateContractController.isLoading.value
                ? SahaLoadingFullScreen()
                : SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: IgnorePointer(
                      ignoring: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/icon_contract/thong-tin.png',
                                width: Get.width / 4,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Chủ nhà',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      backgroundColor: Theme.of(context)
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
                                        () => Text(
                                          updateContractController.contractRes
                                                  .value.host?.name ??
                                              '',
                                          style: const TextStyle(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider()
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Đại diện bên thuê",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      backgroundColor: Theme.of(context)
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
                                        () => Text(
                                          // updateContractController.listRenterChoose
                                          //             .map((e) => e.isRepresent)
                                          //             .contains(true) ==
                                          //         true
                                          //     ? "${updateContractController.listRenterChoose.where((e) => e.isRepresent == true).toList()[0].name ?? ""}"
                                          //     : 'chọn đại diện',
                                          (updateContractController.contractRes
                                                          .value.listRenter ??
                                                      [])
                                                  .where((e) =>
                                                      e.isRepresent == true)
                                                  .toList()
                                                  .isEmpty
                                              ? Renter().name ??
                                                  'Chưa có thông tin'
                                              : updateContractController
                                                      .contractRes
                                                      .value
                                                      .listRenter
                                                      ?.where((e) =>
                                                          e.isRepresent == true)
                                                      .toList()[0]
                                                      .name ??
                                                  '',
                                          style: const TextStyle(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider()
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phòng đã chọn",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      backgroundColor: Theme.of(context)
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
                                        () => Text(
                                          updateContractController.contractRes
                                                  .value.motelRoom?.motelName ??
                                              "",
                                          style: const TextStyle(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider()
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Thời hạn *",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      backgroundColor: Theme.of(context)
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
                                            updateContractController
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
                                      ),
                                    ),
                                    Expanded(
                                      child: InfoInputTextField(
                                        textEditingController:
                                            updateContractController
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
                                        onTap: () {},
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
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InfoInputTextField(
                                  textEditingController:
                                      updateContractController
                                          .dateBeginMoneyEdit,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                  hintText: "Chọn ngày",
                                  icon: const Icon(Icons.calendar_today_sharp),
                                  onTap: () {},
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
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() => updateContractController
                                                    .contractRes
                                                    .value
                                                    .paymentSpace ==
                                                1
                                            ? const Text(
                                                "1 Tháng",
                                              )
                                            : updateContractController
                                                        .contractRes
                                                        .value
                                                        .paymentSpace ==
                                                    2
                                                ? const Text(
                                                    "2 Tháng",
                                                  )
                                                : updateContractController
                                                            .contractRes
                                                            .value
                                                            .paymentSpace ==
                                                        3
                                                    ? const Text(
                                                        "3 Tháng",
                                                      )
                                                    : updateContractController
                                                                .contractRes
                                                                .value
                                                                .paymentSpace ==
                                                            4
                                                        ? const Text(
                                                            "4 Tháng",
                                                          )
                                                        : updateContractController
                                                                    .contractRes
                                                                    .value
                                                                    .paymentSpace ==
                                                                5
                                                            ? const Text(
                                                                "5 Tháng",
                                                              )
                                                            : updateContractController
                                                                        .contractRes
                                                                        .value
                                                                        .paymentSpace ==
                                                                    6
                                                                ? const Text(
                                                                    "6 Tháng",
                                                                  )
                                                                : updateContractController
                                                                            .contractRes
                                                                            .value
                                                                            .paymentSpace ==
                                                                        7
                                                                    ? const Text(
                                                                        "7",
                                                                      )
                                                                    : updateContractController.contractRes.value.paymentSpace ==
                                                                            8
                                                                        ? const Text(
                                                                            "8 Tháng",
                                                                          )
                                                                        : updateContractController.contractRes.value.paymentSpace == 9
                                                                            ? const Text(
                                                                                "9 Tháng",
                                                                              )
                                                                            : updateContractController.contractRes.value.paymentSpace == 10
                                                                                ? const Text(
                                                                                    "10 Tháng",
                                                                                  )
                                                                                : updateContractController.contractRes.value.paymentSpace == 11
                                                                                    ? const Text(
                                                                                        "11 Tháng",
                                                                                      )
                                                                                    : updateContractController.contractRes.value.paymentSpace == 12
                                                                                        ? const Text(
                                                                                            "12 Tháng",
                                                                                          )
                                                                                        : Container()),
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
                            readOnly: true,
                            withAsterisk: true,
                            controller: updateContractController
                                .moneyRoomMonthAgentEdit,
                            textInputType: TextInputType.number,
                            inputFormatters: [ThousandsFormatter()],
                            onChanged: (v) {},
                            validator: (value) {
                              if ((value ?? '').isEmpty) {
                                return 'Không được để trống';
                              }
                              return null;
                            },
                            labelText: "Tiền phòng",
                            hintText: "Nhập tiền phòng 1 tháng",
                          ),
                          const Divider(),
                          SahaTextFieldNoBorder(
                            readOnly: true,
                            withAsterisk: true,
                            controller: updateContractController
                                .depositMoneyMonthAgentEdit,
                            textInputType: TextInputType.number,
                            inputFormatters: [ThousandsFormatter()],
                            onChanged: (v) {},
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/icon_contract/phi-dich-vu.png',
                                  width: Get.width / 4,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add))
                              ],
                            ),
                          ),
                          Obx(
                            () => (updateContractController
                                            .contractRes.value.moServices ??
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
                                            ...(updateContractController
                                                        .contractRes
                                                        .value
                                                        .moServices ??
                                                    [])
                                                .map((e) {
                                              return itemService(
                                                  value:
                                                      (updateContractController
                                                                  .contractRes
                                                                  .value
                                                                  .moServices ??
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
                          Column(
                            children: [
                              ...(updateContractController
                                          .contractRes.value.moServices ??
                                      [])
                                  .map((e) => oldQuantity(e))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/icon_contract/noi-that.png',
                                  width: Get.width / 4,
                                ),
                              ],
                            ),
                          ),
                          Obx(
                            () => (updateContractController
                                            .contractRes.value.furniture ??
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
                                        ...(updateContractController.contractRes
                                                    .value.furniture ??
                                                [])
                                            .map((e) => itemFurniture(
                                                e,
                                                (updateContractController
                                                            .contractRes
                                                            .value
                                                            .furniture ??
                                                        [])
                                                    .indexOf(e)))
                                      ],
                                    ),
                                  ),
                          ),
                          SahaDivide(),
                          Container(
                            padding: const EdgeInsets.all(
                              10,
                            ),
                            child: Obx(
                              () => Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icon_contract/nguoi-thue.png',
                                        width: Get.width / 4,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ...updateContractController
                                      .contractRes.value.listRenter!
                                      .map((v) {
                                    return itemRenter(
                                      renter: v,
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ),
                          SahaDivide(),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SelectImages(
                                type: CONTRACT_FILES_FOLDER,
                                maxImage: 10,
                                title: 'Ảnh hợp đồng',
                                subTitle: 'Tối đa 10 hình',
                                onUpload: () {},
                                images: updateContractController.listImages
                                    .toList(),
                                doneUpload: (List<ImageData> listImages) {},
                              ),
                            ),
                          ),
                          if (updateContractController
                                  .contractRes.value.status !=
                              0)
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ảnh thanh toán',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Wrap(
                                      children: [
                                        ...(updateContractController.contractRes
                                                    .value.imagesDeposit ??
                                                [])
                                            .map((e) => imagesPayment(e))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          SahaTextFieldNoBorder(
                            controller: updateContractController.noteEdit,
                            textInputType: TextInputType.text,
                            onChanged: (v) {},
                            labelText: "Ghi chú",
                            hintText: "Nhập ghi chú",
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
          ),
          bottomNavigationBar: Obx(() =>
                  // updateContractController.contractRes.value.status == 0 ||
                  //         updateContractController.contractRes.value.status == 3
                  //     ?
                  updateContractController.isLoading.value == false ?
                  Row(
                    children: [
                      if(updateContractController.contractRes.value.status == 0)
                      Expanded(
                        child: Container(
                          height: 65,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SahaButtonFullParent(
                                text: 'Thanh toán',
                                onPressed: () {
                                  if (isRepresent()) {
                                    Get.to(() => ContractPaymentScreen(
                                              contract: updateContractController
                                                  .contractRes.value,
                                            ))!
                                        .then((value) =>
                                            updateContractController
                                                .getContract());
                                  } else {
                                    SahaAlert.showError(
                                        message:
                                            'Bạn không phải người đại diện');
                                  }
                                },
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                         if(updateContractController.contractRes.value.status == 2)
                      Expanded(
                        child: Container(
                          height: 65,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SahaButtonFullParent(
                                text: 'Yêu cầu gia hạn',
                                onPressed: () {
                                   showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Center(
                                          child: Text(
                                            "Yêu cầu gia hạn hợp đồng",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                        content: SizedBox(
                                          width: Get.width,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                            const Text("Bạn muốn gia hạn hợp đồng chứ?",textAlign: TextAlign.center,),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                10),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Theme.of(context)
                                                                    .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: const Center(
                                                            child: Text(
                                                          'Suy nghĩ lại',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                10),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Theme.of(context)
                                                                    .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: const Center(
                                                            child: Text(
                                                          'Gửi',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 65,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SahaButtonFullParent(
                                text: 'Yêu cầu chỉnh sửa',
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Nội dung chỉnh sửa",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        content: SizedBox(
                                          width: Get.width,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                               // margin: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 6,
                                                      offset: const Offset(1,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: SahaTextFieldNoBorder(
                                                  enabled: true,
                                                  controller:
                                                      updateContractController
                                                          .noteEditRequest,
                                                  onChanged: (v) {},
                                                  textInputType:
                                                      TextInputType.multiline,
                                                  maxLine: 5,
                                                  labelText: "Nội dung",
                                                  hintText: "Nhập nội dung chỉnh sửa",
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                10),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Theme.of(context)
                                                                    .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: const Center(
                                                            child: Text(
                                                          'Đóng',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                10),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Theme.of(context)
                                                                    .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: const Center(
                                                            child: Text(
                                                          'Gửi',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              : Container(
                  height: 1,
                )
              )),
    );
  }

  Widget itemRenter({required Renter renter}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          const SahaEmptyAvata(
            height: 40,
            width: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              updateContractController.contractRes.value.listRenter!.isNotEmpty
                  ? renter.name ?? "Chưa đặt tên"
                  : "Thêm người cho thuê",
            ),
          ),
          if (renter.isRepresent == true)
            Text(
              'Đại diện',
              style: TextStyle(
                color: Theme.of(Get.context!).primaryColor,
              ),
            )
        ],
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
            height: 140,
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
          Positioned(
            right: -5,
            top: -5,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.clear_rounded,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isRepresent() {
    var listRenter = updateContractController.contractRes.value.listRenter;
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
                  (updateContractController.contractRes.value.imagesDeposit ??
                          [])
                      .toList(),
              index:
                  (updateContractController.contractRes.value.imagesDeposit ??
                          [])
                      .toList()
                      .indexOf(images));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: CachedNetworkImage(
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            imageUrl: images ?? '',
            //placeholder: (context, url) => SahaLoadingWidget(),
            errorWidget: (context, url, error) => const SahaEmptyImage(),
          ),
        ),
      ),
    );
  }

  Widget itemFurniture(Furniture furniture, int index) {
    return InkWell(
      onTap: () {},
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
            Text(furniture.quantity.toString())
          ],
        ),
      ),
    );
  }

  Widget oldQuantity(Service service) {
    var oldQuantityEdit = TextEditingController(
        text:
            service.oldQuantity == null ? '' : service.oldQuantity.toString());
    return service.typeUnit == 0
        ? SahaTextFieldNoBorder(
            readOnly: true,
            withAsterisk: true,
            controller: oldQuantityEdit,
            textInputType: TextInputType.number,
            inputFormatters: [ThousandsFormatter()],
            onChanged: (v) {},
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
