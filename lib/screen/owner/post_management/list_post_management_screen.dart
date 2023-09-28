import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/loading/loading_full_screen.dart';
import '../../../components/loading/loading_widget.dart';
import '../../../components/text_field/saha_text_field_search.dart';
import '../../../const/motel_type.dart';
import '../../../model/motel_post.dart';
import '../../../utils/date_utils.dart';
import '../../../utils/debounce.dart';
import '../../admin/post/post_controller.dart';
import '../../admin/post/post_details/post_details_screen.dart';
import 'add_update_post_management/add_update_post_management_screen.dart';
import 'list_post_management_controller.dart';

class ListPostManagementScreen extends StatefulWidget {
  int? initTab;
  bool? isNext;
  ListPostManagementScreen({Key? key, this.initTab, this.isNext})
      : super(key: key){
        controller = ListPostManagementController(initTab: initTab);
      }
      late  ListPostManagementController controller;
      

  @override
  State<ListPostManagementScreen> createState() =>
      _ListPostManagementScreenState();
}

class _ListPostManagementScreenState extends State<ListPostManagementScreen>
    with SingleTickerProviderStateMixin {
 
  RefreshController refreshController = RefreshController();
  late TabController _tabController;
  PostController postController = PostController(showToast: false);
  int tabIndex = 0;

  @override
  void initState() {
    if (widget.isNext == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Get.to(() => AddUpdatePostManagementScreen())!.then((value) =>
            widget.controller.getPostManagement(isRefresh: true));
      });
    }
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: widget.initTab ?? 0);
    if (widget.initTab != null) {
      widget.controller.status.value = widget.initTab == 0
          ? 0
          : widget.initTab == 1
              ? 2
              : 1;
      widget.controller.getPostManagement(isRefresh: true);
    }
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
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // begin: Alignment.bottomLeft,
                  // end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
          title: const Text('Bài đăng cho thuê phòng'),
        ),
        floatingActionButton:
            Get.find<DataAppController>().badge.value.user?.isHost == true ||
                    (Get.find<DataAppController>().badge.value.user?.isHost ==
                            false &&
                        widget.controller.listPostManagement.isEmpty)
                ? FloatingActionButton(
                    heroTag: 'post_navi',
                    onPressed: () {
                      Get.to(() => AddUpdatePostManagementScreen())!.then(
                          (value) => {
                                widget.controller.getPostManagement(
                                    isRefresh: true)
                              });
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.add),
                  )
                : null,
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
                        setState(() {
                          tabIndex = v;
                        });
                        widget.controller.status.value = (v == 0
                            ? 0
                            : v == 1
                                ? 2
                                : 1);
                        widget.controller.getPostManagement(
                            isRefresh: true);
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
            Align(
            alignment: Alignment.bottomLeft,
            child: Obx(() {
              // int? tabIndex = widget.adminMotelRoomController.status.obs.value;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: tabIndex == 0
                              ? 'Tổng bài chờ duyệt: '
                              : tabIndex == 1
                                  ? 'Tổng bài hoạt động: '
                                  : 'Tổng bài đã ẩn: ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text:
                              '${widget.controller.total.obs.value}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ]),
                    )
                  ],
                ),
              );
            }),
          ),
            SahaTextFieldSearch(
              hintText: "Tìm kiếm bài đăng",
              onChanged: (v) {
                EasyDebounce.debounce(
                    'list_post_management', const Duration(milliseconds: 300),
                    () {
                  widget.controller.textSearch = v;
                  widget.controller.getPostManagement(
                      isRefresh: true);
                });
              },
              onClose: () {
                widget.controller.textSearch = "";
                widget.controller.getPostManagement(isRefresh: true);
              },
            ),
            Expanded(
              child: Obx(
                () => widget.controller.loadInit.value
                    ? SahaLoadingFullScreen()
                    : widget.controller.listPostManagement.isEmpty
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
                                  body = Obx(() => widget.controller
                                          .isLoading.value
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
                              await widget.controller
                                  .getPostManagement(isRefresh: true);
                              refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              await widget.controller
                                  .getPostManagement();
                              refreshController.loadComplete();
                            },
                            child: ListView.builder(
                                addAutomaticKeepAlives: false,
                                addRepaintBoundaries: false,
                                itemCount: widget.controller
                                    .listPostManagement.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return postItem(widget.controller
                                      .listPostManagement[index]);
                                }),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget postItem(MotelPost item) {
       double? maxMoney;
    double? minMoney;
      if(item.towerId != null && item.listMotel != null && item.listMotel!.isNotEmpty){
            maxMoney = item.listMotel!
        .reduce(
            (value, element) => value.money! > element.money! ? value : element)
        .money;
         minMoney = item.listMotel!
        .reduce(
            (value, element) => value.money! < element.money! ? value : element)
        .money;
      }
    return GestureDetector(
      onTap: () {
        Get.to(() => PostDetailsScreen(
                  id: item.id!,
                  motelPostInput: item,
                  isVisibleShareIcon: true,
                  onTapEdit: () {
                    Get.to(() => AddUpdatePostManagementScreen(
                      id: item.id,
                    ))!.then((value) => {
                      widget.controller.getPostManagement(isRefresh: true)
                    });
                  },
                ))!
            .then((value) => postController.getAllMotelPost(isRefresh: true));
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
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: CachedNetworkImage(
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      imageUrl:
                          (item.images ?? []).isEmpty ? "" : item.images![0],
                      // placeholder: (context, url) => SahaLoadingWidget(),
                      errorWidget: (context, url, error) =>
                          const SahaEmptyImage(),
                    ),
                  ),
                ),
                if (item.adminVerified == true)
                  Positioned(
                      bottom: 10,
                      left: 5,
                      child: SvgPicture.asset(
                          width: 25, 'assets/icon_service/shield.svg')),
                if (item.totalViews != null && item.totalViews != 0)
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              '${item.totalViews ?? 0}',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 10,
                            )
                          ],
                        ),
                      )),
                if (item.hostRank == 1)
                  Positioned(
                      top: 10,
                      left: 5,
                      child: SvgPicture.asset(width: 25, 'assets/reward.svg')),
                if (item.hostRank == 2)
                  Positioned(
                      top: 10,
                      left: -10,
                      child: Image.asset(width: 50, 'assets/vip.png')),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.title}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        letterSpacing: 0.1,
                        color: item.hostRank == 2
                            ? Theme.of(context).primaryColor
                            : Colors.black),
                  ),
                  //Text('Chủ nhà: ${item.host?.name ?? ''}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.border_style_outlined,
                            color: Colors.grey,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '${item.area} m2',
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
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
                              item.towerId == null
                                  ? '${SahaStringUtils().convertToMoney(item.money ?? 0)} VNĐ/${typeUnitRoom[item.type ?? 0]}'
                                  : "${SahaStringUtils().convertToMoney(minMoney ?? 0)} - ${SahaStringUtils().convertToMoney(maxMoney ?? 0)} VNĐ",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${SahaDateUtils().getDDMMYY(item.updatedAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(item.updatedAt ?? DateTime.now())}'),
                      Text('Số lần gọi đến : ${item.numberCalls ?? ''} '),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
