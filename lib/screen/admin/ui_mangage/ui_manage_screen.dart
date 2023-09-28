import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/ui_mangage/banner_manage/banner_manage_screen.dart';
import 'package:gohomy/screen/admin/ui_mangage/discover_manage/discover_manage_screen.dart';

import 'intro_manage/intro_manage_screen.dart';

class UIManage extends StatelessWidget {
  const UIManage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý giao diện'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Quản lý banner'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => const BannerManageScreen());
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Quản lý khám phá'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => const DiscoverManageScreen());
                },
              ),
            ),
             Card(
              child: ListTile(
                title: const Text('Quản lý intro'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => IntroManageScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
