import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SahaNotificationAlert {
  static void alertNotification(String title, String mess) {
    showFlash(
      context: Get.context!,
      duration: const Duration(seconds: 2),
      persistent: true,
      builder: (_, controller) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Flash(
            controller: controller,
            borderRadius: BorderRadius.circular(8.0),
            borderColor: Colors.green,
            boxShadows: kElevationToShadow[8],
            position: FlashPosition.top,
            behavior: FlashBehavior.floating,
            backgroundGradient: const RadialGradient(
              colors: [Colors.white, Colors.white],
              center: Alignment.topLeft,
              radius: 2,
            ),
            onTap: () => {
              controller.dismiss(),
            },
            forwardAnimationCurve: Curves.easeInCirc,
            reverseAnimationCurve: Curves.bounceIn,
            child: InkWell(
              onTap: () {
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.notifications_active,
                      color: Theme.of(Get.context!).primaryColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            mess,
                            style: const TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
