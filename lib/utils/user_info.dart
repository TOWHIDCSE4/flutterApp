import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/badge.dart';
import 'package:gohomy/model/user.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/navigator/navigator_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/key_local.dart';
import '../data/firebase/load_firebase.dart';

class UserInfo {
  static final UserInfo _singleton = UserInfo._internal();

  String? _token;
  bool? _isRelease;
  int? _discoverDistrictId;

  factory UserInfo() {
    return _singleton;
  }

  UserInfo._internal();

  Future<void> setDiscoverDistrictId(int? discoverId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (discoverId == null) {
      await prefs.remove(DISCOVER_ID);
    } else {
      await prefs.setInt(DISCOVER_ID, discoverId);
    }
    _discoverDistrictId = discoverId;
  }

  int? getDiscoverDistrictId() {
    return _discoverDistrictId;
  }

  void clearDiscoverId() async {
    _discoverDistrictId = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(DISCOVER_ID);
  }

  Future<void> setRelease(bool? isRelease) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isRelease == null) {
      await prefs.remove(IS_RELEASE);
    } else {
      await prefs.setBool(IS_RELEASE, isRelease);
    }
    _isRelease = isRelease;
  }

  bool? getIsRelease() {
    return _isRelease;
  }

  Future<bool?> getInitIsRelease() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isRelease = prefs.getBool(IS_RELEASE);
    print(_isRelease);
    return _isRelease;
  }

  Future<void> setToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token == null) {
      await prefs.remove(USER_TOKEN);
    } else {
      await prefs.setString(USER_TOKEN, token);
    }
    _token = token;
  }

  String? getToken() {
    return _token;
  }

  Future<bool> hasLogged() async {
    await loadDataUserSaved();
    if (_token != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> loadDataUserSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenLocal = prefs.getString(USER_TOKEN);
    int? discoverIdInit = prefs.getInt(DISCOVER_ID);

    _token = tokenLocal;
    _discoverDistrictId = discoverIdInit;
    print("check load data =============== $_discoverDistrictId");
  }

  Future<void> logout() async {
    //delete token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(USER_TOKEN);
    _token = null;
    //delete message firebase
     await RepositoryManager.adminManageRepository.deleteToken(userId:  Get.find<DataAppController>().currentUser.value.id!, deviceToken:  FCMToken().getToken()!);
    FCMToken().setToken(null);
   

    FirebaseMessaging.instance.deleteToken();
    //back screen
    Get.find<DataAppController>().isLogin.value = false;
    Get.find<DataAppController>().badge.value = Badge();
    Get.find<DataAppController>().currentUser.value = User();

    Get.offAll(() => NavigatorApp());
    // Get.delete<NavigatorController>();
    // Get.delete<HomeController>();
  }

 
}
