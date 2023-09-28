import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gohomy/model/notification_user.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../components/loading/loading_full_screen.dart';
import '../../components/navigator/navigator.dart';
import '../../components/widget/check_customer_login/check_customer_login_screen.dart';
import '../../utils/color_utils.dart';
import '../../utils/date_utils.dart';
import 'notification_cus_controller.dart';

class NotificationLockScreen extends StatelessWidget {
  const NotificationLockScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(child: NotificationScreen());
  }
}

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController notificationController =
      Get.put(NotificationController());

  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

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
        title: const Text("Thông báo"),
        actions: [
          IconButton(
              onPressed: () {
                notificationController.readAllNotification().then((value) {
                  notificationController
                      .historyNotification(isRefresh: true)
                      .then(
                          (value) => Get.find<DataAppController>().getBadge());
                });
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Obx(
        () => notificationController.isLoadingInit.value == true
            ? SahaLoadingFullScreen()
            : notificationController.listNotificationCus.isEmpty
                ? const Center(
                    child: Icon(
                    Icons.notifications_off,
                    size: 50,
                    color: Colors.grey,
                  ))
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    footer: CustomFooter(
                      loadStyle: LoadStyle.ShowAlways,
                      builder: (context, mode) {
                        if (mode == LoadStatus.loading) {
                          return const SizedBox(
                            height: 60.0,
                            child: SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: CupertinoActivityIndicator(),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    header: const MaterialClassicHeader(),
                    controller: _refreshController,
                    onRefresh: () async {
                      await notificationController.historyNotification(
                          isRefresh: true);
                      _refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await notificationController.historyNotification();
                      _refreshController.loadComplete();
                    },
                    child: ListView.builder(
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemCount:
                            notificationController.listNotificationCus.length,
                        itemBuilder: (BuildContext context, int index) {
                          return boxNotification(notificationController
                              .listNotificationCus[index]);
                        }),
                  ),
      ),
    );
  }

  Widget boxNotification(NotificationUser notificationCus) {
    return InkWell(
      onTap: () {
        NotificationNavigator.navigator(notificationCus);
        notificationController
            .readNotification(id: notificationCus.id!)
            .then((value) {
          var index = notificationController.listNotificationCus
              .indexOf(notificationCus);
          notificationController.listNotificationCus[index].unread = false;
          notificationController.listNotificationCus.refresh();
          Get.find<DataAppController>().getBadge();
        });
      },
      child: Container(
        color: notificationCus.unread == true
            ? SahaColorUtils()
                .colorPrimaryTextWithWhiteBackground()
                .withOpacity(0.05)
            : Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  notificationCus.unread == true
                      ? const Icon(
                          Icons.circle,
                          color: Colors.blue,
                          size: 10,
                        )
                      : const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 12,
                        ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notificationCus.title ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          notificationCus.content ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          SahaDateUtils().getDDMMYY3(
                              notificationCus.createdAt ?? DateTime.now()),
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                  )
                ],
              ),
            ),
            const Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget icon(NotificationUser notificationCus) {
    // if (notificationCus.type == NEW_MESSAGE)
    //   return SvgPicture.asset(
    //     'packages/sahashop_customer/assets/icons/chat2.svg',
    //     height: 45,
    //     width: 45,
    //   );
    // if (notificationCus.type == NEW_CONTRACT)
    //   return SvgPicture.asset(
    //     'packages/sahashop_customer/assets/icons/chat2.svg',
    //     height: 45,
    //     width: 45,
    //   );
    // if (notificationCus.type == NEW_POST)
    //   return SvgPicture.asset(
    //     'packages/sahashop_customer/assets/icons/newspaper.svg',
    //     height: 45,
    //     width: 45,
    //   );
    // if (notificationCus.type == NEW_PERIODIC_SETTLEMENT)
    //   SvgPicture.asset(
    //     'packages/sahashop_customer/assets/icons/audit.svg',
    //     height: 45,
    //     width: 45,
    //   );
    // if (notificationCus.type!.split("-")[0] == ORDER_STATUS)
    //   return SvgPicture.asset(
    //     'packages/sahashop_customer/assets/icons/tracking.svg',
    //     height: 45,
    //     width: 45,
    //   );
    // if (notificationCus.type == CUSTOMER_CANCELLED_ORDER)
    //   return SvgPicture.asset(
    //     'packages/sahashop_customer/assets/icons/cancel.svg',
    //     height: 45,
    //     width: 45,
    //   );
    // if (notificationCus.type == CUSTOMER_PAID)
    //   return SvgPicture.asset(
    //     'packages/sahashop_customer/assets/icons/debit_card.svg',
    //     height: 45,
    //     width: 45,
    //   );
    // if (notificationCus.type == SEND_ALL)
    //   return SvgPicture.asset(
    //     'packages/sahashop_customer/assets/icons/all.svg',
    //     height: 45,
    //     width: 45,
    //   );
    // if (notificationCus.type == TO_ADMIN)
    //   return SvgPicture.asset(
    //     'packages/sahashop_customer/assets/icons/admin.svg',
    //     height: 45,
    //     width: 45,
    //   );

    return const Icon(
      Icons.circle,
      color: Colors.blue,
      size: 10,
    );
  }
}
