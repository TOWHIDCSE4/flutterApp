import 'package:flutter/material.dart';
import 'package:gohomy/const/color.dart';

class WithdrawTextTile extends StatelessWidget {
  const WithdrawTextTile({
    super.key,
    required this.title,
    required this.value,
    this.valueFontSize = 16,
    this.valueColor = AppColor.dark0,
  });

  final String title;
  final String value;
  final double valueFontSize;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColor.dark4,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: valueFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

