import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/const/type_noti.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/notification/notification_cus_controller.dart';
import '../../components/navigator/navigator.dart';
import '../../firebase_options.dart';
import '../../model/notification_user.dart';
import '../../screen/chat/chat_list/chat_list_controller.dart';
import '../../screen/find_room/find_room_post/post_find_room_screen.dart';
import '../../screen/find_room/post_roommate/post_roommate_screen.dart';
import '../../screen/find_room/room_information/room_information_screen.dart';
import '../../utils/alert_notification.dart';
import '../../utils/user_info.dart';

class LoadFirebase {
  static Future<void> initFirebase() async {
    print(' =====> init firebase');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    FCMMess().handleFirebaseMess();
    
  }
}



class FCMMess {
  static final FCMMess _singleton = FCMMess._internal();
  FCMMess._internal();

  factory FCMMess() {
    return _singleton;
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void removeID() async {
    await _firebaseMessaging.deleteToken();
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    var map = message.data;

    print(map);

    if (map.containsKey('data')) {
      final dynamic data = map['data'];
    }

    if (map.containsKey('notification')) {
      final dynamic notification = map['notification'];
    }
  }

  void handleFirebaseMess() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessage data 1: ${message.data}");
      var messageNoti = NotificationUser.fromJson(message.data);
      NotificationNavigator.navigator(messageNoti);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage data: ${message.data}");
      Get.find<DataAppController>().getBadge();

      if (message.data['type'] == NEW_MESSAGE) {
        Get.find<ChatListController>().getChatAdminHelper();
      }

      SahaNotificationAlert.alertNotification(message);
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.find<NotificationController>().historyNotification(isRefresh: true);
        Get.find<ChatListController>().getAllBoxChat(isRefresh: true);
      });
    });
    await initToken();
  }

  Future<void> initToken() async {
    try {
      await _firebaseMessaging.getToken().then((String? token) async {
        // assert(token != null);
        print("Push Messaging token: $token");
        FCMToken().setToken(token);

        if (UserInfo().getToken() != null) {
          RepositoryManager.notificationRepository
              .sendDeviceToken(token: token ?? '');
          print('--------------> token : $token');
        } else {
          print(' --------null---------');
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}

class FCMToken {
  static final FCMToken _singleton = FCMToken._internal();

  String? _token;

  String? get token => _token;

  factory FCMToken() {
    return _singleton;
  }

  FCMToken._internal();

  void setToken(String? code) {
    _token = code;
  }

  String? getToken() {
    return _token;
  }
}
