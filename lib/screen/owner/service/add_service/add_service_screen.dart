import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/text_field/text_field_no_border.dart';
import 'package:gohomy/model/service.dart';

import '../../../../components/button/saha_button.dart';
import 'add_service_controller.dart';

class AddServiceScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  late AddServiceController addServiceController;
  Service? serviceInput;
  bool? isFromMotelManage;
  Function? onSubmit;

  AddServiceScreen({this.serviceInput, this.isFromMotelManage, this.onSubmit}) {
    addServiceController = AddServiceController(serviceInput: serviceInput);
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
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Dịch vụ",
          ),
          backgroundColor: const Color(0xFFEF4355),
          actions: serviceInput == null
              ? null
              : [
                  IconButton(
                      onPressed: () {
                        SahaDialogApp.showDialogYesNo(
                            mess: 'Bạn có chắc chắn muốn xoá dịch vụ này chứ ?',
                            onOK: () {
                              addServiceController.deleteService(
                                  serviceId: serviceInput!.id!);
                            });
                      },
                      icon: const Icon(Icons.delete))
                ],
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: const Color(0xFFEF4355),
                text:
                    serviceInput != null ? 'Cập nhật dịch vụ' : 'Thêm dịch vụ',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (serviceInput != null) {
                      if (isFromMotelManage == true) {
                        addServiceController.serviceRequest.value.uuid =
                            onSubmit!(
                                addServiceController.serviceRequest.value);
                        Get.back();
                      } else {
                        addServiceController.updateService();
                      }
                    } else {
                      if (isFromMotelManage == true) {
                        onSubmit!(addServiceController.serviceRequest.value);
                        Get.back();
                      } else {
                        addServiceController.addService();
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              child: Column(
                children: [
                  SahaTextFieldNoBorder(
                    withAsterisk: true,
                    controller:
                        addServiceController.serviceTextEditingController,
                    onChanged: (value) {
                      addServiceController.serviceRequest.value.serviceName =
                          value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Dịch vụ",
                    hintText: "Nhập tên dịch vụ",
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      SahaDialogApp.showDialogServiceType(
                        onChoose: (v) {
                          addServiceController.serviceRequest.value.typeUnit =
                              v;
                          addServiceController.serviceRequest.value
                              .serviceUnit = convertServiceType(v);

                          addServiceController.serviceRequest.refresh();
                          addServiceController.typeTextEditingController.text =
                              convertServiceType(v);

                          if (v == 0) {
                            addServiceController
                                .serviceRequest.value.serviceUnit = null;
                            addServiceController
                                .unitTextEditingController.text = '';
                          }
                        },
                      );
                    },
                    child: SahaTextFieldNoBorder(
                      onTap: () {
                        SahaDialogApp.showDialogServiceType(
                          onChoose: (v) {
                            addServiceController.serviceRequest.value.typeUnit =
                                v;
                            addServiceController.serviceRequest.value
                                .serviceUnit = convertServiceType(v);

                            addServiceController.serviceRequest.refresh();
                            addServiceController.typeTextEditingController
                                .text = convertServiceType(v);

                            if (v == 0) {
                              addServiceController
                                  .serviceRequest.value.serviceUnit = null;
                              addServiceController
                                  .unitTextEditingController.text = '';
                            }
                          },
                        );
                      },
                      //enabled: false,
                      readOnly: true,
                      controller:
                          addServiceController.typeTextEditingController,
                      onChanged: (v) {
                        addServiceController.serviceRequest.value.serviceUnit =
                            v;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          // showDialog<String>(
                          //   context: context,
                          //   builder: (BuildContext context) => AlertDialog(
                          //     title: const Text('AlertDialog Title'),
                          //     content: const Text('AlertDialog description'),
                          //     actions: <Widget>[
                          //       TextButton(
                          //         onPressed: () => Navigator.pop(context, 'OK'),
                          //         child: const Text('OK'),
                          //       ),
                          //     ],
                          //   ),
                          // );
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      withAsterisk: true,
                      labelText: 'Thu phí dựa trên',
                      hintText:
                          "Theo chỉ số, người, số lượng, phòng, số lần,...",
                    ),
                  ),
                  const Divider(),
                  Obx(() =>
                      addServiceController.serviceRequest.value.typeUnit == 0
                          ? SahaTextFieldNoBorder(
                              controller: addServiceController
                                  .unitTextEditingController,
                              onChanged: (v) {
                                addServiceController
                                    .serviceRequest.value.serviceUnit = v;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Không được để trống';
                                }
                                return null;
                              },
                              withAsterisk: true,
                              labelText: 'Đơn vị đo',
                              hintText: "Nhập (Vd: Kwh, m3...)",
                            )
                          : Container()),
                  Obx(() =>
                      addServiceController.serviceRequest.value.typeUnit == 0
                          ? const Divider()
                          : Container()),
                  Obx(
                    () => SahaTextFieldNoBorder(
                      controller:
                          addServiceController.chargeTextEditingController,
                      textInputType: TextInputType.number,
                      onChanged: (v) {
                        addServiceController.serviceRequest.value
                            .serviceCharge = double.tryParse(v ?? '') ?? 0;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      withAsterisk: true,
                      labelText: "Phí dịch vụ",
                      hintText: "Nhập phí",
                      suffixText: addServiceController
                                  .serviceRequest.value.typeUnit ==
                              0
                          ? ""
                          : "/${convertServiceType(addServiceController.serviceRequest.value.typeUnit ?? 0)}/Tháng",
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      SahaDialogApp.showDialogServiceIcon(
                        onChoose: (icon) {
                          addServiceController
                              .serviceRequest.value.serviceIcon = icon;
                          addServiceController.serviceRequest.refresh();
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 20,
                        right: 20,
                      ),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Icon dịch vụ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                              ),
                            ),
                            Obx(
                              () => addServiceController
                                          .serviceRequest.value.serviceIcon ==
                                      "assets/icon_images/dien.png"
                                  ? Image.asset(
                                      "assets/icon_images/dien.png",
                                      width: 25,
                                      height: 25,
                                    )
                                  : addServiceController.serviceRequest.value
                                              .serviceIcon ==
                                          "assets/icon_images/bao-ve.png"
                                      ? Image.asset(
                                          "assets/icon_images/bao-ve.png",
                                          width: 25,
                                          height: 25,
                                        )
                                      : addServiceController.serviceRequest
                                                  .value.serviceIcon ==
                                              "assets/icon_images/gui-xe.png"
                                          ? Image.asset(
                                              "assets/icon_images/gui-xe.png",
                                              width: 25,
                                              height: 25,
                                            )
                                          : addServiceController.serviceRequest
                                                      .value.serviceIcon ==
                                                  "assets/icon_images/nuoc.png"
                                              ? Image.asset(
                                                  "assets/icon_images/nuoc.png",
                                                  width: 25,
                                                  height: 25,
                                                )
                                              : addServiceController
                                                          .serviceRequest
                                                          .value
                                                          .serviceIcon ==
                                                      "assets/icon_images/thang-may.png"
                                                  ? Image.asset(
                                                      "assets/icon_images/thang-may.png",
                                                      width: 25,
                                                      height: 25,
                                                    )
                                                  : addServiceController
                                                              .serviceRequest
                                                              .value
                                                              .serviceIcon ==
                                                          "assets/icon_images/ra-vao-van-tay.png"
                                                      ? Image.asset(
                                                          "assets/icon_images/ra-vao-van-tay.png",
                                                          width: 25,
                                                          height: 25,
                                                        )
                                                      : addServiceController
                                                                  .serviceRequest
                                                                  .value
                                                                  .serviceIcon ==
                                                              "assets/icon_images/ve-sinh.png"
                                                          ? Image.asset(
                                                              "assets/icon_images/ve-sinh.png",
                                                              width: 25,
                                                              height: 25,
                                                            )
                                                          : addServiceController
                                                                      .serviceRequest
                                                                      .value
                                                                      .serviceIcon ==
                                                                  "assets/icon_images/icon-mang.png"
                                                              ? Image.asset(
                                                                  "assets/icon_images/icon-mang.png",
                                                                  width: 25,
                                                                  height: 25,
                                                                )
                                                              // : addServiceController
                                                              //             .serviceRequest
                                                              //             .value
                                                              //             .serviceIcon ==
                                                              //         "assets/icon_service/repair.svg"
                                                              //     ? SvgPicture
                                                              //         .asset(
                                                              //         "assets/icon_service/repair.svg",
                                                              //         width: 25,
                                                              //         height: 25,
                                                              //       )
                                                              //     : addServiceController
                                                              //                 .serviceRequest
                                                              //                 .value
                                                              //                 .serviceIcon ==
                                                              //             "assets/icon_service/delivery.svg"
                                                              //         ? SvgPicture.asset(
                                                              //             "assets/icon_service/delivery.svg",
                                                              //             width: 25,
                                                              //             height:
                                                              //                 25,
                                                              //           )
                                                              //         : addServiceController.serviceRequest.value.serviceIcon == "assets/icon_service/elevator.svg"
                                                              //             ? SvgPicture.asset(
                                                              //                 "assets/icon_service/elevator.svg",
                                                              //                 width:
                                                              //                     25,
                                                              //                 height:
                                                              //                     25,
                                                              //               )
                                                              : Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset:
                              const Offset(1, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SahaTextFieldNoBorder(
                      enabled: true,
                      controller:
                          addServiceController.noteTextEditingController,
                      onChanged: (v) {
                        addServiceController.serviceRequest.value.note = v;
                      },
                      textInputType: TextInputType.multiline,
                      maxLine: 5,
                      labelText: "Ghi chú",
                      hintText: "Nhập ghi chú",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}

String convertServiceType(int type) {
  return type == 0
      ? 'Theo chỉ số'
      : type == 1
          ? 'Người hoặc số lượng'
          : type == 2
              ? 'Phòng'
              : 'Số lần sử dụng';
}
