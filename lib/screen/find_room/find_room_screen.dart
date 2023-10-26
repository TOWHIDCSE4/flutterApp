import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/model/motel_post.dart';
import 'package:gohomy/screen/admin/motel_room_admin/tower/add_tower/map/map_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../components/widget/post_item/post_item.dart';
import '../../model/location_address.dart';
import '../../utils/debounce.dart';
import '../choose_address_customer_screen/choose_address_customer_controller.dart';
import '../data_app_controller.dart';
import 'find_room_controller.dart';

class FindRoomScreen extends StatefulWidget {
  FindRoomScreen({
    Key? key,
    this.typeAddress,
    this.locationProvince,
    this.locationDistrict,
    this.callback,
    this.phoneNumber,
    this.isNewest,
  }) : super(key: key);

  final TypeAddress? typeAddress;
  LocationAddress? locationProvince;
  LocationAddress? locationDistrict;
  final Function? callback;
  String? phoneNumber;
  bool? isNewest;

  late ChooseAddressCustomerController chooseAddressCustomerController;

  @override
  State<FindRoomScreen> createState() => _FindRoomLoginScreenState();
}

class _FindRoomLoginScreenState extends State<FindRoomScreen> {
  TextEditingController searchEditingController = TextEditingController();
  TextEditingController fromMoneyEditingController = TextEditingController();
  TextEditingController maxMoneyEditingController = TextEditingController();
  late FindRoomController findRoomLoginController;
  final ScrollController _scrollController = ScrollController();
  RefreshController refreshController = RefreshController();
  DataAppController dataAppController = Get.find();

  @override
  void initState() {
    super.initState();
    findRoomLoginController = FindRoomController(
      isNewest: widget.isNewest,
      locationProvinceInput: widget.locationProvince,
      locationDistrictInput: widget.locationDistrict,
      typeAddress: widget.typeAddress,
      phoneNumber: widget.phoneNumber,
    );
    // _scrollController.addListener(() {
    //   if (_scrollController.offset > 500) {
    //     findRoomLoginController.changeOpacitySearch(1);
    //     _visible.value = false;
    //   } else {
    //     findRoomLoginController
    //         .changeOpacitySearch(_scrollController.offset / 100);
    //     _visible.value = true;
    //   }
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              colors: <Color>[Colors.deepOrange, Colors.orange],
            ),
          ),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        titleSpacing: 0.0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: searchEditingController,
                  decoration: InputDecoration(
                    hintText: 'Tìm theo quận, địa điểm',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(5),
                    suffixIcon: IconButton(
                      onPressed: () {
                        Get.to(() => MapScreen(
                              selectedAddress: (selectedAddress) {
                                findRoomLoginController.textSearch =
                                    selectedAddress;
                                print('Selected address: $selectedAddress');
                                searchEditingController.text = selectedAddress;
                                findRoomLoginController.getAllRoomPost(
                                  isRefresh: true,
                                );
                              },
                            ));
                      },
                      icon: Icon(
                        Icons.location_on,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  onChanged: (v) async {
                    EasyDebounce.debounce(
                        'find_room_screen', const Duration(milliseconds: 300),
                        () {
                      findRoomLoginController.textSearch = v;
                      findRoomLoginController.getAllRoomPost(isRefresh: true);
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      SahaDialogApp.showBottomFilter(
                          motelPostReqInput:
                              findRoomLoginController.motelPostFilter.value,
                          onAccept: (v) {
                            findRoomLoginController.motelPostFilter.value = v;
                            findRoomLoginController.getAllRoomPost(
                                isRefresh: true);
                          });
                    },
                    child: const Icon(Icons.filter_alt_outlined),
                  ),
                  const Text(
                    "Bộ lọc",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
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
                                  findRoomLoginController.locationProvince
                                      .value = LocationAddress();
                                  findRoomLoginController.locationDistrict
                                      .value = LocationAddress();
                                  findRoomLoginController.locationWard.value =
                                      LocationAddress();
                                  findRoomLoginController.getAllRoomPost(
                                      isRefresh: true);
                                  Get.back();
                                } else {
                                  findRoomLoginController
                                      .locationProvince.value = v;
                                  findRoomLoginController.locationDistrict
                                      .value = LocationAddress();
                                  findRoomLoginController.locationWard.value =
                                      LocationAddress();

                                  findRoomLoginController.getAllRoomPost(
                                    isRefresh: true,
                                  );
                                  Get.back();
                                  SahaDialogApp.showDialogAddressChoose(
                                    accept: () {},
                                    idProvince: findRoomLoginController
                                        .locationProvince.value.id,
                                    callback: (v) {
                                      if (v.name == 'Tất cả') {
                                        Get.back();
                                      } else {
                                        findRoomLoginController
                                            .locationDistrict.value = v;
                                        findRoomLoginController.getAllRoomPost(
                                          isRefresh: true,
                                        );
                                        Get.back();
                                        SahaDialogApp.showDialogAddressChoose(
                                          accept: () {},
                                          idDistrict: findRoomLoginController
                                              .locationDistrict.value.id,
                                          callback: (v) {
                                            if (v.name == 'Tất cả') {
                                              Get.back();
                                            } else {
                                              findRoomLoginController
                                                  .locationWard.value = v;
                                              findRoomLoginController
                                                  .getAllRoomPost(
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
                                      findRoomLoginController.locationProvince;
                                  var district =
                                      findRoomLoginController.locationDistrict;
                                  var ward =
                                      findRoomLoginController.locationWard;
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
              await findRoomLoginController.getAllRoomPost(isRefresh: true);
              refreshController.refreshCompleted();
            },
            onLoading: () async {
              await findRoomLoginController.getAllRoomPost();
              refreshController.loadComplete();
            },
            footer: CustomFooter(
              builder: (
                BuildContext context,
                LoadStatus? mode,
              ) {
                Widget body = Container();
                if (mode == LoadStatus.idle) {
                  body = Obx(() => findRoomLoginController.isLoading.value
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
                    (findRoomLoginController.listAllRoomPost.length / 2).ceil(),
                itemBuilder: (BuildContext context, int index) {
                  var length = findRoomLoginController.listAllRoomPost.length;
                  var index1 = index * 2;
                  return itemRoom(
                      motelPost1:
                          findRoomLoginController.listAllRoomPost[index1],
                      motelPost2: length <= (index1 + 1)
                          ? null
                          : findRoomLoginController
                              .listAllRoomPost[index1 + 1]);
                }),
          ),
        ),
      ),
    );
  }

  Widget itemRoom({
    required MotelPost motelPost1,
    required MotelPost? motelPost2,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          PostItem(
            post: motelPost1,
            isLogin: dataAppController.isLogin.value,
            height: 350,
          ),
          if (motelPost2 != null)
            PostItem(
              post: motelPost2,
              isLogin: dataAppController.isLogin.value,
              height: 350,
            ),
        ],
      ),
    );
  }
}
