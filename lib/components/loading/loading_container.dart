import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SahaLoadingContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? gloss;
  final double? borderRadius;

  const SahaLoadingContainer(
      {Key? key, this.height, this.width, this.gloss = 1, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!.withOpacity(gloss!),
      highlightColor: Colors.white,
      enabled: true,
      child: Container(
        height: height,
        width: (width ?? 0) + 2,
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            color: Colors.grey[200]!.withOpacity(gloss!),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 3))),
        child: Column(
          children: const [],
        ),
      ),
    );
  }
}
