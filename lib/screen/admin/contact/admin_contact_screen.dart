import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/components/text_field/sahashopTextField.dart';
import 'package:gohomy/screen/admin/contact/admin_contact_controller.dart';

import '../../../components/button/saha_button.dart';
import 'package:get/get.dart';

class AdminContactScreen extends StatefulWidget {
  const AdminContactScreen({Key? key}) : super(key: key);

  @override
  State<AdminContactScreen> createState() => _AdminContactScreenState();
}

class _AdminContactScreenState extends State<AdminContactScreen> {
  AdminContactController adminContactController = AdminContactController();
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
                  // begin: Alignment.bottomLeft,
                  // end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
          title: const Text('Thông tin liên lạc'),
        ),
        body: Obx(
          () => adminContactController.loadInit.value
              ? SahaLoadingFullScreen()
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SahaTextField(
                          labelText: 'Facebook',
                          hintText: "Nhập facebook",
                          controller: adminContactController.facebookController,
                          onChanged: (v) {
                            adminContactController.adminContact.value.facebook =
                                v;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SahaTextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputType: TextInputType.number,
                          labelText: 'Zalo',
                          hintText: "Nhập zalo",
                          controller: adminContactController.zaloController,
                          onChanged: (v) {
                            adminContactController.adminContact.value.zalo = v;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SahaTextField(
                          labelText: 'Email',
                          hintText: "Nhập email",
                          controller: adminContactController.emailController,
                          onChanged: (v) {
                            adminContactController.adminContact.value.email = v;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SahaTextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputType: TextInputType.number,
                          labelText: 'Số điện thoại',
                          hintText: " Nhập số điện thoại",
                          controller: adminContactController.phoneController,
                          onChanged: (v) {
                            adminContactController
                                .adminContact.value.phoneNumber = v;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SahaTextField(
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          // textInputType: TextInputType.number,
                          labelText: 'Số tài khoản ngân hàng',
                          hintText: " Nhập số tài khoản ngân hàng",
                          controller: adminContactController.bankAccountNumber,
                          onChanged: (v) {
                            adminContactController
                                .adminContact.value.bankAccountNumber = v;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SahaTextField(
                          labelText: 'Tên ngân hàng',
                          hintText: " Nhập tên ngân hàng",
                          controller: adminContactController.bankName,
                          onChanged: (v) {
                            adminContactController.adminContact.value.bankName =
                                v;
                          },
                        ),
                        SahaTextField(
                          labelText: 'Tên người thụ hưởng',
                          hintText: " Nhập tên người thụ hưởng",
                          controller: adminContactController.bankAccountName,
                          onChanged: (v) {
                            adminContactController
                                .adminContact.value.bankAccountName = v;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                text: 'Cập nhật thông tin',
                onPressed: () {
                  adminContactController.updateAdminContact();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
