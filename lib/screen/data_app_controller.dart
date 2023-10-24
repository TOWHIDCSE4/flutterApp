import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import '../components/arlert/saha_alert.dart';
import '../data/repository/repository_manager.dart';
import '../model/badge.dart' as b;
import '../model/user.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../model/user_login.dart';
import '../utils/debounce.dart';

class DataAppController extends GetxController {
  var badge = b.Badge().obs;
  var isLogin = false.obs;
  var currentUser = User().obs;

  var checkApple = true.obs;
  var totalReport = 0.obs;
  Connectivity connectivity = Connectivity();
  late ConnectivityResult connectionStatus;
  late StreamSubscription<ConnectivityResult> sub;
  @override
  void onInit() {
    checkConnected();
    initPackageInfo();
    getUserLogin(refresh: true);
    getCheckApple();

    super.onInit();
  }

  var listUserLogin = RxList<UserLogin>();

  void getUserLogin({bool? refresh}) async {
    if (refresh == true) {
      listUserLogin([]);
    }
    var box = await Hive.openBox('USER_LOGIN');
    for (var element in box.values) {
      listUserLogin.add(element);
    }

    print(listUserLogin);

    listUserLogin.refresh();
  }

  Future<void> getBadge() async {
    try {
      var data = await RepositoryManager.accountRepository.getBadge();
      badge(data!.data!);
      if (data.data?.user != null) {
        currentUser(data.data!.user!);
      }
      sum();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getCheckApple() async {
    try {
      var data = await RepositoryManager.accountRepository.getCheckApple();
      checkApple(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  var packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  ).obs;

  Future<void> initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo.value = info;
  }

  bool checkLoginAndAuthAction() {
    if (isLogin.value == false) {
      return false;
    } else {
      return true;
    }
  }

  void checkConnected() {
    sub = connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      EasyDebounce.debounce('connection', const Duration(milliseconds: 500),
          () async {
        connectionStatus = result;

        print('---===============================>$result');

        if (connectionStatus == ConnectivityResult.none) {
          showDialogErrorInternet();
        }

        if (connectionStatus == ConnectivityResult.wifi ||
            connectionStatus == ConnectivityResult.mobile) {
          getCheckApple();
        }
      });
    });
  }

  void showDialogErrorInternet() {
    showDialog(
        barrierDismissible: true,
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Không có kết nối mạng",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        });
  }

  void sum() {
    totalReport.value = (badge.value.totalReservationMotelNotConsult ?? 0) +
        (badge.value.totalQuantityReportViolationPostProgressingAdmin ?? 0);
  }
}
