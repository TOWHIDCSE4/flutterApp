import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/service_sell/info_order_req.dart';
import 'package:gohomy/utils/phone_number.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/button/saha_button.dart';
import '../../../../components/dialog/dialog.dart';
import '../../../../components/text_field/text_field_no_border.dart';
import 'choose_info_order_controller.dart';

class ChooseInfoOrderScreen extends StatelessWidget {
  Function confirm;

  InfoOrderReq? infoOrderReqInput;

  ChooseInfoOrderScreen({required this.confirm, this.infoOrderReqInput}) {
    chooseInfoOrderController =
        ChooseInfoOrderController(infoOrderReqInput: infoOrderReqInput);
  }

  late ChooseInfoOrderController chooseInfoOrderController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thông tin nhận hàng'),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SahaTextFieldNoBorder(
                withAsterisk: true,
                controller: chooseInfoOrderController.nameEdit,
                textInputType: TextInputType.name,
                onChanged: (v) {
                  // chooseInfoOrderController.infoOrder.value.name= v;
                },
                validator: (value) {
                  if ((value ??'').isEmpty) {
                    return 'Không được để trống';
                  }
                  return null;
                },
                labelText: "Họ và tên",
                hintText: "Nhập tên người nhận",
              ),
              const Divider(),
              SahaTextFieldNoBorder(
                withAsterisk: true,
                controller: chooseInfoOrderController.phoneEdit,
                textInputType: TextInputType.phone,
                onChanged: (v) {
                  //chooseInfoOrderController.infoOrder.value.phoneNumber= v;
                },
                validator: (value) {
                  if ((value ??'').isEmpty) {
                    return 'Không được để trống';
                  }
                  return PhoneNumberValid.validateMobile((value ??''));
                },
                labelText: "Số điện thoại",
                hintText: "Nhập SĐT người nhận",
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  SahaDialogApp.showDialogAddressChoose(
                    hideAll: true,
                    accept: () {},
                    callback: (v) {
                      chooseInfoOrderController.locationProvince.value = v;
                      Get.back();
                      SahaDialogApp.showDialogAddressChoose(
                        hideAll: true,
                        accept: () {},
                        idProvince:
                            chooseInfoOrderController.locationProvince.value.id,
                        callback: (v) {
                          chooseInfoOrderController.locationDistrict.value = v;
                          Get.back();
                          SahaDialogApp.showDialogAddressChoose(
                            hideAll: true,
                            accept: () {},
                            idDistrict: chooseInfoOrderController
                                .locationDistrict.value.id,
                            callback: (v) {
                              chooseInfoOrderController.locationWard.value = v;
                              Get.back();
                              SahaDialogApp.showDialogInputNote(
                                  height: 50,
                                  confirm: (v) {
                                    if (v == null || v == "") {
                                      SahaAlert.showToastMiddle(
                                          message:
                                              "Vui lòng nhập địa chỉ chi tiết");
                                    } else {
                                      chooseInfoOrderController
                                          .infoOrder.value.addressDetail = v;
                                      chooseInfoOrderController.infoOrder
                                          .refresh();
                                      var province = chooseInfoOrderController
                                          .locationProvince;
                                      chooseInfoOrderController.infoOrder.value
                                          .province = province.value.id;
                                      chooseInfoOrderController.infoOrder.value
                                          .provinceName = province.value.name;
                                      var district = chooseInfoOrderController
                                          .locationDistrict;
                                      chooseInfoOrderController.infoOrder.value
                                          .district = district.value.id;
                                      chooseInfoOrderController.infoOrder.value
                                          .districtName = district.value.name;
                                      var ward = chooseInfoOrderController
                                          .locationWard;
                                      chooseInfoOrderController.infoOrder.value
                                          .wards = ward.value.id;
                                      chooseInfoOrderController.infoOrder.value
                                          .wardsName = ward.value.name;
                                      chooseInfoOrderController
                                              .addressTextEditingController
                                              .text =
                                          "${chooseInfoOrderController.infoOrder.value.addressDetail} - ${ward.value.name} - ${district.value.name} - ${province.value.name}";
                                    }
                                  },
                                  title: "Địa chỉ chi tiết",
                                  textInput:
                                      chooseInfoOrderController.infoOrder.value.addressDetail ?? "");
                            },
                          );
                        },
                      );
                    },
                  );
                },
                child: SahaTextFieldNoBorder(
                  enabled: false,
                  labelText: "Địa chỉ",
                  textInputType: TextInputType.text,
                  controller:
                      chooseInfoOrderController.addressTextEditingController,
                  withAsterisk: true,
                  onChanged: (v) {
                    //addPostController.postReq.value.name = v;
                  },
                  hintText: "Chọn địa chỉ",
                ),
              ),
              const Divider(),
              SahaTextFieldNoBorder(
                withAsterisk: false,
                controller: chooseInfoOrderController.mailEdit,
                textInputType: TextInputType.emailAddress,
                onChanged: (v) {
                  //chooseInfoOrderController.infoOrder.value.note = v;
                },
                validator: (value) {
                  if ((value ??'').isEmpty) {
                    return 'Không được để trống';
                  }
                  return null;
                },
                labelText: "Email",
                hintText: "Nhập email",
              ),
              const Divider(),
              SahaTextFieldNoBorder(
                withAsterisk: false,
                controller: chooseInfoOrderController.noteEdit,
                textInputType: TextInputType.text,
                onChanged: (v) {
                  //chooseInfoOrderController.infoOrder.value.note = v;
                },
                validator: (value) {
                  if ((value ??'').isEmpty) {
                    return 'Không được để trống';
                  }
                  return null;
                },
                labelText: "Lưu ý",
                hintText: "Nhập lưu ý",
              ),
              const Divider(),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                text: 'Xác nhận',
                onPressed: () {
                  chooseInfoOrderController.infoOrder.value.name =
                      chooseInfoOrderController.nameEdit.text;
                  chooseInfoOrderController.infoOrder.value.phoneNumber =
                      chooseInfoOrderController.phoneEdit.text;
                  chooseInfoOrderController.infoOrder.value.note =
                      chooseInfoOrderController.noteEdit.text;
                  chooseInfoOrderController.infoOrder.value.email =
                      chooseInfoOrderController.mailEdit.text;
                  confirm(chooseInfoOrderController.infoOrder.value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
