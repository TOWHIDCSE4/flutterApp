import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';

class BannerTile extends StatelessWidget {
  BannerTile({
    this.goldenCoins,
    this.silverCoins,
    super.key,
  });
  num? goldenCoins;
  num? silverCoins;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [
                    Color(0xFFFF9900),
                    Color(0xFFE46025),
                    Color(0xFFDD3E1F),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(ImageAssets.imgRobot1),
                  Image.asset(ImageAssets.imgRobot2),
                ],
              ),
            )
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: -8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                ImageAssets.imgBanner,
                height: 135,
                width: size.width * 0.98,
              ),
              Column(
                children: [
                  const Text(
                    'Tổng tài sản',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColor.dark4,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            ImageAssets.goldCoin,
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$goldenCoins Xu vàng',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ImageAssets.silverCoin,
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$silverCoins Xu bạc',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF555555),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
