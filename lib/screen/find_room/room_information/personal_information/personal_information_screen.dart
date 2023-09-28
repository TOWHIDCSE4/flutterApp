import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_container.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/find_room/room_information/personal_information/personal_information_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/dialog/dialog.dart';
import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/widget/image/show_image.dart';
import '../../../../components/widget/post_item/post_item.dart';
import '../../../../model/location_address.dart';
import '../../../../model/motel_post.dart';
import '../../../../model/user.dart';
import '../../../choose_address_customer_screen/choose_address_customer_controller.dart';
import '../../../data_app_controller.dart';

class PersonalInformationScreen extends StatefulWidget {
  PersonalInformationScreen(
      {super.key,
      this.typeAddress,
      this.locationProvince,
      this.locationDistrict,
      this.callback,
      this.phoneNumber,
      this.isNewest,
      required this.user,
      this.isHost,
      this.isFromPost}) {}

  final TypeAddress? typeAddress;
  LocationAddress? locationProvince;
  LocationAddress? locationDistrict;
  final Function? callback;
  String? phoneNumber;
  bool? isNewest;
  User user;
  bool? isHost;
  bool? isFromPost;

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  late PersonalInformationController personalInformationController;

  RefreshController refreshController = RefreshController();
  DataAppController dataAppController = Get.find();

  @override
  void initState() {
    super.initState();
    personalInformationController = PersonalInformationController(
        isNewest: widget.isNewest,
        locationProvinceInput: widget.locationProvince,
        locationDistrictInput: widget.locationDistrict,
        typeAddress: widget.typeAddress,
        phoneNumber: widget.phoneNumber,
        isHost: widget.isHost);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isHost == false ? "Thông tin cá nhân" : 'Thông tin chủ trọ'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              if (widget.user.id != 1) {
                return;
              }
              ShowImage.seeImage(
                  listImageUrl: [widget.user.avatarImage], index: 0);
            },
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: CachedNetworkImage(
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  imageUrl: widget.user.avatarImage ?? '',
                  // placeholder: (context, url) =>
                  //     SahaLoadingWidget(),
                  errorWidget: (context, url, error) => const SahaEmptyAvata(
                    height: 60,
                    width: 60,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          item(
              icon: const Icon(Icons.person),
              title: widget.user.name ?? '',
              isDidKyc: widget.user.cmndNumber != null),
          item(
              icon: const Icon(Icons.phone),
              title: dataAppController.isLogin.value == true
                  ? (widget.user.phoneNumber ?? '')
                  : '${(widget.user.phoneNumber ?? '').substring(0, 7)}***'),
          item(icon: const Icon(Icons.email), title: widget.user.email ?? ''),
          const SizedBox(
            height: 10,
          ),
          if (widget.isHost != false)
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Danh sách tin đã đăng',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          if (widget.isHost != false)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogAddressChoose(
                          accept: () {},
                          callback: (v) {
                            if (v.name == 'Tất cả') {
                              personalInformationController
                                  .locationProvince.value = LocationAddress();
                              personalInformationController
                                  .locationDistrict.value = LocationAddress();
                              personalInformationController.locationWard.value =
                                  LocationAddress();
                              personalInformationController.getAllRoomPost(
                                  isRefresh: true);
                              Get.back();
                            } else {
                              personalInformationController
                                  .locationProvince.value = v;
                              personalInformationController
                                  .locationDistrict.value = LocationAddress();
                              personalInformationController.locationWard.value =
                                  LocationAddress();

                              personalInformationController.getAllRoomPost(
                                isRefresh: true,
                              );
                              Get.back();
                              SahaDialogApp.showDialogAddressChoose(
                                accept: () {},
                                idProvince: personalInformationController
                                    .locationProvince.value.id,
                                callback: (v) {
                                  if (v.name == 'Tất cả') {
                                    Get.back();
                                  } else {
                                    personalInformationController
                                        .locationDistrict.value = v;
                                    personalInformationController
                                        .getAllRoomPost(
                                      isRefresh: true,
                                    );
                                    Get.back();
                                    SahaDialogApp.showDialogAddressChoose(
                                      accept: () {},
                                      idDistrict: personalInformationController
                                          .locationDistrict.value.id,
                                      callback: (v) {
                                        if (v.name == 'Tất cả') {
                                          Get.back();
                                        } else {
                                          personalInformationController
                                              .locationWard.value = v;
                                          personalInformationController
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
                              var province = personalInformationController
                                  .locationProvince;
                              var district = personalInformationController
                                  .locationDistrict;
                              var ward =
                                  personalInformationController.locationWard;
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
                  InkWell(
                      onTap: () {
                        SahaDialogApp.showBottomFilter(
                            motelPostReqInput: personalInformationController
                                .motelPostFilter.value,
                            onAccept: (v) {
                              personalInformationController
                                  .motelPostFilter.value = v;
                              personalInformationController.getAllRoomPost(
                                  isRefresh: true);
                            });
                      },
                      child: const Icon(Icons.filter_alt_outlined))
                ],
              ),
            ),
          if (widget.isHost != false)
            Obx(
              () => personalInformationController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : Expanded(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        header: const MaterialClassicHeader(),
                        onRefresh: () async {
                          await personalInformationController.getAllRoomPost(
                              isRefresh: true);
                          refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await personalInformationController.getAllRoomPost();
                          refreshController.loadComplete();
                        },
                        footer: CustomFooter(
                          builder: (
                            BuildContext context,
                            LoadStatus? mode,
                          ) {
                            Widget body = Container();
                            if (mode == LoadStatus.idle) {
                              body = Obx(() =>
                                  personalInformationController.isLoading.value
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
                            itemCount: (personalInformationController
                                        .listAllRoomPost.length /
                                    2)
                                .ceil(),
                            itemBuilder: (BuildContext context, int index) {
                              var length = personalInformationController
                                  .listAllRoomPost.length;
                              var index1 = index * 2;
                              return itemRoom(
                                  motelPost1: personalInformationController
                                      .listAllRoomPost[index1],
                                  motelPost2: length <= (index1 + 1)
                                      ? null
                                      : personalInformationController
                                          .listAllRoomPost[index1 + 1]);
                            }),
                      ),
                    ),
            ),

          ////
        ],
      ),
    );
  }

  Widget item({required Widget icon, required String title, bool? isDidKyc}) {
    return Card(
      child: ListTile(
        leading: icon,
        title: Row(
          children: [
            Text(title),
            const SizedBox(
              width: 5,
            ),
            if (isDidKyc == true)
              const Icon(Icons.check_circle, color: Colors.blueAccent)
          ],
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
