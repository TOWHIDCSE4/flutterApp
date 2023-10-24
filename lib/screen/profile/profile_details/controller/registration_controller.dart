import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/sp_const.dart';
import 'package:gohomy/data/repository/handle_error.dart';
import 'package:gohomy/screen/profile/profile_details/personal_information/success_profile_page.dart';
import '../../../../data/remote/saha_service_manager.dart';
import '../../../../utils/sp_utils.dart';
import '../repository/image_repository.dart';

class RegistrationController extends GetxController {
  var scannedFrontCardText = ''.obs;
  var scannedBackCardText = ''.obs;

  var idType = IdCardType.peopleID.obs;
  var name = ''.obs;
  var dateOfBirth = ''.obs;
  var idNumber = ''.obs;
  var createdDate = 'Not found!'.obs;
  var createdLocation = 'Not found!'.obs;
  var sex = ''.obs;
  var profileImagePath = ''.obs;
  var frontCardImagePath = ''.obs;
  var backCardImagePath = ''.obs;

  var address = ''.obs;
  var phone = ''.obs;
  var email = ''.obs;
  var job = ''.obs;

  var responseMsg = ''.obs;
  ImageRepository imageRepository = ImageRepository.instance;
  RegistrationController();

  void getAllValuesForRegistration() {
    bool isPeopleId = idType.value == IdCardType.peopleID;

    //::::::::::::::::::::::::::: NAME ::::::::::::::::::::::::::
    name.value = scrapeDataFromRecognisedText(
      start: isPeopleId ? 'tên' : 'name',
      end: isPeopleId ? 'Sin' : 'Ngày',
    );

    //:::::::::::::::::::::: DATE OF BIRTH ::::::::::::::::::::::
    String dob = scrapeDataFromRecognisedText(
      start: isPeopleId ? 'ngày' : 'birth',
      end: isPeopleId ? 'Nguyên' : 'Giói',
    );
    dateOfBirth.value =
        dob.toLowerCase().contains('not found!') ? 'dd/mm/yyyy' : dob;

    //::::::::::::::::::::::::: ID NUMBER :::::::::::::::::::::::
    idNumber.value = scrapeDataFromRecognisedText(
      start: isPeopleId ? 'sỐ' : 'No',
      end: isPeopleId ? 'Họ' : 'Họ',
    );

    //:::::::::::::::::::::: CREATED DATE :::::::::::::::::::::::
    String createdDateStr = scrapeDataFromRecognisedText(
      idCardSide: IdCardSide.back,
      start: isPeopleId ? 'Ngày' : 'year',
      end: isPeopleId ? 'GIÁM' : 'DIRECTOR',
    );
    final intInStr = RegExp(r'\d+');
    var res = intInStr.allMatches(createdDateStr).map((m) => m.group(0));
    String crDate = res
        .toString()
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll(",", "/");
    createdDate.value = crDate.isEmpty ? "dd/mm/yyyy" : crDate;

    //::::::::::::::::::::::: CREATED LOCATION ::::::::::::::::::
    if (idType.value == IdCardType.peopleID) {
      String originalString = scannedBackCardText.value;
      int startIndex = originalString.indexOf("GIÁM ĐỐC CA");
      if (startIndex != -1) {
        String extractedText = originalString
            .substring(startIndex)
            .replaceAll('GIÁM ĐỐC CA', '')
            .replaceAll(':', '')
            .replaceAll('.', '')
            .replaceAll('\n', '');
        createdLocation.value = extractedText;
      }
    } else {
      String location = scrapeDataFromRecognisedText(
        idCardSide: IdCardSide.back,
        start: 'CẢNH SÁT',
        end: 'DIRECTOR',
      );
      createdLocation.value =
        location.toLowerCase().contains('not found!') ? 'Noi cap' : location;
    }

    //:::::::::::::::::::::::::::::: SEX ::::::::::::::::::::::::
    //ONLY FOR CITIZEN ID
    sex.value = scrapeDataFromRecognisedText(
      start: 'Sex',
      end: 'Quốc',
    );
  }

  String scrapeDataFromRecognisedText({
    required String start,
    required String end,
    IdCardSide idCardSide = IdCardSide.front,
  }) {
    String data = 'Not found!';
    try {
      String result = imageRepository.filterIdCardText(
        ocrText: idCardSide == IdCardSide.front
            ? scannedFrontCardText.value
            : scannedBackCardText.value,
        start: start,
        end: end,
      );
      data = result;
      return data;
    } catch (e) {
      log(e.toString());
      return data;
    }
  }

  Future<void> renterOrMasterRegistration({required bool isRenter}) async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    var sexValue = sex.value == 'Nam' ? '1' : '2';
    Map<String, dynamic> body = {
      'name': name.value,
      'email': email.value,
      'phone_number': phone.value,
      'address': address.value,
      'cmnd_number': idNumber.value,
      'date_of_birth': dateOfBirth.value,
      'date_range': createdDate.value,
      'sex': idType.value == IdCardType.peopleID ? null : sexValue,
      'job': '',
      "cmnd_front_image_url": frontCardImagePath.value == ''
          ? null
          : await dio.MultipartFile.fromFile(frontCardImagePath.value),
      "cmnd_back_image_url": backCardImagePath.value == ''
          ? null
          : await dio.MultipartFile.fromFile(backCardImagePath.value),
      "image_url": profileImagePath.value == ''
          ? null
          : await dio.MultipartFile.fromFile(profileImagePath.value),
    };
    try {
      isRenter
          ? await SahaServiceManager().service?.renterRegistration(body)
          : await SahaServiceManager().service?.masterRegistration(body);
      // responseMsg.value = res.msg!;
      Get.back();
      // SahaAlert.showSuccess(message: res.msg!);
      await SharedPref.saveStringValueToSp(SpConstants.kycUserName, name.value);
      await SharedPref.saveStringValueToSp(SpConstants.kycUserImage, profileImagePath.value);
      await SharedPref.saveBoolValueToSp(SpConstants.kycRegSuccessStatus, true);
      Get.to(() => const SuccessProfilePage());
    } catch (err) {
      Get.back();
      // handleError('xảy ra lỗi');
      SahaAlert.showError(message: 'đầu vào không đúng');
    }
    // var res = await SahaServiceManager().service!.renterRegistration(body);
    // if (res.code == 200) {
    //   log('dad');
    //   Get.back();
    //   SahaAlert.showSuccess(message: res.msg!);
    //   Get.to(() => const SuccessProfilePage());
    // } else {
    //   log('mom');
    //   // Get.back();
    //   // handleError(res.msg);
    //   SahaAlert.showError(message: res.msg);
    // }
  }
}

enum IdCardType {
  peopleID,
  citizenId,
}

enum IdCardSide {
  front,
  back,
}
