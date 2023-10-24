import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';

class ActivedButton extends StatelessWidget {
  const ActivedButton({
    super.key, required this.title, required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            ImageAssets.curvedButton,
          ),
          Text(
            title,
            style: const TextStyle(
              color: AppColor.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}