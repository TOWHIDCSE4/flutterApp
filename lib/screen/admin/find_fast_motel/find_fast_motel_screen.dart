import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/find_fast_motel.dart';
import 'package:gohomy/screen/chat/chat_list/chat_list_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/text_field/saha_text_field_search.dart';
import '../../../utils/call.dart';
import '../../../utils/debounce.dart';
import '../../../utils/string_utils.dart';
import 'find_fast_motel_controller.dart';
import 'find_fast_motel_detail/find_fast_motel_detail_screen.dart';

class FindFastMotelScreen extends StatefulWidget {
  const FindFastMotelScreen({Key? key}) : super(key: key);

  @override
  State<FindFastMotelScreen> createState() => _FindFastMotelScreenState();
}

class _FindFastMotelScreenState extends State<FindFastMotelScreen>
    with SingleTickerProviderStateMixin {
  FindFastMotelController findFastMotelController = FindFastMotelController();
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
                  // begin: Alignment.bottomLeft,
                  // end: Alignment.topRight,
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
                        findFastMotelController.status.value = v == 0 ? 0 : 2;
                        findFastMotelController.getAllFindFastMotel(
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
              hintText: "Tìm kiếm phòng trọ",
              onChanged: (va) {
                EasyDebounce.debounce(
                    'list_motel_room', const Duration(milliseconds: 300), () {
                  findFastMotelController.textSearch = va;
                  findFastMotelController.getAllFindFastMotel(isRefresh: true);
                });
              },
              onClose: () {
                findFastMotelController.textSearch = "";
                findFastMotelController.getAllFindFastMotel(isRefresh: true);
              },
            ),
            Expanded(
              child: Obx(
                () => findFastMotelController.loadInit.value
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
                                  findFastMotelController.isLoading.value
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
                          await findFastMotelController.getAllFindFastMotel(
                              isRefresh: true);
                          refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await findFastMotelController.getAllFindFastMotel();
                          refreshController.loadComplete();
                        },
                        child: ListView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemCount: findFastMotelController
                                .listFindFastMotel.length,
                            itemBuilder: (BuildContext context, int index) {
                              return itemFindFastMotel(
                                  findFastMotel: findFastMotelController
                                      .listFindFastMotel[index]);
                            }),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemFindFastMotel({required FindFastMotel findFastMotel, context}) {
    return GestureDetector(
      onTap: () {
        Get.to(()=>FindFastMotelDetailScreen(idFindFast: findFastMotel.id!,));
      },
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
              offset: const Offset(0, 3),
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
                  color: Theme.of(Get.context!).primaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(findFastMotel.name ?? ""),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(Icons.phone, color: Theme.of(Get.context!).primaryColor),
                const SizedBox(
                  width: 10,
                ),
                Text(findFastMotel.phoneNumber ?? ""),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(Icons.location_on_rounded,
                    color: Theme.of(Get.context!).primaryColor),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${findFastMotel.addressDetail ?? ""}${findFastMotel.addressDetail == null ? "" : ", "}${findFastMotel.wardsName ?? ""}${findFastMotel.wardsName != null ? ", " : ""}${findFastMotel.districtName ?? ""}${findFastMotel.districtName != null ? ", " : ""}${findFastMotel.provinceName ?? ""}',
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.note, color: Theme.of(Get.context!).primaryColor),
                const SizedBox(
                  width: 10,
                ),
                Expanded(child: Text(findFastMotel.note ?? "...")),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            if (findFastMotel.price != null && findFastMotel.price != 0)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.money, color: Theme.of(Get.context!).primaryColor),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                          "${SahaStringUtils().convertToMoney(findFastMotel.price ?? "0")} đ")),
                ],
              ),
            if (findFastMotel.price != null || findFastMotel.price != 0)
              const SizedBox(
                height: 5,
              ),
            if (findFastMotel.capacity != null && findFastMotel.capacity != 0)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.person, color: Theme.of(Get.context!).primaryColor),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text("${findFastMotel.capacity ?? ""} người")),
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
                    Call.call(findFastMotel.phoneNumber ?? "");
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
                if (findFastMotel.user != null)
                  InkWell(
                    onTap: () {
                      Get.to(() => ChatListScreen(
                            toUser: findFastMotel.user,
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(Get.context!).primaryColor,
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
                    if (findFastMotelController.status.value == 2) {
                      SahaDialogApp.showDialogYesNo(
                          mess: 'Bạn có chắc chắn muốn xoá thông tin này chứ ?',
                          onOK: () {
                            findFastMotelController.deleteFindFastMotel(
                              findFastMotelId: findFastMotel.id!,
                            );
                          });
                    } else {
                      findFastMotelController.updateFindFastMotel(
                          findFastMotelId: findFastMotel.id!, status: 2);
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: findFastMotelController.status.value == 2
                            ? Colors.red
                            : Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          findFastMotelController.status.value == 2
                              ? Icons.delete
                              : Icons.check,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          findFastMotelController.status.value == 2
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
