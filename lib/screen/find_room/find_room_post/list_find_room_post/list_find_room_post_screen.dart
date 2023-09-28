import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/post_find_room.dart';
import 'package:gohomy/screen/find_room/find_room_post/list_find_room_post/list_find_room_post_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/dialog/dialog.dart';
import '../../../../const/motel_type.dart';
import '../../../../model/location_address.dart';
import '../../../../utils/debounce.dart';
import '../../../../utils/string_utils.dart';
import '../../../data_app_controller.dart';
import '../post_find_room_screen.dart';


class ListFindRoomPostScreen extends StatefulWidget {
   ListFindRoomPostScreen({super.key, 
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
  State<ListFindRoomPostScreen> createState() => _ListFindRoomPostScreenState();
}

class _ListFindRoomPostScreenState extends State<ListFindRoomPostScreen> {
  TextEditingController searchEditingController = TextEditingController();
  TextEditingController fromMoneyEditingController = TextEditingController();
  TextEditingController maxMoneyEditingController = TextEditingController();
  late ListFindRoomPostController controller;
  final ScrollController _scrollController = ScrollController();
  RefreshController refreshController = RefreshController();
  DataAppController dataAppController = Get.find();
   @override
  void initState() {
    super.initState();
    controller = ListFindRoomPostController(
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
                      'find_room_screen', const Duration(milliseconds: 300), () {
                    controller.textSearch = v;
                    controller.getAllPostFindRoom(isRefresh: true);
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
                      SahaDialogApp.showFilterPostFindRoom(
                          motelPostReqInput: controller.motelPostFilter.value,
                          onAccept: (v) {
                            controller.motelPostFilter.value = v;
                            controller.getAllPostFindRoom(isRefresh: true);
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
                                  controller.locationProvince
                                      .value = LocationAddress();
                                  controller.locationDistrict
                                      .value = LocationAddress();
                                  controller.locationWard.value =
                                      LocationAddress();
                                  controller.getAllPostFindRoom(
                                      isRefresh: true);
                                  Get.back();
                                } else {
                                  controller
                                      .locationProvince.value = v;
                                  controller.locationDistrict
                                      .value = LocationAddress();
                                  controller.locationWard.value =
                                      LocationAddress();

                                  controller.getAllPostFindRoom(
                                    isRefresh: true,
                                  );
                                  Get.back();
                                  SahaDialogApp.showDialogAddressChoose(
                                    accept: () {},
                                    idProvince: controller
                                        .locationProvince.value.id,
                                    callback: (v) {
                                      if (v.name == 'Tất cả') {
                                        Get.back();
                                      } else {
                                        controller
                                            .locationDistrict.value = v;
                                        controller.getAllPostFindRoom(
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
                                              controller
                                                  .locationWard.value = v;
                                              controller
                                                  .getAllPostFindRoom(
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
                                  var province =
                                      controller.locationProvince;
                                  var district =
                                      controller.locationDistrict;
                                  var ward =
                                      controller.locationWard;
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
                      const SizedBox(
                        width: 10,
                      ),
                      // InkWell(
                      //     onTap: () {
                      //       SahaDialogApp.showBottomFilter(
                      //           motelPostReqInput: controller
                      //               .motelPostFilter.value,
                      //           onAccept: (v) {
                      //             findRoomLoginController
                      //                 .motelPostFilter.value = v;
                      //             findRoomLoginController.getAllRoomPost(
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
              await controller.getAllPostFindRoom(isRefresh: true);
              refreshController.refreshCompleted();
            },
            onLoading: () async {
              await controller.getAllPostFindRoom();
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
                itemCount:
                    controller.listRoomPost.length,
                itemBuilder: (BuildContext context, int index) {
                 
                  return itemPost(controller.listRoomPost[index]
                     );
                }),
          ),
        ),
      ),
    );
  }

  Widget itemPost(PostFindRoom postFindRoom){
    return InkWell(
      onTap: (){
        Get.to(()=>PostFindRoomScreen(postFindRoomId: postFindRoom.id!,));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              (postFindRoom.title ?? "").toUpperCase(),
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
                        '${SahaStringUtils().convertToMoney(postFindRoom.moneyFrom ?? 0)} - ${SahaStringUtils().convertToMoney(postFindRoom.moneyTo ?? 0)} VNĐ/${typeUnitRoom[postFindRoom.type ?? 0]}',
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
                          dataAppController.isLogin.value != true ? "${postFindRoom.districtName ?? ""}${postFindRoom.districtName != null ? ", " : ""}${postFindRoom.provinceName ?? ""}":
                                                    '${postFindRoom.wardsName ?? ""}${postFindRoom.wardsName != null ? ", " : ""}${postFindRoom.districtName ?? ""}${postFindRoom.districtName != null ? ", " : ""}${postFindRoom.provinceName ?? ""}',
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