import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gohomy/const/color.dart';

class BodyTextTile extends StatelessWidget {
  const BodyTextTile({
    super.key,
    required this.title,
    this.data,
  });

  final String title;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColor.textColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        data == null
            ? SvgPicture.asset('assets/images/dash_line.svg')
            : Text(
              data!,
              style: const TextStyle(
                color: AppColor.dark2,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
      ],
    );
  }
}
