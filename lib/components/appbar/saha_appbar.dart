import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SahaAppBar extends PreferredSize {
  final double height;
  final Widget? titleChild;
  final String? titleText;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  SahaAppBar(
      {this.leading,
      this.actions,
      this.titleText,
      this.bottom,
      this.titleChild,
      this.height = kToolbarHeight})
      : super(child: Container(), preferredSize: const Size(100, 100));

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: titleText != null
            ? Text(
                titleText!,
              )
            : titleChild,
        automaticallyImplyLeading: true,
        leading: leading ??
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios)),
        actions: actions,
        elevation: 0.0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        bottom: bottom ?? const PreferredSize(
                preferredSize: Size.zero,
                child: Divider(
                  height: 1,
                )));
  }
}
