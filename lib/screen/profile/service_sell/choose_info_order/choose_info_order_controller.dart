import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/data_app_controller.dart';

import '../../../../data/remote/response-request/service_sell/info_order_req.dart';
import '../../../../model/location_address.dart';

class ChooseInfoOrderController extends GetxController {
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;

  var infoOrder = InfoOrderReq().obs;

  TextEditingController nameEdit = TextEditingController();
  TextEditingController phoneEdit = TextEditingController();
  TextEditingController noteEdit = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController mailEdit = TextEditingController();
  DataAppController dataAppController = Get.find();

  InfoOrderReq? infoOrderReqInput;
  ChooseInfoOrderController({this.infoOrderReqInput}) {
    if (infoOrderReqInput?.phoneNumber != null) {
      infoOrder(infoOrderReqInput);
      nameEdit.text = infoOrder.value.name ?? "";
      phoneEdit.text = infoOrder.value.phoneNumber ?? "";
      noteEdit.text = infoOrder.value.note ?? "";
      mailEdit.text = infoOrder.value.email ?? "";
      addressTextEditingController.text = infoOrder.value.addressDetail == null
          ? ''
          : '${infoOrder.value.addressDetail ?? ''}-${infoOrder.value.wardsName ?? ''}-${infoOrder.value.districtName ?? ''}-${infoOrder.value.provinceName ?? ''}';
    } else {
      nameEdit.text = dataAppController.badge.value.user?.name ?? "";
      phoneEdit.text = dataAppController.badge.value.user?.phoneNumber ?? "";
      mailEdit.text = dataAppController.badge.value.user?.email ?? "";
    }
  }
}
