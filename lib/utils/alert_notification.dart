import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/notification_user.dart';

import '../components/navigator/navigator.dart';

class SahaNotificationAlert {
  static const String NEW_ORDER = "NEW_ORDER";

  static void alertNotification(RemoteMessage messages) {
    var message = NotificationUser.fromJson(messages.data);
    if (message.type != null) {
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
              borderColor: Colors.deepOrange,
              boxShadows: kElevationToShadow[8],
              position: FlashPosition.top,
              behavior: FlashBehavior.floating,
              backgroundGradient: const RadialGradient(
                colors: [Colors.white, Colors.white],
                center: Alignment.topLeft,
                radius: 2,
              ),
              // onTap: () => {
              //   controller.dismiss(),
              // },
              forwardAnimationCurve: Curves.easeInCirc,
              reverseAnimationCurve: Curves.bounceIn,
              child: InkWell(
                onTap: () {
                  NotificationNavigator.navigator(message);
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
                            Text("${messages.notification?.title}"),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${messages.notification?.body}',
                              style:
                                  const TextStyle(fontSize: 11, color: Colors.grey),
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
}
