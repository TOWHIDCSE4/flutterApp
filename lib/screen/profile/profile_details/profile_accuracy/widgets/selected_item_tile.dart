import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectedItemTile extends StatelessWidget {
  const SelectedItemTile({
    super.key, required this.iconPath, required this.title,
  });

  final String iconPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            height: 15,
            width: 15,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
