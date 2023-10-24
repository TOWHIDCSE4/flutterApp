import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/admin/motel_room_admin/admin_motel_room_controller.dart';
import 'package:gohomy/screen/find_room/room_information/room_information_screen.dart';
import 'package:gohomy/screen/home/home_controller.dart';
import 'package:gohomy/utils/alert_notification.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/dialog/dialog.dart';
import '../../../components/empty/saha_empty_image.dart';
import '../../../components/text_field/saha_text_field_search.dart';
import '../../../const/motel_type.dart';
import '../../../model/motel_room.dart';
import '../../../model/tower.dart';
import '../../../utils/debounce.dart';
import '../../../utils/string_utils.dart';
import '../../owner/motel_room/add_motel_room/add_motel_room_screen.dart';
import '../users/user_filter/user_filter_screen.dart';

class AdminMotelRoomScreen extends StatefulWidget {
  AdminMotelRoomScreen(
      {Key? key,
      this.isTower,
      this.towerId,
      this.tower,
      this.isSupportTower,
      this.isFromTower})
      : super(key: key) {
    adminMotelRoomController = AdminMotelRoomController(
      isTower: isTower,
      towerId: towerId,
      isSupportTower: isSupportTower,
      isFromTower: isFromTower,
    );
  }

  final bool? isTower;
  final int? towerId;
  final Tower? tower;
  final bool? isSupportTower;
  final bool? isFromTower;
  late AdminMotelRoomController adminMotelRoomController;

  @override
  State<AdminMotelRoomScreen> createState() => _AdminMotelRoomScreenState();
}

class _AdminMotelRoomScreenState extends State<AdminMotelRoomScreen>
    with SingleTickerProviderStateMixin {
  RefreshController refreshController = RefreshController();
  late TabController _tabController;
  int tabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
          title: widget.tower == null
              ? Obx(() => Text(
                    widget.adminMotelRoomController.userChoose.value.id != null
                        ? widget.adminMotelRoomController.userChoose.value
                                .name ??
                            ''
                        : "Phòng đơn",
                  ))
              : Text(widget.tower!.towerName!),
          centerTitle: true,
          actions: [
            if (widget.isTower != true)
              IconButton(
                  onPressed: () {
                    Get.to(() => UserFilterScreen(
                        isShowTab: false,
                        idChoose:
                            widget.adminMotelRoomController.userChoose.value.id,
                        onChoose: (user) {
                          widget.adminMotelRoomController.userChoose.value =
                              user;
                          widget.adminMotelRoomController
                              .getAllAdminMotelRoom(isRefresh: true);
                          Get.back();
                        }));
                  },
                  icon: Obx(() => Icon(
                      widget.adminMotelRoomController.userChoose.value.id !=
                              null
                          ? Icons.filter_alt
                          : Icons.filter_alt_outlined,
                      color:
                          widget.adminMotelRoomController.userChoose.value.id !=
                                  null
                              ? Colors.blue
                              : null))),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddMotelRoomScreen(
                      isHaveTower: widget.isTower,
                      towerInput: widget.tower,
                    ))!
                .then((value) => {
                      widget.adminMotelRoomController
                          .getAllAdminMotelRoom(isRefresh: true)
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
                        setState(() {
                          tabIndex = v;
                        });
                        if (v == 2) {
                          widget.adminMotelRoomController.status = 3;
                          widget.adminMotelRoomController
                              .getAllAdminMotelRoom(isRefresh: true);
                        } else {
                          widget.adminMotelRoomController.hasContract.value =
                              (v == 0 ? false : true);
                          widget.adminMotelRoomController.status = null;
                          widget.adminMotelRoomController
                              .getAllAdminMotelRoom(isRefresh: true);
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
                                  color: Colors.orange,
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
                            // text: tabIndex == 0 ? 'Total Rendering: ' : tabIndex == 1 ? 'Total Rendered: ' : 'Total Cancelled: ',
                            text: tabIndex == 0
                                ? 'Tổng phòng chưa thuê: '
                                : tabIndex == 1
                                    ? 'Tổng phòng đã thuê: '
                                    : 'Tổng bản nháp: ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text:
                                '${widget.adminMotelRoomController.total.obs.value}',
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
              hintText: "Tìm kiếm phòng trọ",
              onChanged: (va) {
                EasyDebounce.debounce(
                    'list_motel_room', const Duration(milliseconds: 300), () {
                  widget.adminMotelRoomController.textSearch = va;
                  widget.adminMotelRoomController
                      .getAllAdminMotelRoom(isRefresh: true);
                });
              },
              onClose: () {
                widget.adminMotelRoomController.textSearch = "";
                widget.adminMotelRoomController
                    .getAllAdminMotelRoom(isRefresh: true);
              },
            ),
            Expanded(
              child: Obx(
                () => widget.adminMotelRoomController.loadInit.value
                    ? SahaLoadingFullScreen()
                    : SmartRefresher(
                        footer: CustomFooter(
                          builder: (
                            BuildContext context,
                            LoadStatus? mode,
                          ) {
                            Widget body = Container();
                            if (mode == LoadStatus.idle) {
                              body = Obx(() => widget
                                      .adminMotelRoomController.isLoading.value
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
                          await widget.adminMotelRoomController
                              .getAllAdminMotelRoom(isRefresh: true);
                          refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await widget.adminMotelRoomController
                              .getAllAdminMotelRoom();
                          refreshController.loadComplete();
                        },
                        child: ListView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemCount: widget
                                .adminMotelRoomController.listMotelRoom.length,
                            itemBuilder: (BuildContext context, int index) {
                              return roomItem(widget.adminMotelRoomController
                                  .listMotelRoom[index]);
                            }),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget itemMotelRoom({required MotelRoom motelRoom, context}) {
  //   return GestureDetector(
  //     onTap: () {
  //       Get.to(() => AddMotelRoomScreen(motelRoomInput: motelRoom))!.then(
  //           (value) =>
  //               adminMotelRoomController.getAllAdminMotelRoom(isRefresh: true));
  //     },
  //     child: Container(
  //       margin: const EdgeInsets.all(10),
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
  //                     ? "https://webcolours.ca/wp-content/uploads/2020/10/webcolours-unknown.png"
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
  //                 Text('Chủ nhà: ${motelRoom.host?.name ?? ''}'),
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
        // Get.to(() => AddMotelRoomScreen(motelRoomInput: item))!.then((value) =>
        //     widget.adminMotelRoomController
        //         .getAllAdminMotelRoom(isRefresh: true));
        Get.to(() => RoomInformationScreen(
                  roomPostId: item.id,
                  editButton: IconButton(
                    onPressed: () {
                      Get.to(() => AddMotelRoomScreen(motelRoomInput: item))!
                          .then((value) => widget.adminMotelRoomController
                              .getAllAdminMotelRoom(isRefresh: true));
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ))!
            .then((value) => Get.find<HomeController>().getAllHomeApp());
      },
      child: Stack(
        children: [
          Opacity(
            opacity: item.isHidden == true ? 0.5 : 1,
            child: Container(
              margin:
                  const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
              decoration: BoxDecoration(
                color: item.isHidden == true
                    ? Colors.grey.withOpacity(0.5)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  if (item.isHidden == false) BoxShadow(
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
                        child: CachedNetworkImage(
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                          imageUrl: (item.images ?? []).isEmpty
                              ? ""
                              : item.images![0],
                          //placeholder: (context, url) => SahaLoadingWidget(),
                          errorWidget: (context, url, error) =>
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
                        Text('Chủ nhà: ${item.host?.name ?? ''}'),
                        Text('Tên phòng: ${item.motelName ?? ''}'),
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
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
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
          ),
          if (item.status == 3)
            Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    'Bản nháp',
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          else if (item.status == 0)
            Positioned(
              right: 10.0,
              top: 20.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (item.isHidden != true) {
                        SahaDialogApp.showDialogYesNo(
                            mess: "Bạn chắc chắn muốn ẩn phòng không?",
                            onOK: () {
                              widget.adminMotelRoomController
                                  .updateMotelRoomHiddenStatus(
                                motelId: item.id!,
                                status: 0,
                                towerMotelId: item.towerId!,
                              );
                            });
                      } else {
                        SahaDialogApp.showDialogYesNo(
                            mess: "Bạn chắc chắn muốn hiện lại phòng không?",
                            onOK: () {
                              widget.adminMotelRoomController
                                  .updateMotelRoomHiddenStatus(
                                motelId: item.id!,
                                status: 1,
                                towerMotelId: item.towerId!,
                              );
                            });
                      }
                    },
                    child: item.isHidden == true
                        ? const Icon(
                            Icons.visibility_off,
                            color: Colors.red,
                            size: 28,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: Colors.red,
                      size: 28,
                          ),
                  ),
                  item.isHidden == true
                      ? const Text(
                          "Hiện",
                          style: TextStyle(color: Colors.red),
                        )
                      : const Text(
                          "Ẩn",
                          style: TextStyle(color: Colors.red),
                        ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
