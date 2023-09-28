import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';

import '../../../../model/motel_room.dart';
import '../../../../model/tower.dart';
import '../../choose_room/choose_room_screen.dart';
import '../../motel_room/choose_tower/choose_tower_screen.dart';

class ChooseTowerOrRoomScreen extends StatelessWidget {
  ChooseTowerOrRoomScreen(
      {super.key, required this.onChoose, this.tower, this.room});
  final Function onChoose;
  Tower? tower;
  MotelRoom? room;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Chọn toà nhà/phòng",
      ),
      body: Column(
        children: [
          item(
              assetImage: "assets/images/tower.png",
              title: "TOÀ NHÀ",
              onTap: () {
                Get.to(() => ChooseTowerScreen(
                      onChoose: onChoose,
                      isFromPost: true,
                      towerChoose: tower,
                    ));
              }),
          item(
              assetImage: "assets/images/room.png",
              title: "PHÒNG ĐƠN",
              onTap: () {
                Get.to(() => ChooseRoomScreen(
                    onChoose: onChoose,
                    hasContract: false,
                    isFromPost: true,
                    listMotelInput: room == null ? [] : [room!]));
              })
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
