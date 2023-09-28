import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/empty/saha_empty_avatar.dart';
import 'package:gohomy/screen/admin/potential_user/potential_detail/potential_detail_screen.dart';
import 'package:gohomy/screen/admin/potential_user/potential_user_controller.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/loading/loading_full_screen.dart';
import '../../../model/potential_user.dart';
import '../../../model/user.dart';
import '../../../utils/call.dart';
import '../../../utils/debounce.dart';
import '../../chat/chat_detail/chat_detail_screen.dart';
import '../../find_room/room_information/room_information_screen.dart';
import '../users/user_filter/user_filter_screen.dart';
import 'add_renter/add_renter_screen.dart';

class PotentialUserScreen extends StatefulWidget {
  PotentialUserScreen({super.key, this.isAdmin});

  bool? isAdmin;

  @override
  State<PotentialUserScreen> createState() => _PotentialUserScreenState();
}

class _PotentialUserScreenState extends State<PotentialUserScreen>
    with SingleTickerProviderStateMixin {
  PotentialUserController potentialController = PotentialUserController();

  RefreshController refreshController = RefreshController();

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
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
          () => potentialController.isSearch.value == true
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
                        potentialController.textSearch = value;
                        potentialController.getAllPotentialUser(
                            isRefresh: true);
                      },
                      controller: potentialController.searchEdit,
                      autofocus:
                          potentialController.isSearch.value ? true : false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                            right: 15, top: 20, bottom: 5),
                        border: InputBorder.none,
                        hintText: "Tìm kiếm",
                        suffixIcon: IconButton(
                          onPressed: () {
                            potentialController.searchEdit.clear();
                            // potentialController.listBoxChatSearch([]);
                            potentialController.textSearch = '';
                            potentialController.getAllPotentialUser(
                                isRefresh: true);
                            FocusScope.of(context).unfocus();

                            potentialController.isSearch.value = false;
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 15,
                          ),
                        ),
                      ),
                      onChanged: (v) {
                        EasyDebounce.debounce('debounce_timer_chatlist_search',
                            const Duration(milliseconds: 500), () {
                          potentialController.textSearch = v;
                          potentialController.getAllPotentialUser(
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
              : const Text('Khách hàng tiềm năng'),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (potentialController.isSearch.value == false) {
                  potentialController.isSearch.value = true;
                } else {
                  potentialController.isSearch.value = false;
                }
              }),
          // if (widget.isAdmin == true)
          //   IconButton(
          //       onPressed: () {
          //         Get.to(() => UserFilterScreen(
          //             isShowTab: false,
          //             idChoose: potentialController.userChoose.value.id,
          //             onChoose: (user) {
          //               potentialController.userChoose.value = user;
          //               potentialController.getAllPotentialUser(
          //                   isRefresh: true);
          //               Get.back();
          //             }));
          //       },
          //       icon: Obx(() => Icon(
          //           potentialController.userChoose.value.id != null
          //               ? Icons.filter_alt
          //               : Icons.filter_alt_outlined,
          //           color: potentialController.userChoose.value.id != null
          //               ? Colors.blue
          //               : null))),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 45,
            // width: Get.width,
            child: ColoredBox(
              color: Colors.white,
              child: TabBar(
                isScrollable: true,
                controller: _tabController,
                onTap: (v) {
                  potentialController.status.value = v == 0 ? 0 : v == 1 ? 4 : v == 2 ? 1: 2;
                  potentialController.getAllPotentialUser(isRefresh: true);
                },
                tabs: const [
                  Tab(
                    child: Text(
                      'Chưa tư vấn',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                      ),
                    ),
                  ),
                     Tab(
                    child: Text(
                      'Đang tư vấn',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Đã từ chối',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Đã từng thuê',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          // SahaTextFieldSearch(
          //   hintText: "Tìm kiếm sản phẩm",
          //   onChanged: (v) {
          //     EasyDebounce.debounce(
          //         'debounce_search_problem', Duration(milliseconds: 300), () {
          //       problemController.textSearch = v;
          //       problemController.getAllProblemAdmin(isRefresh: true);
          //     });
          //   },
          //   onClose: () {
          //     problemController.textSearch = "";
          //     problemController.getAllProblemAdmin(isRefresh: true);
          //   },
          // ),
          // InkWell(
          //   onTap: () {
          //     showDialog(
          //         context: context,
          //         builder: (BuildContext context) {
          //           return AlertDialog(
          //             content: SizedBox(
          //               width: Get.width * 0.9,
          //               height: Get.height * 0.5,
          //               child: SfDateRangePicker(
          //                 onCancel: () {
          //                   Get.back();
          //                 },
          //                 onSubmit: (v) {
          //                   problemController.onOkChooseTime(
          //                       startDate, endDate);
          //                   problemController.getAllProblemAdmin(
          //                       isRefresh: true);
          //                 },
          //                 showActionButtons: true,
          //                 onSelectionChanged: chooseRangeTime,
          //                 selectionMode: DateRangePickerSelectionMode.range,
          //                 initialSelectedRange: PickerDateRange(
          //                   problemController.fromDateOption,
          //                   problemController.toDateOption,
          //                 ),
          //                 maxDate: DateTime.now(),
          //               ),
          //             ),
          //           );
          //         });
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(15.0),
          //     child: Row(
          //       children: [
          //         Obx(() => problemController.checkSelected.value
          //             ? Text(
          //                 "Từ: ${SahaDateUtils().getDDMMYY4(problemController.fromDay.value)} đến ${SahaDateUtils().getDDMMYY4(problemController.toDay.value)}")
          //             : const Text('Chọn khoảng thời gian')),
          //         const Spacer(),
          //         const Icon(Icons.keyboard_arrow_down_rounded)
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: Obx(
              () => potentialController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : potentialController.listPotential.isEmpty
                      ? const Center(
                          child: Text('Không có khách nào'),
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
                                body = Obx(() =>
                                    potentialController.isLoading.value
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
                            await potentialController.getAllPotentialUser(
                                isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await potentialController.getAllPotentialUser();
                            refreshController.loadComplete();
                          },
                          child: ListView.builder(
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              itemCount:
                                  potentialController.listPotential.length,
                              itemBuilder: (BuildContext context, int index) {
                                return itemPotentialUser(
                                    potentialController.listPotential[index]);
                              }),
                        ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemPotentialUser(PotentialUser potentialUser) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => PotentialDetailScreen(
                      idPotential: potentialUser.id ?? 0,
                      userGuestId: potentialUser.userGuestId ?? 0,
                      statusPotential: potentialUser.status,
                    ))!
                .then((value) =>
                    potentialController.getAllPotentialUser(isRefresh: true));
          },
          child: Container(
            margin: const EdgeInsets.all(10),
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
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipOval(
                child: Image.network(
                  potentialUser.userGuest?.avatarImage ?? '',
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                  errorBuilder: (context, error, stackTrace) {
                    return const SahaEmptyAvata(
                      height: 40,
                      width: 40,
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          potentialUser.userGuest?.name ?? 'Chưa có thông tin',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5
                        ),
                        if(potentialUser.userGuest?.cmndNumber != null)
                          const Icon(Icons.check_circle, color: Colors.blueAccent)
                      ],
                    ),
                    Text(
                      potentialUser.userGuest?.phoneNumber ??
                          'Chưa có thông tin',
                      style: const TextStyle(fontSize: 16),
                    ),
                    if(potentialUser.status != 2)
                    Text.rich(
                      TextSpan(
                        text: 'Bài đăng tương tác gần nhất: ',
                        style: const TextStyle(fontSize: 16),
                        children: [
                          TextSpan(
                            text: potentialUser.title ?? 'Chưa có thông tin',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (potentialUser.valueReference == null) {
                                  SahaAlert.showError(
                                      message: "Bài đăng đã bị xoá");

                                  return;
                                }
                                Get.to(() => RoomInformationScreen(
                                      roomPostId: potentialUser.valueReference,
                                    ));
                              },
                          ),
                        ],
                      ),
                    ),
                     if(potentialUser.status != 2)
                    Text(
                      'Ngày tương tác gần nhất: ${DateFormat('dd-MM-yyyy').format(potentialUser.timeInteract ?? DateTime.now())}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    if(potentialUser.status == 2)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Số/tên phòng: ${(potentialUser.listContract ?? []).isNotEmpty ? potentialUser.listContract![0].motelRoom?.motelName : ""}"),
                        Text('Tên toà nhà: ${(potentialUser.listContract ?? []).isNotEmpty ? (potentialUser.listContract![0].tower?.towerName ?? '') : ""}'),
                      ],
                    ),
                    
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: Get.width - 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           if(potentialUser.status == 0)
                            InkWell(
                            onTap: () {
                                  potentialController
                                    .updatePotentialUser(
                                        status: 4,
                                        idPotential: potentialUser.id ?? 0)
                                    .then((value) {
                                  // _tabController.animateTo(1);
                                  // potentialController.status.value = 4;
                                  potentialController.getAllPotentialUser(
                                      isRefresh: true);
                                });
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: const Icon(
                                    Icons.check,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Đang tư vấn',
                                  style: TextStyle(color: Colors.white),
                                )
                              ]),
                            ),
                          ),

                          if(potentialUser.status != 0)
                          InkWell(
                            onTap: () {
                              Get.to(() => AddRenterPotentialScreen(
                                        userPotential: potentialUser,
                                      ))!
                                  .then((value) => potentialController
                                      .getAllPotentialUser(isRefresh: true));
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: const Icon(
                                    Icons.check,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                 Text(
                                  potentialUser.status == 2 ? "Thuê lại":
                                  'Đồng ý',
                                  style: const TextStyle(color: Colors.white),
                                )
                              ]),
                            ),
                          ),
                          if (potentialUser.status == 0 || potentialUser.status == 4 )
                            InkWell(
                              onTap: () {
                                potentialController
                                    .updatePotentialUser(
                                        status: 1,
                                        idPotential: potentialUser.id ?? 0)
                                    .then((value) {
                                  // _tabController.animateTo(2);
                                  // potentialController.status.value = 1;
                                  potentialController.getAllPotentialUser(
                                      isRefresh: true);
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                      size: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Từ chối',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                              ),
                            ),
                          if (potentialUser.status == 1 ||
                              potentialUser.status == 2)
                            InkWell(
                              onTap: () {
                                SahaDialogApp.showDialogYesNo(
                                    mess: "Bạn có đồng ý xoá hay không?",
                                    onOK: () {
                                      potentialController
                                          .deletePotentialUser(
                                              idPotential:
                                                  potentialUser.id ?? 0)
                                          .then((value) => potentialController
                                              .getAllPotentialUser(
                                                  isRefresh: true));
                                    });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(children: [
                                  Image.asset(
                                    'assets/icon_host/xoa.png',
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text(
                                    'Xoá',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.call,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Call.call(potentialUser.userGuest?.phoneNumber ?? '');
                },
              ),
              IconButton(
                icon: Icon(Icons.chat, color: Theme.of(context).primaryColor),
                onPressed: () {
                  Get.to(() => ChatDetailScreen(
                        toUser: potentialUser.userGuest ?? User(),
                      ));
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
