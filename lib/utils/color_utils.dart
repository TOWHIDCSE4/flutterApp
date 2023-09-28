import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SahaColorUtils {
  static final SahaColorUtils _singleton = SahaColorUtils._internal();

  SahaColorUtils._internal();

  factory SahaColorUtils() {
    return _singleton;
  }

  Color colorPrimaryTextWithWhiteBackground() {
   return Theme.of(Get.context!).primaryColor.computeLuminance()
        > 0.5 ? Colors.black : Theme.of(Get.context!).primaryColor;
  }

  Color colorTextWithPrimaryColor() {
    return Theme.of(Get.context!).primaryColor.computeLuminance()
        > 0.5 ? Colors.black : Colors.white;
  }

}
