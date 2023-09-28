import 'package:flutter/material.dart';

class CompleteBadge extends StatelessWidget {
  const CompleteBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.50,
      child: Transform(
        transform: Matrix4.identity()
          ..translate(0.0, 0.0)
          ..rotateZ(0.32),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              alignment: AlignmentDirectional.center,
              width: 89.71,
              height: 39.07,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1.25, color: Color(0xFFFB3E15)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Đã thanh\ntoán',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFFB3E15),
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                width: 63.29,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 63.29,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 12.5,
              child: Transform(
                transform: Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-1.525),
                child: Container(
                  width: 11.56,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: -10,
              bottom: 10,
              child: Transform(
                transform: Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-1.525),
                child: Container(
                  width: 11.56,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
