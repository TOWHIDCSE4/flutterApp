import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';

class CustomWithdrawAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomWithdrawAppBar({
    super.key,
    required this.title,
    this.isEnableTrailing = false,
  });

  final String title;
  final bool isEnableTrailing;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: Get.back,
      ),
      title: Text(
        title,
        style: const TextStyle(color: AppColor.dark0),
      ),
      actions: isEnableTrailing == true ? [
        TextButton(
          onPressed: () {},
          child: const Text(
            'Trợ giúp',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ] : [],
      centerTitle: true,
    );
  }
}
