import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/screen/admin/post/post_screen.dart';
import 'package:gohomy/screen/admin/post/roommate_post/post_roommate_admin_screen.dart';

import 'find_room_post/find_room_post_admin_screen.dart';

class PostAdminScreen extends StatelessWidget {
  const PostAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Quản lý bài đăng",
      ),
      body: Column(
        children: [
          item(
              title: "Quản lý bài đăng",
              onTap: () {
                Get.to(() => PostScreen());
              }),
          item(
              title: "Quản lý bài đăng tìm phòng",
              onTap: () {
                Get.to(() => FindRoomPostAdminScreen());
              }),
          item(
              title: "Quản lý bài đăng tìm người ở ghép",
              onTap: () {
                Get.to(() => PostRoommateAdminScreen());
              }),
        ],
      ),
    );
  }

  Widget item({required String title, required Function onTap}) {
    return Card(
      child: ListTile(
        onTap: () {
          onTap();
        },
        title: Text(title),
        trailing: const Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
