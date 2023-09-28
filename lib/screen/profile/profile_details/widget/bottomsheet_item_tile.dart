import 'package:flutter/material.dart';
import 'package:gohomy/const/color.dart';

class BottomSheetItemTile extends StatelessWidget {
  const BottomSheetItemTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColor.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
