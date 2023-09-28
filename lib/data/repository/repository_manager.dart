import 'package:gohomy/data/repository/admin_manage/admin_manage_repository.dart';
import 'package:gohomy/data/repository/room_post/room_post_repository.dart';
import 'package:gohomy/data/repository/user_manage/user_manage_repository.dart';

import 'account/account_repository.dart';
import 'address/address_repository.dart';
import 'chat/chat_repository.dart';
import 'home_app/home_app_repository.dart';
import 'image/image_repository.dart';
import 'manage/manage_repository.dart';
import 'notification/notification_repository.dart';
import 'report/report_repository.dart';
import 'service_sell/service_sell_repository.dart';
import 'wallet/wallet_repository.dart';

class RepositoryManager {
  static AccountRepository get accountRepository => AccountRepository();
  static ImageRepository get imageRepository => ImageRepository();
  static ManageRepository get manageRepository => ManageRepository();
  static RoomPostRepository get roomPostRepository => RoomPostRepository();
  static AddressRepository get addressRepository => AddressRepository();
  static HomeAppRepository get homeAppRepository => HomeAppRepository();
  static ReportRepository get reportRepository => ReportRepository();
  static ChatRepository get chatRepository => ChatRepository();
  static ServiceSellRepository get serviceSellRepository => ServiceSellRepository();
  static NotificationRepository get notificationRepository => NotificationRepository();
  static UserManageRepository get userManageRepository =>
      UserManageRepository();
  static AdminManageRepository get adminManageRepository =>
      AdminManageRepository();
  static WalletRepository get walletRepository => WalletRepository();
}
