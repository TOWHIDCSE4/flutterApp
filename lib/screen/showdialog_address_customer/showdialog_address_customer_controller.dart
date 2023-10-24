import 'package:get/get.dart';

import '../../components/arlert/saha_alert.dart';
import '../../data/repository/repository_manager.dart';
import '../../model/location_address.dart';

enum TypeAddress {
  Province,
  District,
  Wards,
}

class ChooseAddressCustomerController extends GetxController {
  final TypeAddress? typeAddress;
  final idProvince;
  final idDistrict;

  ChooseAddressCustomerController(this.typeAddress, this.idProvince, this.idDistrict) {
    checkTypeAddress();
  }

  var nameTitleAppbar = "".obs;
  var listLocationAddress = RxList<LocationAddress>().obs;
  var isLoadingAddress = false.obs;
  var notEnteredProvince = false.obs;

  void checkTypeAddress() {
    if (idProvince == 0 || idDistrict == 0) {
      notEnteredProvince.value = true;
      return;
    }

    if (typeAddress == TypeAddress.Province) {
      nameTitleAppbar.value = "Tỉnh/Thành phố";
      getProvince();
    } else {
      if (typeAddress == TypeAddress.District) {
        nameTitleAppbar.value = "Quận/Huyện";
        getDistrict(idProvince);
      } else {
        nameTitleAppbar.value = "Phường/Xã";
        getWard(idDistrict);
      }
    }
  }

  Future<void> getProvince() async {
    isLoadingAddress.value = true;
    try {
      var res = await RepositoryManager.addressRepository.getProvince();

      for (var element in res!.data!) {
        listLocationAddress.value.add(element);
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }

    isLoadingAddress.value = false;
  }

  Future<void> getDistrict(int? idProvince) async {
    isLoadingAddress.value = true;
    try {
      var res = await RepositoryManager.addressRepository.getDistrict(idProvince);

      for (var element in res!.data!) {
        listLocationAddress.value.add(element);
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }

    isLoadingAddress.value = false;
  }

  Future<void> getWard(int? idDistrict) async {
    isLoadingAddress.value = true;
    try {
      var res = await RepositoryManager.addressRepository.getWard(idDistrict);

      for (var element in res!.data!) {
        listLocationAddress.value.add(element);
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAddress.value = false;
  }
}
