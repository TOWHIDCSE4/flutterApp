import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/button/saha_button.dart';
import '../../../../components/divide/divide.dart';
import '../../../../components/text_field/text_field_no_border.dart';
import '../../../../components/widget/image_picker_single/image_picker_single.dart';
import '../../../../const/color.dart';
import '../../../../const/type_image.dart';
import '../../../../model/renter.dart';

class AddRenterScreen extends StatelessWidget {
  AddRenterScreen({super.key, required this.onSubmit, this.renterInput});
  final _formKey = GlobalKey<FormState>();
  Function onSubmit;
  var renterCallback = Renter().obs;
  Renter? renterInput;

  @override
  Widget build(BuildContext context) {
    var nameTextEditingController = TextEditingController(
        text: renterInput == null ? null : renterInput!.name);
    var phoneNumberTextEditingController = TextEditingController(
        text: renterInput == null ? null : renterInput!.phoneNumber);
    var emailTextEditingController = TextEditingController(
        text: renterInput == null ? null : renterInput!.email);
    var cmndNumberTextEditingController = TextEditingController(
        text: renterInput == null ? null : renterInput!.cmndNumber);
    var addressTextEditingController = TextEditingController(
        text: renterInput == null ? null : renterInput!.address);
    if (renterInput != null) {
      renterCallback.value = renterInput!;
    }
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
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
          title: const Text(
            "Người thuê",
          ),
          backgroundColor: primaryColor,
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: const Color(0xFFEF4355),
                text: renterInput == null ? 'Thêm người thuê' : "Sửa thông tin",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    onSubmit(renterCallback.value);
                    Get.back();
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
            child: Column(
              children: [
                SahaTextFieldNoBorder(
                  withAsterisk: true,
                  controller: nameTextEditingController,
                  onChanged: (v) {
                    renterCallback.value.name = v;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      SahaAlert.showError(message: "Chưa nhập họ tên");
                      return 'Không được để trống';
                    }
                    return null;
                  },
                  labelText: "Họ và tên",
                  hintText: "Nhập họ và tên",
                ),
                SahaDivide(),
                SahaTextFieldNoBorder(
                  withAsterisk: true,
                  textInputType: TextInputType.phone,
                  controller: phoneNumberTextEditingController,
                  onChanged: (v) {
                    renterCallback.value.phoneNumber = v;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      SahaAlert.showError(message: "Chưa nhập số điện thoại");
                      return 'Không được để trống';
                    }
                    return null;
                  },
                  labelText: "Số điện thoại",
                  hintText: "Nhập số điện thoại",
                ),
                SahaDivide(),
                SahaTextFieldNoBorder(
                  withAsterisk: false,
                  textInputType: TextInputType.emailAddress,
                  controller: emailTextEditingController,
                  onChanged: (v) {
                    renterCallback.value.email = v;
                  },
                  // validator: (value) {
                  //   if (value!.length == 0) {
                  //     return 'Không được để trống';
                  //   }
                  //   return null;
                  // },
                  labelText: "Email",
                  hintText: "Nhập email",
                ),
                SahaDivide(),
                SahaTextFieldNoBorder(
                  withAsterisk: true,
                  textInputType: TextInputType.number,
                  controller: cmndNumberTextEditingController,
                  onChanged: (v) {
                    renterCallback.value.cmndNumber = v;
                  },
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     SahaAlert.showError(message: "Chưa nhập số CMND/CCCD");
                  //     return 'Không được để trống';
                  //   }
                  //   return null;
                  // },
                  labelText: "Số CMND/CCCD",
                  hintText: "Nhập CMND/CCCD",
                ),
                // SahaDivide(),
                // SahaTextFieldNoBorder(
                //   withAsterisk: true,
                //   controller: addressTextEditingController,
                //   onChanged: (v) {
                //     renterCallback.value.address = v;
                //   },
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       SahaAlert.showError(message: "Chưa nhập địa chỉ");
                //       return 'Không được để trống';
                //     }
                //     return null;
                //   },
                //   labelText: "Địa chỉ",
                //   hintText: "Nhập địa chỉ,thành phố, quận huyện, phường xã",
                // ),
                SahaDivide(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text("CMND/CCCD mặt trước"),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Obx(
                            () => ImagePickerSingle(
                              type: RENTER_FILES_FOLDER,
                              width: Get.width / 3,
                              height: Get.width / 4,
                              linkLogo: renterCallback.value.cmndFrontImageUrl,
                              onChange: (link) {
                                print(link);
                                renterCallback.value.cmndFrontImageUrl = link;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("CMND/CCCD mặt sau"),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Obx(
                            () => ImagePickerSingle(
                              type: RENTER_FILES_FOLDER,
                              width: Get.width / 3,
                              height: Get.width / 4,
                              linkLogo: renterCallback.value.cmndBackImageUrl,
                              onChange: (link) {
                                print(link);
                                renterCallback.value.cmndBackImageUrl = link;
                              },
                            ),
                          ),
                        ),
                      ],
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
}
