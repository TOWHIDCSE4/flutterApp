import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';

import 'bottomsheet_item_tile.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
    required this.onPickCamera,
    required this.onPickGallery,
  });

  final VoidCallback onPickCamera;
  final VoidCallback onPickGallery;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Center(
            child: Container(
              width: 40,
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0xFFC4D0D9),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                'Thay ảnh đại diện',
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          BottomSheetItemTile(
            title: 'Máy ảnh',
            onTap: onPickCamera,
          ),
          const Divider(color: AppColor.diabled),
          BottomSheetItemTile(
            title: 'Thư viện ảnh',
            onTap: onPickGallery,
          ),
          const Divider(color: AppColor.diabled),
          BottomSheetItemTile(
            title: 'Đóng',
            onTap: Get.back,
          ),
        ],
      ),
    );
  }
}
