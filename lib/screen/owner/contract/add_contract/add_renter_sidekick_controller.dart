import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../model/motel_room.dart';
import '../../../../model/renter.dart';
import '../../../../model/tower.dart';
import '../../../../utils/string_utils.dart';

class AddRenterSideKickController extends GetxController{
    var nameTower = TextEditingController();
  var roomName = TextEditingController();
  var priceExpected = TextEditingController();
  var intendTimeHire = TextEditingController();
  var intendDayHire = TextEditingController();

  var name = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();

  Tower? towerSelected;
  MotelRoom? motelRoomSelected;
   var renterReq = Renter().obs;
   Renter renterInput;
   AddRenterSideKickController({required this.renterInput}){
    renterReq.value = renterInput;
    convertInfo();
   }

   void convertInfo() {
    towerSelected = Tower(id: renterReq.value.towerId);
    motelRoomSelected = MotelRoom(id: renterReq.value.motelId);
    nameTower.text = renterReq.value.nameTowerExpected ?? '';
    roomName.text = renterReq.value.motelName ?? '';
    priceExpected.text = renterReq.value.priceExpected == null
        ? ''
        : '${SahaStringUtils().convertToUnit(renterReq.value.priceExpected)}';
    intendTimeHire.text = renterReq.value.estimateRentalPeriod ?? '';
    intendDayHire.text = renterReq.value.estimateRentalDate == null
        ? ""
        : DateFormat('dd-MM-yyyy').format(renterReq.value.estimateRentalDate!);
    name.text = renterReq.value.name ?? '';
    phone.text = renterReq.value.phoneNumber ?? '';
    email.text = renterReq.value.email ?? '';
  }
}