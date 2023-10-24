import 'package:flutter/material.dart';

class SahaEmptyAvata extends StatelessWidget {
  final double? height;
  final double? width;

  const SahaEmptyAvata({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        // padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/images/default_avatar.png',
            height: height,
            fit: BoxFit.cover,
            width: width,
          ),
        ));
  }
}
