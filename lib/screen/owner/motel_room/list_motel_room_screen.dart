import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/components/loading/loading_widget.dart';
import 'package:gohomy/model/motel_room.dart';
import 'package:gohomy/screen/find_room/room_information/room_information_screen.dart';
import 'package:gohomy/screen/home/home_controller.dart';
import 'package:gohomy/screen/profile/favourite_post/favourite_post_controller.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/text_field/saha_text_field_search.dart';
import '../../../const/motel_type.dart';
import '../../../model/tower.dart';
import '../../../utils/debounce.dart';
import '../../profile/favourite_post/favourite_post_details/favourite_details_screen.dart';
import 'add_motel_room/add_motel_room_screen.dart';
import 'list_motel_room_controller.dart';

class ListMotelRoomScreen extends StatefulWidget {
  bool? isNext;

  final bool? isTower;
  final int? towerId;
  final Tower? tower;
  late ListMotelRoomController listMotelRoomController;
  bool? isSupportTower;
  ListMotelRoomScreen(
      {Key? key,
      this.isNext,
      this.isTower,
      this.towerId,
      this.tower,
      this.isSupportTower})
      : super(key: key) {
    listMotelRoomController = ListMotelRoomController(
        isTower: isTower, towerId: towerId, isSupportTower: isSupportTower);
  }

  @override
  State<ListMotelRoomScreen> createState() => _ListMotelRoomScreenState();
}

class _ListMotelRoomScreenState extends State<ListMotelRoomScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  RefreshController refreshController = RefreshController();
  FavouritePostController favouritePostController = FavouritePostController();

  @override
  void initState() {
    favouritePostController.getAllMotelPost(isRefresh: true);
    if (widget.isNext == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Get.to(() => AddMotelRoomScreen())!.then((value) =>
            widget.listMotelRoomController.getAllMotelRoom(isRefresh: true));
      });
    }
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Phòng trọ",
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
      ),
      floatingActionButton: widget.isSupportTower == true
          ? const SizedBox()
          : FloatingActionButton(
              onPressed: () {
                Get.to(() => AddMotelRoomScreen(
                          isHaveTower: widget.isTower,
                          towerInput: widget.tower,
                        ))!
                    .then((value) => {
                          widget.listMotelRoomController
                              .getAllMotelRoom(isRefresh: true)
                        });
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add),
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
                      if (v == 2) {
                        widget.listMotelRoomController.status = 3;
                        widget.listMotelRoomController
                            .getAllMotelRoom(isRefresh: true);
                      } else {
                        widget.listMotelRoomController.hasContract.value =
                            (v == 0 ? false : true);
                        widget.listMotelRoomController.status = null;
                        widget.listMotelRoomController
                            .getAllMotelRoom(isRefresh: true);
                      }
                    },
                    tabs: [
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Chưa cho thuê',
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
                              'Đã cho thuê',
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
                              'Bản nháp',
                              style: TextStyle(
                                color: Colors.blue,
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
                widget.listMotelRoomController.textSearch = va;
                widget.listMotelRoomController.getAllMotelRoom(isRefresh: true);
              });
            },
            onClose: () {
              widget.listMotelRoomController.textSearch = "";
              widget.listMotelRoomController.getAllMotelRoom(isRefresh: true);
            },
          ),
          Obx(
            () => Expanded(
              child: SmartRefresher(
                footer: CustomFooter(
                  builder: (
                    BuildContext context,
                    LoadStatus? mode,
                  ) {
                    Widget body = Container();
                    if (mode == LoadStatus.idle) {
                      body = Obx(() =>
                          widget.listMotelRoomController.isLoading.value
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
                enablePullDown: true,
                enablePullUp: true,
                header: const MaterialClassicHeader(),
                onRefresh: () async {
                  await widget.listMotelRoomController
                      .getAllMotelRoom(isRefresh: true);
                  refreshController.refreshCompleted();
                },
                onLoading: () async {
                  await widget.listMotelRoomController.getAllMotelRoom();
                  refreshController.loadComplete();
                },
                controller: refreshController,
                child: ListView.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemCount:
                        widget.listMotelRoomController.listMotelRoom.length,
                    itemBuilder: (BuildContext context, int index) {
                      return roomItem(
                          widget.listMotelRoomController.listMotelRoom[index]);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget itemMotelRoom({required MotelRoom motelRoom, context}) {
  //   return GestureDetector(
  //     onTap: () {
  //       Get.to(() => AddMotelRoomScreen(
  //                 motelRoomInput: motelRoom,
  //               ))!
  //           .then((value) =>
  //               {listMotelRoomController.getAllMotelRoom(isRefresh: true)});
  //     },
  //     child: Container(
  //       margin: EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.5),
  //             spreadRadius: 1,
  //             blurRadius: 1,
  //             offset: Offset(0, 3), // changes position of shadow
  //           ),
  //         ],
  //       ),
  //       padding: EdgeInsets.all(10),
  //       child: Row(
  //         children: [
  //           Container(
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(5.0),
  //               child: CachedNetworkImage(
  //                 height: 100,
  //                 width: 100,
  //                 fit: BoxFit.cover,
  //                 imageUrl: (motelRoom.images ?? []).isEmpty
  //                     ? ""
  //                     : motelRoom.images![0],
  //                 placeholder: (context, url) => SahaLoadingWidget(),
  //                 errorWidget: (context, url, error) => SahaEmptyImage(),
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Flexible(
  //                         child: Text(
  //                           "${motelRoom.motelName ?? ""}",
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                             overflow: TextOverflow.ellipsis,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ),
  //                       Text(
  //                         "${SahaStringUtils().convertToMoney(motelRoom.money ?? "0")}đ",
  //                         textAlign: TextAlign.center,
  //                         maxLines: 2,
  //                         style: TextStyle(
  //                           overflow: TextOverflow.ellipsis,
  //                           color: Theme.of(context).primaryColor,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Text(
  //                   '${typeRoom[motelRoom.type]}',
  //                   maxLines: 2,
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Text(
  //                   '${motelRoom.addressDetail ?? ""}${motelRoom.addressDetail == null ? "" : ", "}${motelRoom.wardsName ?? ""}${motelRoom.wardsName != null ? ", " : ""}${motelRoom.districtName ?? ""}${motelRoom.districtName != null ? ", " : ""}${motelRoom.provinceName ?? ""}',
  //                   maxLines: 2,
  //                   style: TextStyle(
  //                     color: Colors.grey,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Icon(
  //                           FontAwesomeIcons.peopleRoof,
  //                           color: Color(0xFF00B894),
  //                           size: 18,
  //                         ),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Text(
  //                           motelRoom.capacity == null
  //                               ? "0"
  //                               : "${motelRoom.capacity}",
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       children: [
  //                         Icon(
  //                           motelRoom.sex == 0
  //                               ? FontAwesomeIcons.marsAndVenus
  //                               : motelRoom.sex == 1
  //                                   ? FontAwesomeIcons.mars
  //                                   : FontAwesomeIcons.venus,
  //                           size: 20,
  //                           color: motelRoom.sex == 0
  //                               ? Color(0xFFBDC3C7)
  //                               : motelRoom.sex == 1
  //                                   ? Color(0xFF2980B9)
  //                                   : Color(0xFFE84393),
  //                         ),
  //                         SizedBox(
  //                           width: 5,
  //                         ),
  //                         Text(
  //                           motelRoom.sex == 0
  //                               ? "Nam, Nữ"
  //                               : motelRoom.sex == 1
  //                                   ? "Nam"
  //                                   : "Nữ",
  //                         )
  //                       ],
  //                     ),
  //                     Row(
  //                       children: [
  //                         Icon(
  //                           Icons.photo_size_select_small_rounded,
  //                           size: 20,
  //                           color: Color(0xFFFF7675),
  //                         ),
  //                         SizedBox(
  //                           width: 5,
  //                         ),
  //                         Text(
  //                           "${motelRoom.area}m²",
  //                         )
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget roomItem(MotelRoom item) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddMotelRoomScreen(motelRoomInput: item))!.then((value) =>
            {widget.listMotelRoomController.getAllMotelRoom(isRefresh: true)});
        // Get.to(() => RoomInformationScreen(
        //           roomPostId: item.id,
        //           editButton: IconButton(
        //             onPressed: () {
        //               Get.to(() => AddMotelRoomScreen(motelRoomInput: item))!
        //                   .then((value) => {
        //                         widget.listMotelRoomController
        //                             .getAllMotelRoom(isRefresh: true)
        //                       });
        //             },
        //             icon: const Icon(Icons.edit),
        //           ),
        //         ))!
        //     .then((value) => Get.find<HomeController>().getAllHomeApp());
        // Get.to(() => FavouriteDetailsScreen(
        //           roomPostId: item.id,
        //         ))!
        //     .then((value) =>
        //         favouritePostController.getAllMotelPost(isRefresh: true));
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    ((item.images ?? []).isNotEmpty ? item.images![0] : "") +
                        "?reduce_file=true",
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,

                    //placeholder: (context, url) => SahaLoadingWidget(),
                    errorBuilder: (context, url, error) =>
                        const SahaEmptyImage(),
                  ),
                ),
                if (item.adminVerified == true)
                  Positioned(
                      bottom: 10,
                      left: 5,
                      child: SvgPicture.asset(
                          width: 25, 'assets/icon_service/shield.svg')),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Phòng: ${item.motelName ?? ''}'),
                  const SizedBox(
                    height: 5,
                  ),
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
                  const SizedBox(
                    height: 5,
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
                              '${SahaStringUtils().convertToMoney(item.money ?? 0)} VNĐ/${typeUnitRoom[item.type ?? 0]}',
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
                  const SizedBox(
                    height: 5,
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
          ],
        ),
      ),
    );
  }
}
