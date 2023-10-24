import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/support/category_help_post/category_screen.dart';
import 'package:gohomy/screen/admin/support/help_post/help_post_screen.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: const Text('Hỗ trợ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Quản lý danh mục bài đăng hỗ trợ'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => const CategoryScreen());
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Quản lý bài đăng hỗ trợ'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.to(() => const HelpPostScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
