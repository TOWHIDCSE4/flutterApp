import 'package:flutter/material.dart';
import 'package:gohomy/const/color.dart';

class TextFieldTextTitle extends StatelessWidget {
  const TextFieldTextTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColor.dark4,
        ),
      ),
    );
  }
}
