import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SahaLoadingWidget extends StatelessWidget {
  double? size;
  Color? color;

  SahaLoadingWidget({Key? key, this.size, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      color: color ?? Theme.of(context).primaryColor,
      size: size ?? 30.0,
    );
  }
}
