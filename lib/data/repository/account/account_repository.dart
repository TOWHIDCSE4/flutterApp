import '../../../model/profile.dart';
import '../../../model/user.dart';
import '../../remote/response-request/account/all_noti_user_res.dart';
import '../../remote/response-request/account/badge_res.dart';
import '../../remote/response-request/account/check_apple_res.dart';
import '../../remote/response-request/auth/login_response.dart';
import '../../remote/response-request/success/success_response.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class AccountRepository {
  Future<Profile?> register(
      {required String name,
      required String? otp,
      required String phone,
      //required String password,
      String? referralCode}) async {
    try {
      var res = await SahaServiceManager().service!.register({
        "name": name,
        "phone_number": phone,
        //"password": password,
        'otp': otp,
        'referral_code': referralCode
      });
      return res.data;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<LoginResponse?> login(String phone, String otp, bool isOtp) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .login({"phone_number": phone, "otp": otp, "is_otp": isOtp});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> changePassword(
      {required String oldPass, required String newPass}) async {
    try {
      var res = await SahaServiceManager().service!.changePassword({
        "old_password": oldPass,
        "new_password": newPass,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> updateProfile({required User user}) async {
    try {
      var res =
          await SahaServiceManager().service!.updateProfile(user.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> updatePhoneProfile(String phoneNumber) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updatePhoneProfile({'phone_number': phoneNumber});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> updateHost(bool isHost) async {
    try {
      var res =
          await SahaServiceManager().service!.updateHost({'is_host': isHost});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<BadgesRes?> getBadge() async {
    try {
      var res = await SahaServiceManager().service!.getBadge();
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CheckAppleRes?> getCheckApple() async {
    try {
      var res = await SahaServiceManager().service!.getCheckApple();
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> checkExists(
      {String? emailOrPhoneNumber, String? referralCode, int? type}) async {
    try {
      var res = await SahaServiceManager().service!.checkExists({
        "email_or_phone_number": emailOrPhoneNumber,
        "referral_code": referralCode,
        "type": type
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<bool?> sendOtp({String numberPhone = ""}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .sendOtp({"phone_number": numberPhone});
      return true;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<bool?> resetPassword({
    String? emailOrPhoneNumber,
    String? pass,
    String? otp,
  }) async {
    try {
      var res = await SahaServiceManager().service!.resetPassword({
        "email_or_phone_number": emailOrPhoneNumber,
        "password": pass,
        "otp": otp,
      });
      return true;
    } catch (err) {
      handleError(err);
      return false;
    }
  }
  // Future<UserRes?> updateProfile({
  //  required User user
  // }) async {
  //   try {
  //     var res = await SahaServiceManager().service!.updateProfile(user.toJson());
  //     return res;
  //   } catch (err) {
  //     handleError(err);
  //   }
  // }
  //
  // Future<BadgeRes?> getBadge() async {
  //   try {
  //     var res = await SahaServiceManager().service!.getBadge();
  //     return res;
  //   } catch (err) {
  //     handleError(err);
  //   }
  // }
  //
  // Future<UserRes?> getAccountProfile() async {
  //   try {
  //     var res = await SahaServiceManager().service!.getAccountProfile();
  //     return res;
  //   } catch (err) {
  //     handleError(err);
  //   }
  // }
   Future<AllNotiUserRes?> getAllNotiUser({required String userIds}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllNotiUser(userIds);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }


}
