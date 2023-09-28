import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnected {
  static final CheckConnected _singleton = CheckConnected._internal();

  CheckConnected._internal();
  factory CheckConnected() {
    return _singleton;
  }

  ConnectivityResult? _connectionStatus;

  ConnectivityResult? getConnectivityResult() {
    return _connectionStatus;
  }

  Future<void> checkConnected() async {
    _connectionStatus = await Connectivity().checkConnectivity();
    print('connect status : $_connectionStatus');
  }
}
