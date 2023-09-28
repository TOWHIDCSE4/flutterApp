import 'package:flutter/material.dart';
import 'loading_widget.dart';

class SahaLoadingFullScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SahaLoadingWidget()],
          )
        ],
      ),
    );
  }
}
