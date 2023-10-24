import 'package:flutter/foundation.dart';

class FinishHandle {
  final int milliseconds;
  var timeNow = DateTime.now();
  VoidCallback? action;

  FinishHandle({required this.milliseconds});

  run(VoidCallback action) async {
    timeNow = DateTime.now();
    await Future.delayed(Duration(milliseconds: milliseconds));
    var diff = DateTime.now().difference(timeNow);
    if (diff.inMilliseconds > milliseconds) {
      action();
    }
  }
}
