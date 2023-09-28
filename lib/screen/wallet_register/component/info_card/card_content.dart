import 'package:flutter/material.dart';

import '../../../../const/app_font.dart';
import '../../../../const/color.dart';

class ContentRow extends StatelessWidget {
  final String text;
  const ContentRow({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text,style: const TextStyle(fontSize: AppFontSize.subtitle),),
          Container(
            width: 84,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColor.divider,
                  width: 1.0, // Adjust the width as needed
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
