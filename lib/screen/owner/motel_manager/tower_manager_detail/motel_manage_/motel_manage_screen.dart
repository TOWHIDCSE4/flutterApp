import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../components/empty/saha_empty_image.dart';
import '../../../../../const/motel_type.dart';
import '../../../../../model/motel_room.dart';
import '../../../../../model/tower.dart';
import '../../../../../utils/string_utils.dart';
import '../../../motel_room/add_motel_room/add_motel_room_screen.dart';
import 'motel_manage_controller.dart';

class MotelManageScreen extends StatefulWidget {
   MotelManageScreen({super.key, required this.tower,this.isSupportTower,required this.supportId}){
       controller = MotelManageController(
        isSupportTower: isSupportTower,towerId: tower.id,supportId: supportId);
   }
  final Tower tower;
  final int supportId;
  
  late MotelManageController controller;
   final bool? isSupportTower;

  @override
  State<MotelManageScreen> createState() => _MotelManageScreenState();
}

class _MotelManageScreenState extends State<MotelManageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  RefreshController refreshController = RefreshController();
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: widget.tower.towerName ?? '',
      ),
      body:Column(
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
                      widget.controller.hasContract.value = v == 0 ? false : true;
                      widget.controller.getAllMotelSupport(isRefresh: true);
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
                   
                    ],
                  ),
                ),
              ),
            ],
          ),
   
          Obx(
            ()=> Expanded(
              child: SmartRefresher(
                footer: CustomFooter(
                  builder: (
                    BuildContext context,
                    LoadStatus? mode,
                  ) {
                    Widget body = Container();
                    if (mode == LoadStatus.idle) {
                      body = Obx(() =>
                          widget.controller.isLoading.value
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
                  await widget.controller
                      .getAllMotelSupport(isRefresh: true);
                  refreshController.refreshCompleted();
                },
                onLoading: () async {
                  await widget.controller.getAllMotelSupport();
                  refreshController.loadComplete();
                },
                controller: refreshController,
                child: ListView.builder(
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          itemCount:  widget.controller.listMotelRoom.length,
                          itemBuilder: (BuildContext context, int index) {
                            return roomItem( widget.controller.listMotelRoom[index]);
                          }),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget roomItem(MotelRoom item) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddMotelRoomScreen(
                  motelRoomInput: item,
                ))!
            .then((value) => {
                  widget.controller
                      .getAllMotelSupport(isRefresh: true)
                });
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
                     ((item.images ?? []).isNotEmpty
                                    ? item.images![0]
                                    : "") +
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
