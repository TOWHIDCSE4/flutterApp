import '../../remote/response-request/address/address_respone.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class AddressRepository {
  Future<AddressResponse?> getProvince() async {
    try {
      var res = await SahaServiceManager().service!.getProvince();
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AddressResponse?> getDistrict(int? idProvince) async {
    try {
      var res = await SahaServiceManager().service!.getDistrict(idProvince);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AddressResponse?> getWard(int? idDistrict) async {
    try {
      var res = await SahaServiceManager().service!.getWard(idDistrict);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}
