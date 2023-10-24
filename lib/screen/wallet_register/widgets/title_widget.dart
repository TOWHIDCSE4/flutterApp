import 'package:flutter/material.dart';
import 'package:gohomy/const/color.dart';

class AppTitle extends StatelessWidget {
  final String text;
  final double type;
  const AppTitle({
    Key? key,
    required this.text,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: type,fontWeight: FontWeight.w600,color: AppColor.textColor),
    );
  }
}
