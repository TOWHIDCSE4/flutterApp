import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/post_roommate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/dialog/dialog.dart';
import '../../../../components/widget/post_item/post_find_room_item.dart';
import '../../../../model/location_address.dart';
import '../../../../utils/debounce.dart';
import '../../../data_app_controller.dart';
import 'list_post_roommate_controller.dart';

class ListPostRoommateScreen extends StatefulWidget {
  ListPostRoommateScreen(
      {super.key,
      this.locationProvince,
      this.locationDistrict,
      this.callback,
      this.phoneNumber,
      this.isNewest});
  LocationAddress? locationProvince;
  LocationAddress? locationDistrict;
  final Function? callback;
  String? phoneNumber;
  bool? isNewest;

  @override
  State<ListPostRoommateScreen> createState() => _ListPostRoommateScreenState();
}

class _ListPostRoommateScreenState extends State<ListPostRoommateScreen> {
  TextEditingController searchEditingController = TextEditingController();
  TextEditingController fromMoneyEditingController = TextEditingController();
  TextEditingController maxMoneyEditingController = TextEditingController();
  late ListPostRoommateController controller;
  final ScrollController _scrollController = ScrollController();
  RefreshController refreshController = RefreshController();
  DataAppController dataAppController = Get.find();

  @override
  void initState() {
    super.initState();
    controller = ListPostRoommateController(
      isNewest: widget.isNewest,
      locationProvinceInput: widget.locationProvince,
      locationDistrictInput: widget.locationDistrict,
      phoneNumber: widget.phoneNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
               width: Get.width/1.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: searchEditingController,
                decoration: const InputDecoration(
                    hintText: 'Tìm theo quận, địa điểm',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(5)),
                onChanged: (v) async {
                  EasyDebounce.debounce(
                      'find_room_screen', const Duration(milliseconds: 300),
                      () {
                    controller.textSearch = v;
                    controller.getAllPostRoommate(isRefresh: true);
                  });
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                InkWell(
                    onTap: () {
                      SahaDialogApp.showFilterPostRoommate(
                          motelPostReqInput: controller.motelPostFilter.value,
                          onAccept: (v) {
                            controller.motelPostFilter.value = v;
                            controller.getAllPostRoommate(isRefresh: true);
                          });
                    },
                    child: const Icon(Icons.filter_alt_outlined)),
                const Text(
                  "Bộ lọc",
                  style: TextStyle(fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              backgroundColor: Colors.white,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            SahaDialogApp.showDialogAddressChoose(
                              accept: () {},
                              callback: (v) {
                                if (v.name == 'Tất cả') {
                                  controller.locationProvince.value =
                                      LocationAddress();
                                  controller.locationDistrict.value =
                                      LocationAddress();
                                  controller.locationWard.value =
                                      LocationAddress();
                                  controller.getAllPostRoommate(
                                      isRefresh: true);
                                  Get.back();
                                } else {
                                  controller.locationProvince.value = v;
                                  controller.locationDistrict.value =
                                      LocationAddress();
                                  controller.locationWard.value =
                                      LocationAddress();

                                  controller.getAllPostRoommate(
                                    isRefresh: true,
                                  );
                                  Get.back();
                                  SahaDialogApp.showDialogAddressChoose(
                                    accept: () {},
                                    idProvince:
                                        controller.locationProvince.value.id,
                                    callback: (v) {
                                      if (v.name == 'Tất cả') {
                                        Get.back();
                                      } else {
                                        controller.locationDistrict.value = v;
                                        controller.getAllPostRoommate(
                                          isRefresh: true,
                                        );
                                        Get.back();
                                        SahaDialogApp.showDialogAddressChoose(
                                          accept: () {},
                                          idDistrict: controller
                                              .locationDistrict.value.id,
                                          callback: (v) {
                                            if (v.name == 'Tất cả') {
                                              Get.back();
                                            } else {
                                              controller.locationWard.value = v;
                                              controller.getAllPostRoommate(
                                                isRefresh: true,
                                              );
                                              Get.back();
                                            }
                                          },
                                        );
                                      }
                                    },
                                  );
                                }
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Obx(() {
                                  var province = controller.locationProvince;
                                  var district = controller.locationDistrict;
                                  var ward = controller.locationWard;
                                  return province.value.id != null ||
                                          district.value.id != null ||
                                          ward.value.id != null
                                      ? Text(
                                          'Khu vực: ${ward.value.name ?? ""}${ward.value.name != null ? ", " : ""}${district.value.name ?? ""}${district.value.name != null ? ", " : ""}${province.value.name ?? ""}')
                                      : const Text('Khu vực: Toàn quốc');
                                }),
                              ),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      // InkWell(
                      //     onTap: () {
                      //       SahaDialogApp.showFilterPostRoommate(
                      //           motelPostReqInput: controller
                      //               .motelPostFilter.value,
                      //           onAccept: (v) {
                      //             controller
                      //                 .motelPostFilter.value = v;
                      //             controller.getAllPostRoommate(
                      //                 isRefresh: true);
                      //           });
                      //     },
                      //     child: const Icon(Icons.filter_alt_outlined))
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Obx(
          () => SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: const MaterialClassicHeader(),
            onRefresh: () async {
              await controller.getAllPostRoommate(isRefresh: true);
              refreshController.refreshCompleted();
            },
            onLoading: () async {
              await controller.getAllPostRoommate();
              refreshController.loadComplete();
            },
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
            child: ListView.builder(
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                itemCount: (controller.listAllPostRoommate.length / 2).ceil(),
                itemBuilder: (BuildContext context, int index) {
                  var length = controller.listAllPostRoommate.length;
                  var index1 = index * 2;
                  return itemRoom(
                      post1: controller.listAllPostRoommate[index1],
                      post2: length <= (index1 + 1)
                          ? null
                          : controller.listAllPostRoommate[index1 + 1]);
                }),
          ),
        ),
      ),
    );
  }

  Widget itemRoom({
    required PostRoommate post1,
    required PostRoommate? post2,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          PostFindRoomItem(
            post: post1,
          ),
          if (post2 != null)
            PostFindRoomItem(
              post: post2,
            ),
        ],
      ),
    );
  }
}
