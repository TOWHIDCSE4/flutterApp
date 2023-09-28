import 'package:get/get.dart';
import 'package:gohomy/model/notification_user.dart';

import '../../components/arlert/saha_alert.dart';
import '../../data/repository/repository_manager.dart';

class NotificationController extends GetxController {
  NotificationController() {
    historyNotification();
  }

  var listNotificationCus = RxList<NotificationUser>();
  var isLoadMore = false.obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  var isLoadingInit = true.obs;

  Future<void> readAllNotification({bool? isRefresh}) async {
    try {
      var res =
          await RepositoryManager.notificationRepository.readAllNotification();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> readNotification({required int id}) async {
    try {
      var res = await RepositoryManager.notificationRepository
          .readNotification(id: id);
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> historyNotification({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.notificationRepository
            .historyNotification(currentPage);

        if (isRefresh == true) {
          listNotificationCus(data!.data!.listNotification!.data!);
        } else {
          listNotificationCus.addAll(data!.data!.listNotification!.data!);
        }

        if (data.data?.listNotification?.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
      isLoadingInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingInit.value = false;
    isLoadingInit.refresh();
  }

  // void navigator(String typeNotification, String orderCode) {
  //   if (typeNotification == NEW_ORDER) {
  //     Get.to(() => OrderHistoryScreen())!.then((value) {
  //       // historyNotification(isRefresh: true);
  //     });
  //   }
  //   if (typeNotification == NEW_MESSAGE) {
  //     Get.to(() => ChatCustomerScreen())!.then((value) {
  //       //historyNotification(isRefresh: true);
  //     });
  //   }
  //   if (typeNotification == NEW_POST) {
  //     Get.to(() => CategoryPostScreen(isAutoBackIcon: true,))!.then((value) {
  //       //historyNotification(isRefresh: true);
  //     });
  //   }
  //
  //   if (typeNotification == NEW_PERIODIC_SETTLEMENT) {
  //     Get.to(() => CtvWalletScreen())!.then((value) {
  //       //historyNotification(isRefresh: true);
  //     });
  //   }
  //
  //   if (typeNotification.split("-")[0] == ORDER_STATUS) {
  //     if (typeNotification.split("-")[1] == WAITING_FOR_PROGRESSING) {
  //
  //       Get.to(
  //               () => OrderHistoryDetailScreen(
  //                 orderCode: orderCode,
  //           ));
  //     }
  //
  //     if (typeNotification.split("-")[1] == PACKING) {
  //       Get.to(
  //               () => OrderHistoryDetailScreen(
  //             orderCode: orderCode,
  //           ));
  //     }
  //
  //     if (typeNotification.split("-")[1] == SHIPPING) {
  //       Get.to(
  //               () => OrderHistoryDetailScreen(
  //             orderCode: orderCode,
  //           ));
  //     }
  //     if (typeNotification.split("-")[1] == COMPLETED) {
  //       Get.to(
  //               () => OrderHistoryDetailScreen(
  //             orderCode: orderCode,
  //           ));
  //     }
  //
  //     if (typeNotification.split("-")[1] == OUT_OF_STOCK) {
  //       Get.to(
  //               () => OrderHistoryDetailScreen(
  //             orderCode: orderCode,
  //           ));
  //     }
  //
  //     if (typeNotification.split("-")[1] == USER_CANCELLED) {
  //       Get.to(() => OrderHistoryScreen(
  //             initPage: 5,
  //           ));
  //     }
  //
  //     if (typeNotification.split("-")[1] == CUSTOMER_CANCELLED) {
  //       Get.to(
  //               () => OrderHistoryDetailScreen(
  //             orderCode: orderCode,
  //           ));
  //     }
  //
  //     if (typeNotification.split("-")[1] == DELIVERY_ERROR) {
  //       Get.to(
  //               () => OrderHistoryDetailScreen(
  //             orderCode: orderCode,
  //           ));
  //     }
  //
  //     if (typeNotification.split("-")[1] == CUSTOMER_RETURNING) {
  //       Get.to(
  //               () => OrderHistoryDetailScreen(
  //             orderCode: orderCode,
  //           ));
  //     }
  //
  //     if (typeNotification.split("-")[1] == CUSTOMER_HAS_RETURNS) {
  //       Get.to(
  //               () => OrderHistoryDetailScreen(
  //             orderCode: orderCode,
  //           ));
  //     }
  //   }
  //
  //   if (typeNotification == CUSTOMER_PAID) {
  //     Get.to(() => OrderHistoryScreen())!.then((value) {
  //       // historyNotification(isRefresh: true);
  //     });
  //   }
  //   if (typeNotification == SEND_ALL) {}
  //   if (typeNotification == TO_ADMIN) {}
  // }
}
