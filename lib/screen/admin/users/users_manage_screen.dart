import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/users/admin_manage/manage_admin_screen.dart';

import 'package:gohomy/screen/admin/users/users_screen.dart';

class UserManageSceen extends StatelessWidget {
  const UserManageSceen({Key? key}) : super(key: key);

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
        title: const Text('Quản lý users'),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text('Quản lý chủ nhà'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Get.to(() => UsersScreen(
                      isHost: true,
                    ));
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Quản lý người dùng'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Get.to(() => UsersScreen());
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Quản lý admin'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Get.to(() => ManageAdminScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
