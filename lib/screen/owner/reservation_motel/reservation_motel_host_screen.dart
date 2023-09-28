import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/reservation_motel.dart';
import 'package:gohomy/screen/chat/chat_list/chat_list_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../components/text_field/saha_text_field_search.dart';
import '../../../utils/call.dart';
import '../../../utils/debounce.dart';
import '../../find_room/room_information/room_information_screen.dart';
import 'reservation_motel_host_controller.dart';

class ReservationMotelHostScreen extends StatefulWidget {
  const ReservationMotelHostScreen({Key? key}) : super(key: key);

  @override
  State<ReservationMotelHostScreen> createState() =>
      _ReservationMotelHostScreenState();
}

class _ReservationMotelHostScreenState extends State<ReservationMotelHostScreen>
    with SingleTickerProviderStateMixin {
  ReservationMotelHostController reservationMotelController =
      ReservationMotelHostController();
  RefreshController refreshController = RefreshController();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Khách tìm phòng",
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 45,
                  width: Get.width,
                  child: ColoredBox(
                    color: Colors.white,
                    child: TabBar(
                      controller: _tabController,
                      onTap: (v) {
                        reservationMotelController.status.value =
                            v == 0 ? 0 : 2;
                        reservationMotelController.getReservationMotelHost(
                            isRefresh: true);
                      },
                      tabs: [
                        Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Chưa tư vấn',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Đã tư vấn',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SahaTextFieldSearch(
              hintText: "Tìm kiếm ",
              onChanged: (va) {
                EasyDebounce.debounce(
                    'list_motel_room', const Duration(milliseconds: 300), () {
                  reservationMotelController.textSearch = va;
                  reservationMotelController.getReservationMotelHost(
                      isRefresh: true);
                });
              },
              onClose: () {
                reservationMotelController.textSearch = "";
                reservationMotelController.getReservationMotelHost(
                    isRefresh: true);
              },
            ),
            Expanded(
              child: Obx(
                () => reservationMotelController.loadInit.value
                    ? SahaLoadingFullScreen()
                    : SmartRefresher(
                        footer: CustomFooter(
                          builder: (
                            BuildContext context,
                            LoadStatus? mode,
                          ) {
                            Widget body = Container();
                            if (mode == LoadStatus.idle) {
                              body = Obx(() =>
                                  reservationMotelController.isLoading.value
                                      ? const CupertinoActivityIndicator()
                                      : Container());
                            } else if (mode == LoadStatus.loading) {
                              body = const CupertinoActivityIndicator();
                            }
                            return SizedBox(
                              height: 100,
                              child: Center(child: body),
                            );
                          },
                        ),
                        controller: refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        header: const MaterialClassicHeader(),
                        onRefresh: () async {
                          await reservationMotelController
                              .getReservationMotelHost(isRefresh: true);
                          refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await reservationMotelController
                              .getReservationMotelHost();
                          refreshController.loadComplete();
                        },
                        child: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: Column(
                            children: [
                              Obx(
                                () => Container(
                                  child: Wrap(
                                    children: [
                                      ...reservationMotelController
                                          .listReservationMotel
                                          .map((e) {
                                        return itemReservationMotel(
                                            reservationMotel: e,
                                            context: context);
                                      }).toList()
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemReservationMotel(
      {required ReservationMotel reservationMotel, context}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(reservationMotel.name ?? ""),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(Icons.phone, color: Theme.of(context).primaryColor),
                const SizedBox(
                  width: 10,
                ),
                Text(reservationMotel.phoneNumber ?? ""),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.note, color: Theme.of(context).primaryColor),
                const SizedBox(
                  width: 10,
                ),
                Expanded(child: Text(reservationMotel.note ?? "...")),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.podcasts_sharp,
                    color: Theme.of(context).primaryColor),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Get.to(() => RoomInformationScreen(
                          roomPostId: reservationMotel.motelPost!.id!,
                          isWatch: true,
                        ));
                  },
                  child: Text(
                    "Từ bài đăng: ${reservationMotel.motelPost?.title ?? "..."}",
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Call.call(reservationMotel.phoneNumber ?? "");
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Gọi',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (reservationMotel.user != null)
                  InkWell(
                    onTap: () {
                      Get.to(() => ChatListScreen(
                            toUser: reservationMotel.user,
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.chat_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Chat',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                InkWell(
                  onTap: () {
                    if (reservationMotelController.status.value == 2) {
                      SahaDialogApp.showDialogYesNo(
                          mess: 'Bạn có chắc chắn muốn xoá thông tin này chứ ?',
                          onOK: () {
                            reservationMotelController.deleteReservationMotel(
                              reservationId: reservationMotel.id!,
                            );
                          });
                    } else {
                      reservationMotelController.updateReservationMotel(
                          reservationId: reservationMotel.id!, status: 2);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: reservationMotelController.status.value == 2
                            ? Colors.red
                            : Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          reservationMotelController.status.value == 2
                              ? Icons.delete
                              : Icons.check,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          reservationMotelController.status.value == 2
                              ? "Xoá"
                              : 'Đã tư vấn',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
