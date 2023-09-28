import 'package:flutter/material.dart';
import 'package:gohomy/const/image_assets.dart';

class SummaryTile extends StatelessWidget {
  const SummaryTile({
    super.key,
    required this.silverCoinText,
    required this.goldCoinText,
    required this.onTap,
  });

  final String silverCoinText;
  final String goldCoinText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Image.asset(
                ImageAssets.renren,
                height: 31,
                width: 31,
              ),
              const SizedBox(width: 8),
              const Text(
                'Ví Renren',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Image.asset(
                ImageAssets.goldCoin,
                height: 31,
                width: 31,
              ),
              const SizedBox(width: 8),
              Text(
                goldCoinText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Image.asset(
                ImageAssets.silverCoin,
                height: 31,
                width: 31,
              ),
              const SizedBox(width: 8),
              Text(
                silverCoinText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}