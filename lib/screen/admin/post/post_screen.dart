import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/motel_post.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/post/post_controller.dart';
import 'package:gohomy/screen/admin/post/post_details/post_details_screen.dart';
import 'package:gohomy/utils/date_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/loading/loading_widget.dart';
import '../../../components/text_field/saha_text_field_search.dart';
import '../../../const/motel_type.dart';
import '../../../utils/debounce.dart';
import '../../../utils/string_utils.dart';
import '../../data_app_controller.dart';
import '../../owner/post_management/add_update_post_management/add_update_post_management_screen.dart';
import '../users/user_filter/user_filter_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen>
    with SingleTickerProviderStateMixin {
  PostController postController = PostController();
  RefreshController refreshController = RefreshController();
  late TabController _tabController;
  double? maxMoney;
  double? minMoney;
  int? maxCapacity;
  int? maxArea;
  int? minArea;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
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
          title: Obx(
            () => Text(postController.userChoose.value.id != null
                ? postController.userChoose.value.name ?? ''
                : 'Bài đăng cho thuê phòng'),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => UserFilterScreen(
                      isShowTab: false,
                      idChoose: postController.userChoose.value.id,
                      onChoose: (user) {
                        postController.userChoose.value = user;
                        postController.getAllMotelPost(isRefresh: true);
                        Get.back();
                      }));
                },
                icon: Obx(() => Icon(
                    postController.userChoose.value.id != null
                        ? Icons.filter_alt
                        : Icons.filter_alt_outlined,
                    color: postController.userChoose.value.id != null
                        ? Colors.blue
                        : null)))
          ],
        ),
        floatingActionButton:
            Get.find<DataAppController>().badge.value.user?.isHost == true ||
                    (Get.find<DataAppController>().badge.value.user?.isHost ==
                            false &&
                        postController.listPost.isEmpty)
                ? FloatingActionButton(
                    heroTag: 'post_navi',
                    onPressed: () {
                      Get.to(() => AddUpdatePostManagementScreen())!.then(
                          (value) => {
                                postController.getAllMotelPost(isRefresh: true)
                              });
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.add),
                  )
                : null,
        body: Column(
          children: [
            SizedBox(
              height: 45,
              width: Get.width,
              child: ColoredBox(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  onTap: (v) {
                    postController.status.value = v == 0
                        ? 0
                        : v == 1
                            ? 2
                            : 1;
                    postController.getAllMotelPost(isRefresh: true);
                  },
                  tabs: [
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Đang chờ duyệt',
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
                            'Đang hoạt động',
                            style: TextStyle(
                              color: Colors.red,
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
                            'Đã bị hủy',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const Divider(
            //   height: 1,
            // ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Obx(() {
                int tabIndex = postController.status.value;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            // text: tabIndex == 0 ? 'Total Rendering: ' : tabIndex == 2 ? 'Total Rendered: ' : 'Total Cancelled: ',
                            text: tabIndex == 0 ? 'Tổng bài chờ duyệt: ': tabIndex == 2  ? 'Tổng bài hoạt động: ' : 'Tổng bài đã ẩn: ',  
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: '${postController.total.obs.value}',
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
              hintText: "Tìm kiếm ",
              onChanged: (va) {
                EasyDebounce.debounce(
                    'list_motel_post', const Duration(milliseconds: 300), () {
                  postController.textSearch = va;

                  postController.getAllMotelPost(isRefresh: true);
                });
              },
              onClose: () {
                postController.textSearch = "";
                postController.getAllMotelPost(isRefresh: true);
              },
            ),
            Expanded(
              child: Obx(
                () => postController.loadInit.value
                    ? SahaLoadingFullScreen()
                    : postController.listPost.value.isEmpty
                        ? const Center(
                            child: Text('Không có bài đăng'),
                          )
                        : SmartRefresher(
                            header: const MaterialClassicHeader(),
                            footer: CustomFooter(
                              builder: (
                                BuildContext context,
                                LoadStatus? mode,
                              ) {
                                Widget body = Container();
                                if (mode == LoadStatus.idle) {
                                  body = Obx(() =>
                                      postController.isLoading.value
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
                            onRefresh: () async {
                              await postController.getAllMotelPost(
                                  isRefresh: true);
                              refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              await postController.getAllMotelPost();
                              refreshController.loadComplete();
                            },
                            child: ListView.builder(
                                addAutomaticKeepAlives: false,
                                addRepaintBoundaries: false,
                                itemCount: postController.listPost.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return postItem(
                                      postController.listPost[index]);
                                }),
                          ),
              ),
            ),
          ],
        ));
  }

  Widget postItem(MotelPost item) {
    if (item.towerId != null &&
        item.listMotel != null &&
        item.listMotel!.isNotEmpty) {
      maxMoney = item.listMotel!
          .reduce((value, element) =>
              value.money! > element.money! ? value : element)
          .money;
      minMoney = item.listMotel!
          .reduce((value, element) =>
              value.money! < element.money! ? value : element)
          .money;
    }

    if (item.towerId != null &&
        item.listMotel != null &&
        item.listMotel!.isNotEmpty) {
      maxCapacity = item.listMotel!
          .reduce((value, element) =>
              value.capacity! > element.capacity! ? value : element)
          .capacity;
    }
    if (item.towerId != null &&
        item.listMotel != null &&
        item.listMotel!.isNotEmpty) {
      maxArea = item.listMotel!
          .reduce(
              (value, element) => value.area! > element.area! ? value : element)
          .area;
      minArea = item.listMotel!
          .reduce(
              (value, element) => value.area! < element.area! ? value : element)
          .area;
    }

    return GestureDetector(
      onTap: () {
        Get.to(() => PostDetailsScreen(
                  id: item.id!,
                  motelPostInput: item,
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
                      //placeholder: (context, url) => SahaLoadingWidget(),
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
                  Text('Chủ nhà: ${item.host?.name ?? ''}'),
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
                            item.towerId != null
                                ? '${minArea ?? 0} - ${maxArea ?? 0} m2'
                                : '${item.area} m2',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 14,
                          ),
                          Text(
                            item.towerId != null
                                ? "${maxCapacity ?? 0}"
                                : '${item.capacity ?? 0}',
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
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "${item.phoneNumber}",
                      ),
                    ],
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
