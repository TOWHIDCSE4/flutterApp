import 'package:flutter/material.dart';

enum GradientContaineType { vnd, goldCoin, silverCoin }

class GradientContainerWithShadow extends StatelessWidget {
  const GradientContainerWithShadow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    this.type = GradientContaineType.vnd,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final Color color;
  final GradientContaineType type;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const ColorFilter grayscale = ColorFilter.matrix(<double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);

    final image = Image.asset(
      'assets/images/gold_coin.png',
      scale: 1.25,
    );
    final imageWidget = type == GradientContaineType.goldCoin
        ? image
        : ColorFiltered(
            colorFilter: grayscale,
            child: image,
          );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150, // Customize the width as needed
        height: 100, // Customize the height as needed

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.withOpacity(.5), Colors.white],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(
                  0, 3), // Adjust the offset to change the shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subtitle + (type == GradientContaineType.vnd ? ' VNĐ' : ''),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (type != GradientContaineType.vnd) ...[
                    const SizedBox(width: 5),
                    imageWidget,
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
