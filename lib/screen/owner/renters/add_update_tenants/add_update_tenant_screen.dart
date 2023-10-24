import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/divide/divide.dart';
import 'package:gohomy/components/text_field/text_field_no_border.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/model/renter.dart';
import 'package:gohomy/screen/owner/renters/renter_controller.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/button/saha_button.dart';
import '../../../../components/dialog/dialog.dart';
import '../../../../components/widget/image_picker_single/image_picker_single.dart';
import '../../../../const/type_image.dart';
import 'add_update_tenant_controller.dart';

class AddUpdateTenantScreen extends StatelessWidget {
  late AddUpdateTenantController addUpdateTenantController;
  ListTenantsController listTenantsController = ListTenantsController();
  Renter? tenantInput;
  bool? ignoring;
  int? status;
  final _formKey = GlobalKey<FormState>();

  Function? onSubmit;

  AddUpdateTenantScreen(
      {this.tenantInput, this.status, this.ignoring, this.onSubmit}) {
    addUpdateTenantController =
        AddUpdateTenantController(renterInput: tenantInput, status: status);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
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
          title: const Text(
            "Người thuê",
          ),
          actions: [
            addUpdateTenantController.status == 0
                ? GestureDetector(
                    onTap: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: "Bạn có chắc muốn xoá người thuê này",
                          onClose: () {},
                          onOK: () async {
                            listTenantsController.deleteTenants(
                                tenantsId:
                                    addUpdateTenantController.renterInput!.id!);
                          });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: const Icon(
                        FontAwesomeIcons.trashCan,
                      ),
                    ),
                  )
                : Container(),
          ],
          backgroundColor: primaryColor,
        ),
        bottomNavigationBar: ignoring == true
            ? const SizedBox()
            : SizedBox(
                height: 65,
                child: Column(
                  children: [
                    SahaButtonFullParent(
                      color: Theme.of(context).primaryColor,
                      text: tenantInput != null
                          ? 'Cập nhật người thuê'
                          : 'Thêm người thuê',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (tenantInput != null) {
                            addUpdateTenantController.updateTenant();
                          } else {
                            addUpdateTenantController.addTenant();
                            //onSubmit!(addUpdateTenantController.renterRequest);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
        body: IgnorePointer(
          ignoring: ignoring == null ? false : ignoring!,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SahaTextFieldNoBorder(
                    withAsterisk: true,
                    controller:
                        addUpdateTenantController.nameTextEditingController,
                    onChanged: (v) {
                      addUpdateTenantController.renterRequest.value.name = v;
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
                    controller: addUpdateTenantController
                        .phoneNumberTextEditingController,
                    onChanged: (v) {
                      addUpdateTenantController
                          .renterRequest.value.phoneNumber = v;
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
                    controller:
                        addUpdateTenantController.emailTextEditingController,
                    onChanged: (v) {
                      addUpdateTenantController.renterRequest.value.email = v;
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
                    controller: addUpdateTenantController
                        .cmndNumberTextEditingController,
                    onChanged: (v) {
                      addUpdateTenantController.renterRequest.value.cmndNumber =
                          v;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        SahaAlert.showError(message: "Chưa nhập số CMND/CCCD");
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Số CMND/CCCD",
                    hintText: "Nhập CMND/CCCD",
                  ),
                  SahaDivide(),
                  SahaTextFieldNoBorder(
                    withAsterisk: true,
                    controller:
                        addUpdateTenantController.addressTextEditingController,
                    onChanged: (v) {
                      addUpdateTenantController.renterRequest.value.address = v;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        SahaAlert.showError(message: "Chưa nhập địa chỉ");
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Địa chỉ",
                    hintText: "Nhập địa chỉ,thành phố, quận huyện, phường xã",
                  ),
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
                                linkLogo: addUpdateTenantController
                                    .renterRequest.value.cmndFrontImageUrl,
                                onChange: (link) {
                                  print(link);
                                  addUpdateTenantController.renterRequest.value
                                      .cmndFrontImageUrl = link;
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
                                linkLogo: addUpdateTenantController
                                    .renterRequest.value.cmndBackImageUrl,
                                onChange: (link) {
                                  print(link);
                                  addUpdateTenantController.renterRequest.value
                                      .cmndBackImageUrl = link;
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
      ),
    );
  }
}
