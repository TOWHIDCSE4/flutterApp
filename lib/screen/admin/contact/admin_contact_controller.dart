import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/contact.dart';

class AdminContactController extends GetxController {
  var adminContact = Contact().obs;
  var loadInit = true.obs;
  TextEditingController facebookController = TextEditingController();
  TextEditingController zaloController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  var bankAccountNumber = TextEditingController();
  var bankAccountName = TextEditingController();
  var bankName = TextEditingController();
  AdminContactController() {
    getContact();
  }

  Future<void> getContact() async {
    try {
      var res = await RepositoryManager.adminManageRepository.getAdminContact();
      adminContact.value = res!.data!;
      facebookController.text = adminContact.value.facebook ?? '';
      zaloController.text = adminContact.value.zalo ?? '';
      emailController.text = adminContact.value.email ?? '';
      phoneController.text = adminContact.value.phoneNumber ?? '';
      contentController.text = adminContact.value.content ?? '';
      addressController.text = adminContact.value.address ?? '';
      bankAccountName.text = adminContact.value.bankAccountName ?? '';
      bankAccountNumber.text = adminContact.value.bankAccountNumber ?? '';
      bankName.text = adminContact.value.bankName ?? '';
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateAdminContact() async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateAdminContact(contact: adminContact.value);
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
