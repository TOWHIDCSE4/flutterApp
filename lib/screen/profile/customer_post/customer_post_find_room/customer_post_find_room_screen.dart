import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/model/post_find_room.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../components/text_field/saha_text_field_search.dart';
import '../../../../const/motel_type.dart';
import '../../../../utils/date_utils.dart';
import '../../../../utils/debounce.dart';
import '../../../../utils/string_utils.dart';
import 'add_customer_post_find_room.dart/add_customer_post_find_room_screen.dart';
import 'customer_post_find_room_controller.dart';

class CustomerPostFindRoomScreen extends StatefulWidget {
  const CustomerPostFindRoomScreen({super.key});

  @override
  State<CustomerPostFindRoomScreen> createState() =>
      _CustomerPostFindRoomScreenState();
}

class _CustomerPostFindRoomScreenState extends State<CustomerPostFindRoomScreen>
    with SingleTickerProviderStateMixin {
  CustomerPostFindRoomController controller = CustomerPostFindRoomController();
  RefreshController refreshController = RefreshController();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Bài đăng tìm phòng",
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
                      controller.status.value = (v == 0
                          ? 0
                          : v == 1
                              ? 2
                              : 1);
                      controller.getAllPostFindRoom(isRefresh: true);
                    },
                    tabs: [
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Đang chờ duyệt',
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
                              'Đang hoạt động',
                              style: TextStyle(
                                color: Colors.green,
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
                              'Đã bị ẩn',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
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
            hintText: "Tìm kiếm bài đăng",
            onChanged: (v) {
              EasyDebounce.debounce(
                  'list_post_management', const Duration(milliseconds: 300),
                  () {
                controller.textSearch = v;
                controller.getAllPostFindRoom(isRefresh: true);
              });
            },
            onClose: () {
              controller.textSearch = "";
              controller.getAllPostFindRoom(isRefresh: true);
            },
          ),
          Expanded(
            child: Obx(
              () => controller.loadInit.value
                  ? SahaLoadingFullScreen()
                  : controller.listPostFindRoom.isEmpty
                      ? const Center(
                          child: Text('Không có bài đăng'),
                        )
                      : SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          header: const MaterialClassicHeader(),
                          footer: CustomFooter(
                            builder: (
                              BuildContext context,
                              LoadStatus? mode,
                            ) {
                              Widget body = Container();
                              if (mode == LoadStatus.idle) {
                                body = Obx(() => controller.isLoading.value
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
                          onRefresh: () async {
                            await controller.getAllPostFindRoom(
                                isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await controller.getAllPostFindRoom();
                            refreshController.loadComplete();
                          },
                          child: ListView.builder(
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              itemCount: controller.listPostFindRoom.length,
                              itemBuilder: (BuildContext context, int index) {
                                return postItem(
                                    controller.listPostFindRoom[index]);
                              }),
                        ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddCustomerPostFindRoomScreen())!
              .then((value) => controller.getAllPostFindRoom(isRefresh: true));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget postItem(PostFindRoom item) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddCustomerPostFindRoomScreen(
                  idPostFindRoom: item.id,
                ))!
            .then((value) => controller.getAllPostFindRoom(isRefresh: true));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${item.title}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  letterSpacing: 0.1,
                  color: Colors.black),
            ),
            //Text('Chủ nhà: ${item.host?.name ?? ''}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     const Icon(
                //       Icons.border_style_outlined,
                //       color: Colors.grey,
                //       size: 14,
                //     ),
                //     const SizedBox(
                //       width: 4,
                //     ),
                //     Text(
                //       '${item.area ?? '0'} m2',
                //       style: const TextStyle(color: Colors.grey),
                //     )
                //   ],
                // ),
                // const SizedBox(
                //   width: 10,
                // ),
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 14,
                    ),
                    Text(
                      '${item.capacity ?? 0}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                if (item.sex == 0)
                  const Text(
                    "Nam / Nữ",
                    style: TextStyle(color: Colors.grey),
                  ),
                if (item.sex == 1)
                  const Text(
                    'Nam',
                    style: TextStyle(color: Colors.grey),
                  ),
                if (item.sex == 2)
                  const Text(
                    'Nữ',
                    style: TextStyle(color: Colors.grey),
                  ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 0,
                bottom: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Icon(
                          FontAwesomeIcons.dollarSign,
                          color: Theme.of(context).primaryColor,
                          size: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        ' "${SahaStringUtils().convertToUnit(item.moneyFrom ?? 0)} - ${SahaStringUtils().convertToUnit(item.moneyTo ?? 0)} VNĐ/Tháng"',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Text(
                    "${item.phoneNumber}",
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 14,
                  color: Colors.grey,
                ),
                Expanded(
                  child: Text(
                    '${item.addressDetail ?? ""}${item.addressDetail == null ? "" : ", "}${item.wardsName ?? ""}${item.wardsName != null ? ", " : ""}${item.districtName ?? ""}${item.districtName != null ? ", " : ""}${item.provinceName ?? ""}',
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
