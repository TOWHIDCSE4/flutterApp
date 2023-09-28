import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/appbar/saha_appbar.dart';
import '../../admin/motel_room_admin/tower/tower_screen.dart';
import 'list_motel_room_screen.dart';

class MotelRoomManageScreen extends StatelessWidget {
  const MotelRoomManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: 'Quản lý phòng trọ',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          item(
              assetImage: "assets/images/tower.png",
              title: 'TOÀ NHÀ',
              onTap: () {
                Get.to(() => TowerScreen(
                      isAdmin: false,
                    ));
              }),
          item(
              assetImage: "assets/images/room.png",
              title: "PHÒNG ĐƠN",
              onTap: () {
                Get.to(() => ListMotelRoomScreen(
                      isTower: false,
                      isSupportTower: false,
                    ));
              }),
        ],
      ),
    );
  }

  Widget item(
      {required String assetImage,
      required String title,
      required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                assetImage,
                height: 200,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/blur.png',
                height: 200,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
