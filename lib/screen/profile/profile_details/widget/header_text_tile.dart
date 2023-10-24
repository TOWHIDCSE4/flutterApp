import 'package:flutter/material.dart';
import 'package:gohomy/const/color.dart';

class HeadingTextTile extends StatelessWidget {
  const HeadingTextTile({
    super.key,
    required this.title,
    required this.subTitle,
    this.isVisibleButton = true,
    required this.onTap,
  });

  final String title;
  final String subTitle;
  final bool isVisibleButton;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColor.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        isVisibleButton ? TextButton(
          onPressed: onTap,
          child: Text(
            subTitle,
            style: const TextStyle(
              color: Color(0xFF084DF0),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ) : const SizedBox.shrink(),
      ],
    );
  }
}
