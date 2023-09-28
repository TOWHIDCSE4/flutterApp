import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as b;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/loading/loading_widget.dart';
import 'package:gohomy/components/widget/post_item/post_item.dart';
import 'package:gohomy/model/admin_discover.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/navigator/navigator_controller.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:gohomy/utils/user_info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/empty/saha_empty_image.dart';
import '../../components/widget/post_item/post_find_room_item.dart';
import '../../components/widget/post_item/post_item_hot.dart';
import '../../const/motel_type.dart';
import '../../model/location_address.dart';
import '../../model/post_find_room.dart';
import '../../utils/call.dart';
import '../find_room/find_location/find_location_screen.dart';
import '../find_room/find_now/find_now_screen.dart';
import '../find_room/find_room_post/list_find_room_post/list_find_room_post_screen.dart';
import '../find_room/find_room_post/post_find_room_screen.dart';
import '../find_room/find_room_screen.dart';
import '../find_room/post_roommate/list_post_roommate/list_post_roommate_screen.dart';
import '../notification/notification_cus_screen.dart';
import '../profile/service_sell/product_user_screen/product_user_screen.dart';
import '../web_view/web_view_screen.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.find();
  DataAppController dataAppController = Get.find();

  @override
  void initState() {
    super.initState();

    homeController.scrollController.addListener(() {
      if (homeController.scrollController.position.pixels >= 300) {
        if (homeController.show.value == true) return;
        homeController.show.value = true;
      } else {
        if (homeController.show.value == false) return;
        homeController.show.value = false;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (UserInfo().getDiscoverDistrictId() == null) {
          SahaDialogApp.showDialogChangeDiscover(
              item: (homeController.homeApp.value.adminDiscover ?? []),
              onChoose: (AdminDiscover v) async {
                await UserInfo().setDiscoverDistrictId(v.province);
                homeController.adminDiscover(v);
                homeController.getAllHomeApp();
              });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => homeController.isLoading.value == true
            ? Container()
            : SpeedDial(
                childMargin: const EdgeInsets.only(bottom: 20, left: 18),
                icon: Icons.phone,
                activeIcon: Icons.read_more_sharp,
                visible: true,
                closeManually: false,
                renderOverlay: false,
                curve: Curves.bounceIn,
                overlayColor: Colors.grey[300],
                overlayOpacity: 0.5,
                onOpen: () => print('OPENING DIAL'),
                onClose: () => print('DIAL CLOSED'),
                heroTag: 'home',
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColor,
                elevation: 8.0,
                shape: const CircleBorder(),
                children: [
                  SpeedDialChild(
                    child: Icon(
                      Icons.phone,
                      color: Theme.of(context).primaryColor,
                    ),
                    backgroundColor: Colors.white,
                    onTap: () => Call.call(homeController
                            .homeApp.value.adminContact?.phoneNumber ??
                        ""),
                    onLongPress: () => print('FIRST CHILD LONG PRESS'),
                  ),
                  SpeedDialChild(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset("assets/icon/facebook.png"),
                    ),
                    backgroundColor: Colors.white,
                    onTap: () => Get.to(() => WebViewScreen(
                        link: homeController
                                .homeApp.value.adminContact?.facebook ??
                            "")),
                    onLongPress: () => print('FIRST CHILD LONG PRESS'),
                  ),
                  SpeedDialChild(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset("assets/icon/zalo.png"),
                    ),
                    backgroundColor: Colors.white,
                    onTap: () => launchZaloURL(
                        '${homeController.homeApp.value.adminContact?.zalo}'),
                    onLongPress: () => print('FIRST CHILD LONG PRESS'),
                  ),
                  SpeedDialChild(
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "assets/icon/de-lai-thong-tin.png",
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    onTap: () => Get.to(() => FindNowScreen()),
                    onLongPress: () => print('FIRST CHILD LONG PRESS'),
                  ),
                ],
              ),
      ),
      body: Obx(
        () => homeController.loadInit.value
            ? Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFFFF5757),
                      Color(0xFFFEAA2B),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/logo_tran.png",
                          height: Get.width / 2,
                          width: Get.width / 2,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              )
            : Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      await homeController.getAllHomeApp();
                    },
                    child: SingleChildScrollView(
                      controller: homeController.scrollController,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 400,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Positioned(
                                      top: 0,
                                      child: Obx(
                                        () => homeController.homeApp.value
                                                        .listBanners ==
                                                    null ||
                                                homeController.homeApp.value
                                                    .listBanners!.isEmpty
                                            ? Container()
                                            : SizedBox(
                                                height: 250,
                                                width: Get.width,
                                                child: SizedBox(
                                                  height: 250,
                                                  width: Get.width,
                                                  child: Swiper(
                                                    autoplay: false,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return InkWell(
                                                        // onTap: () async {
                                                        //   if (homeController
                                                        //               .homeApp
                                                        //               .value
                                                        //               .listBanners![
                                                        //                   index]
                                                        //               .actionLink ==
                                                        //           null ||
                                                        //       homeController
                                                        //               .homeApp
                                                        //               .value
                                                        //               .listBanners![
                                                        //                   index]
                                                        //               .actionLink ==
                                                        //           '') {
                                                        //     return;
                                                        //   }
                                                        //   var url =
                                                        //       "https://${homeController.homeApp.value.listBanners![index].actionLink}";
                                                        //
                                                        //   if (await canLaunchUrl(
                                                        //       Uri.parse(url))) {
                                                        //     launchUrl(
                                                        //         Uri.parse(url));
                                                        //   } else {
                                                        //     print(
                                                        //         'Không thể lanch url');
                                                        //   }
                                                        // },
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              homeController
                                                                  .homeApp
                                                                  .value
                                                                  .listBanners![
                                                                      index]
                                                                  .imageUrl!,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      );
                                                    },
                                                    itemCount: homeController
                                                        .homeApp
                                                        .value
                                                        .listBanners!
                                                        .length,
                                                    pagination:
                                                        const SwiperPagination(),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 10,
                                      right: 10,
                                      child: Container(
                                        width: Get.width,
                                        height: 180,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 7,
                                                blurRadius: 9,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ]),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      SahaDialogApp
                                                          .showDialogChangeDiscover(
                                                              item: (homeController
                                                                      .homeApp
                                                                      .value
                                                                      .adminDiscover ??
                                                                  []),
                                                              onChoose:
                                                                  (AdminDiscover
                                                                      v) async {
                                                                await UserInfo()
                                                                    .setDiscoverDistrictId(
                                                                        v.province);
                                                                homeController
                                                                    .adminDiscover(
                                                                        v);
                                                                homeController
                                                                    .getAllHomeApp();
                                                              });
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .location_on_rounded,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          Obx(
                                                            () => Text(
                                                              SahaStringUtils().convertAddress(
                                                                  homeController
                                                                          .adminDiscover
                                                                          .value
                                                                          .provinceName ??
                                                                      ""),
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                          () => FindRoomScreen(
                                                                locationProvince: LocationAddress(
                                                                    id: homeController
                                                                        .adminDiscover
                                                                        .value
                                                                        .province,
                                                                    name: homeController
                                                                            .adminDiscover
                                                                            .value
                                                                            .provinceName ??
                                                                        ""),
                                                              ));
                                                    },
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text(
                                                        'Tìm theo quận, địa điểm',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Obx(
                                                    () => Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Get.to(() =>
                                                                FindLocationScreen());
                                                          },
                                                          child: SizedBox(
                                                            width: (Get.width -
                                                                    20) /
                                                                4.5,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Image.asset(
                                                                  'assets/tim-phong.png',
                                                                  width: 50,
                                                                  height: 50,
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  child: Text(
                                                                    "Tìm phòng quanh đây",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          12,
                                                                      height:
                                                                          1.2,
                                                                      letterSpacing:
                                                                          0.1,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Get.to(() => ListFindRoomPostScreen(
                                                                locationProvince: LocationAddress(
                                                                    id: homeController
                                                                        .adminDiscover
                                                                        .value
                                                                        .province,
                                                                    name: homeController
                                                                            .adminDiscover
                                                                            .value
                                                                            .provinceName ??
                                                                        "")));
                                                          },
                                                          child: SizedBox(
                                                            width: (Get.width -
                                                                    20) /
                                                                4.5,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Image.asset(
                                                                  'assets/tin_tim_phong.png',
                                                                  width: 50,
                                                                  height: 50,
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  child: Text(
                                                                    "Tin đăng tìm phòng",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          12,
                                                                      height:
                                                                          1.2,
                                                                      letterSpacing:
                                                                          0.1,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Get.to(() =>
                                                                ListPostRoommateScreen(
                                                                  isNewest:
                                                                      true,
                                                                  locationProvince: LocationAddress(
                                                                      id: homeController
                                                                          .adminDiscover
                                                                          .value
                                                                          .province,
                                                                      name: homeController
                                                                              .adminDiscover
                                                                              .value
                                                                              .provinceName ??
                                                                          ""),
                                                                ));
                                                          },
                                                          child: SizedBox(
                                                            width: (Get.width -
                                                                    20) /
                                                                4.5,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Image.asset(
                                                                  'assets/tim_ban_o_ghep.png',
                                                                  width: 50,
                                                                  height: 50,
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  child: Text(
                                                                    "Tìm ở ghép",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize:
                                                                          12,
                                                                      height:
                                                                          1.2,
                                                                      letterSpacing:
                                                                          0.1,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        ...(homeController
                                                                    .homeApp
                                                                    .value
                                                                    .listCategoryServiceSell ??
                                                                [])
                                                            .map(
                                                              (e) => InkWell(
                                                                onTap: () {
                                                                  Get.to(() =>
                                                                      ProductUserScreen(
                                                                        categoryId:
                                                                            e.id,
                                                                      ));
                                                                  // Get.toNamed(
                                                                  //     "service_sell_screen",
                                                                  //     parameters: {
                                                                  //       'id': e
                                                                  //           .id
                                                                  //           .toString()
                                                                  //     });
                                                                },
                                                                child: SizedBox(
                                                                  width: (Get.width -
                                                                          20) /
                                                                      4.5,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      ClipOval(
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          imageUrl:
                                                                              e.image ?? '',
                                                                          // placeholder:
                                                                          //     (context, url) =>
                                                                          //         SahaLoadingWidget(),
                                                                          errorWidget: (context, url, error) =>
                                                                              const SahaEmptyImage(),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                5,
                                                                            right:
                                                                                5),
                                                                        child:
                                                                            Text(
                                                                          e.name ??
                                                                              '',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                12,
                                                                            height:
                                                                                1.2,
                                                                            letterSpacing:
                                                                                0.1,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: AppBar().preferredSize.height - 10,
                                  right: 20,
                                  child: Obx(
                                    () => GestureDetector(
                                      onTap: () {
                                        Get.to(() =>
                                            const NotificationLockScreen());
                                      },
                                      child: b.Badge(
                                        position: b.BadgePosition.topEnd(
                                            top: -10, end: -6),
                                        showBadge: dataAppController.badge.value
                                                        .notificationUnread ==
                                                    null ||
                                                dataAppController.badge.value
                                                        .notificationUnread ==
                                                    0
                                            ? false
                                            : true,
                                        badgeContent: Text(
                                          '${dataAppController.badge.value.notificationUnread ?? ''}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/icon/noti_fill.svg",
                                          width: 30,
                                          height: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 20,
                              bottom: 0,
                            ),
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            width: Get.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Image.asset(
                                      'assets/icon/kham-pha.png',
                                      width: Get.width / 3,
                                    )),
                                Obx(
                                  () => SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: (homeController.adminDiscover
                                                  .value.listDiscoverItem ??
                                              [])
                                          .map(
                                            (e) => discover(
                                              imageUrl: e.image ?? "",
                                              name: e.districtName ?? "",
                                              totalPost: e.totalMoPost,
                                              locationProvince: LocationAddress(
                                                  id: homeController
                                                      .adminDiscover
                                                      .value
                                                      .province,
                                                  name: homeController
                                                          .adminDiscover
                                                          .value
                                                          .provinceName ??
                                                      ""),
                                              locationDistrict: LocationAddress(
                                                  id: e.district,
                                                  name: e.districtName ?? ""),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Obx(
                            () => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...(homeController.homeApp.value.layouts ??
                                          [])
                                      .map(
                                        (layout) => Container(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          margin: const EdgeInsets.only(
                                            top: 0,
                                            bottom: 10,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  child: layout.list!.isNotEmpty
                                                      ? layout.title ==
                                                              'Bài viết nổi bật'
                                                          ? Image.asset(
                                                              'assets/icon/bai-viet-noi-bat.png',
                                                              width: Get.width /
                                                                  2.3,
                                                            )
                                                          : Image.asset(
                                                              'assets/icon/phong_moi_dang.png',
                                                              width: Get.width /
                                                                  2.3,
                                                              fit: BoxFit.cover,
                                                            )

                                                      // Text(
                                                      //     layout.title ?? "",
                                                      //     style:
                                                      //         const TextStyle(
                                                      //       fontSize: 18,
                                                      //       fontWeight:
                                                      //           FontWeight.w500,
                                                      //     ),
                                                      //   )
                                                      : const SizedBox()),
                                              Wrap(
                                                children: layout.list!
                                                    .map((list) => layout
                                                                .title ==
                                                            "Bài viết nổi bật"
                                                        ? PostItemHot(
                                                            post: list,
                                                            width: Get.width,
                                                            isAdmin: Get.find<
                                                                        DataAppController>()
                                                                    .currentUser
                                                                    .value
                                                                    .isAdmin ??
                                                                false,
                                                            isLogin: Get.find<
                                                                    DataAppController>()
                                                                .isLogin
                                                                .value,
                                                          )
                                                        : PostItem(
                                                            post: list,
                                                            isLogin: Get.find<
                                                                    DataAppController>()
                                                                .isLogin
                                                                .value,
                                                            height: 350,
                                                          ))
                                                    .toList(),
                                              ),
                                              if (layout.title ==
                                                      "Bài đăng mới" &&
                                                  (layout.list ?? [])
                                                      .isNotEmpty)
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(() => FindRoomScreen(
                                                          isNewest: true,
                                                          locationProvince: LocationAddress(
                                                              id: homeController
                                                                  .adminDiscover
                                                                  .value
                                                                  .province,
                                                              name: homeController
                                                                      .adminDiscover
                                                                      .value
                                                                      .provinceName ??
                                                                  ""),
                                                        ));
                                                  },
                                                  child: const Center(
                                                    child: Text(
                                                      'Xem thêm >>',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .deepOrange),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          'assets/icon/bai_dang_tim_phong.png',
                                          width: Get.width / 2.3,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ...(homeController.homeApp.value
                                                  .listPostFindRoom ??
                                              [])
                                          .map((e) => itemFindRoomPost(e,
                                              dataAppController.isLogin.value)),
                                      if ((homeController.homeApp.value
                                                  .listPostFindRoom ??
                                              [])
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => ListFindRoomPostScreen(
                                                locationProvince:
                                                    LocationAddress(
                                                        id: homeController
                                                            .adminDiscover
                                                            .value
                                                            .province,
                                                        name: homeController
                                                                .adminDiscover
                                                                .value
                                                                .provinceName ??
                                                            "")));
                                          },
                                          child: const Center(
                                            child: Text(
                                              'Xem thêm >>',
                                              style: TextStyle(
                                                  color: Colors.deepOrange),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          'assets/icon/bai_dang_o_ghep.png',
                                          width: Get.width / 2.3,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ...(homeController.homeApp.value
                                                        .listPostRoommate ??
                                                    [])
                                                .map((e) => PostFindRoomItem(
                                                      post: e,
                                                      isLogin: dataAppController
                                                          .isLogin.value,
                                                    )),
                                            if ((homeController.homeApp.value
                                                        .listPostRoommate ??
                                                    [])
                                                .isNotEmpty)
                                              InkWell(
                                                onTap: () {
                                                  Get.to(() =>
                                                      ListPostRoommateScreen(
                                                        isNewest: true,
                                                        locationProvince: LocationAddress(
                                                            id: homeController
                                                                .adminDiscover
                                                                .value
                                                                .province,
                                                            name: homeController
                                                                    .adminDiscover
                                                                    .value
                                                                    .provinceName ??
                                                                ""),
                                                      ));
                                                },
                                                child: const Center(
                                                  child: Text(
                                                    'Xem thêm >>',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepOrange),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => AnimatedPositioned(
                      width: Get.width,
                      duration: const Duration(milliseconds: 250),
                      top: !homeController.show.value
                          ? -(MediaQuery.of(context).padding.top + 60)
                          : 0,
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).padding.top,
                            ),
                            SizedBox(
                              height: 60,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              SahaDialogApp
                                                  .showDialogChangeDiscover(
                                                      item: (homeController
                                                              .homeApp
                                                              .value
                                                              .adminDiscover ??
                                                          []),
                                                      onChoose: (AdminDiscover
                                                          v) async {
                                                        await UserInfo()
                                                            .setDiscoverDistrictId(
                                                                v.province);
                                                        homeController
                                                            .adminDiscover(v);
                                                        homeController
                                                            .getAllHomeApp();
                                                      });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey[200]),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_rounded,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Obx(
                                                    () => Text(
                                                      SahaStringUtils().convertAddress(
                                                          homeController
                                                                  .adminDiscover
                                                                  .value
                                                                  .provinceName ??
                                                              ""),
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => FindRoomScreen(
                                                    locationProvince: LocationAddress(
                                                        id: homeController
                                                            .adminDiscover
                                                            .value
                                                            .province,
                                                        name: homeController
                                                                .adminDiscover
                                                                .value
                                                                .provinceName ??
                                                            ""),
                                                  ));
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Tìm theo quận, địa điểm',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Container(
                                      padding: const EdgeInsets.all(9),
                                      child: b.Badge(
                                        position: b.BadgePosition.topEnd(
                                            top: -10, end: -6),
                                        showBadge: dataAppController.badge.value
                                                        .notificationUnread ==
                                                    null ||
                                                dataAppController.badge.value
                                                        .notificationUnread ==
                                                    0
                                            ? false
                                            : true,
                                        badgeContent: Text(
                                          '${dataAppController.badge.value.notificationUnread ?? ''}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(() =>
                                                const NotificationLockScreen());
                                          },
                                          child: SvgPicture.asset(
                                            "assets/icon/noti_fill.svg",
                                            width: 25,
                                            height: 25,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget discover(
      {required String imageUrl,
      required String name,
      int? totalPost,
      required LocationAddress locationProvince,
      required LocationAddress locationDistrict}) {
    return GestureDetector(
      onTap: () {
        Get.to(() => FindRoomScreen(
              locationProvince: locationProvince,
              locationDistrict: locationDistrict,
            ));
      },
      child: Container(
        width: Get.width / 3,
        height: Get.width / 3,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Stack(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: CachedNetworkImage(
                  width: Get.width / 3,
                  height: Get.width / 3,
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const SahaEmptyImage()),
            ),
            Positioned.fill(
                child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [
                  0.19,
                  0.5,
                ],
                colors: [
                  Colors.black.withOpacity(0.35),
                  Colors.transparent,
                ],
              )),
            )),
            Positioned.fill(
              bottom: 4,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      int.tryParse(SahaStringUtils().convertAddress(name)) ==
                              null
                          ? SahaStringUtils().convertAddress(name)
                          : name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    if (totalPost != null &&
                        dataAppController.currentUser.value.isAdmin == true)
                      Text(
                        "(${totalPost.toString()} tin đăng)",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchZaloURL(String phone) async =>
      await canLaunchUrl(Uri.parse("https://zalo.me/$phone"))
          ? await launchUrl(Uri.parse("https://zalo.me/$phone"))
          : throw 'Could not launch https://zalo.me/$phone';

  Widget itemFindRoomPost(PostFindRoom post, bool isLogin) {
    return InkWell(
      onTap: () {
        Get.to(() => PostFindRoomScreen(
              postFindRoomId: post.id!,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              (post.title ?? "").toUpperCase(),
              overflow: TextOverflow.ellipsis,
              minFontSize: 15,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  letterSpacing: 0.1,
                  color: Theme.of(context).primaryColor),
              maxLines: 2,
            ),
            SizedBox(
              width: Get.width / 1.5,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.dollarSign,
                        color: Theme.of(context).primaryColor,
                        size: 14,
                      ),
                      Text(
                        '${SahaStringUtils().convertToMoney(post.moneyFrom ?? 0)} - ${SahaStringUtils().convertToMoney(post.moneyTo ?? 0)} VNĐ/${typeUnitRoom[post.type ?? 0]}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500),
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
                          isLogin != true
                              ? "${post.districtName ?? ""}${post.districtName != null ? ", " : ""}${post.provinceName ?? ""}"
                              : '${post.wardsName ?? ""}${post.wardsName != null ? ", " : ""}${post.districtName ?? ""}${post.districtName != null ? ", " : ""}${post.provinceName ?? ""}',
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            height: 1.2,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
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
