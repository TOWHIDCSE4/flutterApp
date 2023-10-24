import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../components/dialog/dialog.dart';
import '../../../components/empty/saha_empty_image.dart';
import '../../../components/loading/loading_full_screen.dart';
import '../../../components/text_field/rice_text_field.dart';
import '../../../components/text_field/saha_text_field_search.dart';
import '../../../const/motel_type.dart';
import '../../../model/motel_post.dart';
import '../../../utils/date_utils.dart';
import '../../../utils/debounce.dart';
import 'choose_room_chat_controller.dart';

class ChooseRoomChatScreen extends StatefulWidget {
  int? initTab;
  bool? isNext;
  Function onChoose;
  ChooseRoomChatScreen(
      {Key? key, this.initTab, this.isNext, required this.onChoose})
      : super(key: key);

  @override
  State<ChooseRoomChatScreen> createState() => _ChooseRoomChatScreenState();
}

class _ChooseRoomChatScreenState extends State<ChooseRoomChatScreen> {
  ChooseRoomChatController listPostManagementController =
      ChooseRoomChatController();
  RefreshController refreshController = RefreshController();
  late TabController _tabController;

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
          title: Obx(
            () => listPostManagementController.isSearch.value == true
                ? Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white,
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          listPostManagementController.textSearch = value;
                          listPostManagementController.getPostManagement(
                              isRefresh: true);
                        },
                        controller: listPostManagementController.searchEdit,
                        autofocus: listPostManagementController.isSearch.value
                            ? true
                            : false,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.only(
                              right: 15, top: 20, bottom: 5),
                          border: InputBorder.none,
                          hintText: "Tìm kiếm",
                          suffixIcon: IconButton(
                            onPressed: () {
                              listPostManagementController.searchEdit.clear();
                              listPostManagementController
                                  .listPostManagement([]);
                              listPostManagementController.textSearch = '';
                              listPostManagementController.getPostManagement(
                                  isRefresh: true);
                              FocusScope.of(context).unfocus();

                              listPostManagementController.isSearch.value =
                                  false;
                            },
                            icon: const Icon(
                              Icons.clear,
                              size: 15,
                            ),
                          ),
                        ),
                        onChanged: (v) {
                          EasyDebounce.debounce(
                              'debounce_timer_chatlist_search',
                              const Duration(milliseconds: 500), () {
                            listPostManagementController.textSearch = v;
                            listPostManagementController.getPostManagement(
                                isRefresh: true);

                            // if (v == '') {
                            //   chatListController.listBoxChatSearch([]);
                            // } else {
                            //   chatListController.textSearch = v;
                            //   chatListController.getAllBoxChat(isRefresh: true);
                            // }
                          });
                        },
                        minLines: 1,
                        maxLines: 1,
                      ),
                    ),
                  )
                : const Text('Bài đăng'),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  if (listPostManagementController.isSearch.value == false) {
                    listPostManagementController.isSearch.value = true;
                  } else {
                    listPostManagementController.isSearch.value = false;
                  }
                }),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Stack(
                          children: [
                            Center(
                              child: Text(
                                'Lọc',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Positioned(
                                top: -5,
                                left: -5,
                                child: IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.clear)))
                          ],
                        ),
                        content: Stack(
                          children: [
                            SizedBox(
                              width: Get.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    color: Colors.white,
                                    //padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Obx(
                                          () => Text(
                                              'Giá từ ${SahaStringUtils().convertToMoney(listPostManagementController.rangePriceValue.value.start.round().toString())}đ đến ${SahaStringUtils().convertToMoney(listPostManagementController.rangePriceValue.value.end.round().toString())}đ'),
                                        ),
                                        Obx(
                                          () => RangeSlider(
                                              values:
                                                  listPostManagementController
                                                      .rangePriceValue.value,
                                              max: 20000000,
                                              divisions: 40,
                                              onChanged: (RangeValues v) {
                                                listPostManagementController
                                                    .rangePriceValue.value = v;
                                                listPostManagementController
                                                        .moneyFrom =
                                                    listPostManagementController
                                                        .rangePriceValue
                                                        .value
                                                        .start
                                                        .toString();
                                                listPostManagementController
                                                        .moneyTo =
                                                    listPostManagementController
                                                        .rangePriceValue
                                                        .value
                                                        .end
                                                        .toString();
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Thành phố"),
                                      Container(
                                        width: 180,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            SahaDialogApp
                                                .showDialogAddressChoose(
                                                    hideAll: true,
                                                    callback: (v) {
                                                      if (v.id != null) {
                                                        listPostManagementController
                                                            .province = v.id;
                                                        listPostManagementController
                                                            .provicenName
                                                            .text = v.name;
                                                        Get.back();
                                                      }
                                                    },
                                                    accept: () {});
                                          },
                                          child: RiceTextField(
                                            enabled: false,
                                            textAlign: TextAlign.center,
                                            controller:
                                                listPostManagementController
                                                    .provicenName,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Quận/huyện'),
                                      Container(
                                        width: 180,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            if (listPostManagementController
                                                    .province ==
                                                null) {
                                              SahaAlert.showError(
                                                  message:
                                                      "Bạn chưa chọn thành phố");
                                              return;
                                            }
                                            SahaDialogApp
                                                .showDialogAddressChoose(
                                                    hideAll: true,
                                                    idProvince:
                                                        listPostManagementController
                                                            .province,
                                                    callback: (v) {
                                                      if (v.id != null) {
                                                        listPostManagementController
                                                            .district = v.id;
                                                        listPostManagementController
                                                            .districtName
                                                            .text = v.name;
                                                        Get.back();
                                                      }
                                                    },
                                                    accept: () {});
                                          },
                                          child: RiceTextField(
                                            enabled: false,
                                            textAlign: TextAlign.center,
                                            controller:
                                                listPostManagementController
                                                    .districtName,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      listPostManagementController
                                          .getPostManagement(isRefresh: true);
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: const Center(
                                          child: Text(
                                        'Áp dụng',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.filter_alt_outlined,
                )),
          ],
        ),
        floatingActionButton: InkWell(
          onTap: () {
            if( listPostManagementController.listRoomChoosed.isEmpty){
              SahaAlert.showError(message: "Chưa chọn bài đăng nào");
              return;
            }
            widget.onChoose(
                listPostManagementController.listRoomChoosed.toList());
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FontAwesomeIcons.paperPlane,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'SEND',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 17),
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => listPostManagementController.loadInit.value
                    ? SahaLoadingFullScreen()
                    : listPostManagementController.listPostManagement.isEmpty
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
                                  body = Obx(() => listPostManagementController
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
                              await listPostManagementController
                                  .getPostManagement(isRefresh: true);
                              refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              await listPostManagementController
                                  .getPostManagement();
                              refreshController.loadComplete();
                            },
                            child: ListView.builder(
                                addAutomaticKeepAlives: false,
                                addRepaintBoundaries: false,
                                itemCount: listPostManagementController
                                    .listPostManagement.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return postItem(listPostManagementController
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
    double? minMoney;
    double? maxMoney;
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
    return GestureDetector(
      onTap: () {
        if (listPostManagementController.listRoomChoosed
            .map((e) => e.id)
            .contains(item.id)) {
          listPostManagementController.listRoomChoosed
              .removeWhere((e) => e.id == item.id);
        } else {
          listPostManagementController.listRoomChoosed.add(item);
        }
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
            Obx(
              () => Checkbox(
                  value: listPostManagementController.listRoomChoosed
                      .map((e) => e.id)
                      .contains(item.id),
                  onChanged: (v) {
                    if (listPostManagementController.listRoomChoosed
                        .map((e) => e.id)
                        .contains(item.id)) {
                      listPostManagementController.listRoomChoosed
                          .removeWhere((e) => e.id == item.id);
                    } else {
                      listPostManagementController.listRoomChoosed.add(item);
                    }
                  }),
            ),
            Stack(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: CachedNetworkImage(
                      height: 100,
                      width: 100,
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
                              item.towerId != null
                                  ? '${SahaStringUtils().convertToMoney(minMoney ?? 0)}-${SahaStringUtils().convertToMoney(maxMoney ?? 0)}đ'
                                  : '${SahaStringUtils().convertToMoney(item.money ?? 0)} VNĐ/${typeUnitRoom[item.type ?? 0]}',
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
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 8,
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(item.towerId != null ? "Tên toà nhà: ${item.towerName ?? ""}" : "Số/tên phòng: ${item.motelName ?? ''}",style:  TextStyle(color: Theme.of(context).primaryColor,fontSize: 12,),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${SahaDateUtils().getDDMMYY(item.createdAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(item.createdAt ?? DateTime.now())}'),
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
