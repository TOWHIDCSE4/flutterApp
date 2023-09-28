import 'package:flutter/material.dart';
import 'package:gohomy/const/color.dart';

class CardVerificationTile extends StatelessWidget {
  const CardVerificationTile({
    super.key,
    required this.title,
    required this.instruction,
    required this.imgPath,
  });

  final String title;
  final String instruction;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: AppColor.blue1,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              instruction,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Image.asset(imgPath),
          ],
        ),
      ),
    );
  }
}
