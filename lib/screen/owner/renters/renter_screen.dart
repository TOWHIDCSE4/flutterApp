import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/owner/renters/renter_details/renter_detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../components/empty/saha_empty_avatar.dart';
import '../../../components/loading/loading_full_screen.dart';
import '../../../components/text_field/rice_text_field.dart';
import '../../../const/color.dart';
import '../../../model/renter.dart';
import '../../../model/tower.dart';
import '../../../model/user.dart';
import '../../../utils/call.dart';
import '../../admin/potential_user/add_renter/add_renter_screen.dart';
import '../../chat/chat_detail/chat_detail_screen.dart';
import '../../chat/chat_list/chat_list_screen.dart';
import '../../profile/bill/add_bill/add_bill_screen.dart';
import '../contract/add_contract/add_contract_screen.dart';
import 'add_update_tenants/add_update_tenant_screen.dart';
import 'renter_controller.dart';

class RenterScreen extends StatefulWidget {
  RenterScreen({Key? key, this.isNext}) : super(key: key);
  bool? isNext;

  @override
  State<RenterScreen> createState() => _ListTenantsScreenState();
}

class _ListTenantsScreenState extends State<RenterScreen>
    with SingleTickerProviderStateMixin {
  ListTenantsController listTenantsController = ListTenantsController();
  RefreshController refreshController = RefreshController();

  late TabController _tabController;

  @override
  void initState() {
    if (widget.isNext == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Get.to(() => AddRenterPotentialScreen())!.then(
            (value) => listTenantsController.getAllTenants(isRefresh: true));
      });
    }
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quản lý người thuê",
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[
                  Color(0xFFEF4355),
                  Color(0xFFFF964E),
                ]),
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (listTenantsController.isSearch.value == false) {
                  listTenantsController.isSearch.value = true;
                } else {
                  listTenantsController.isSearch.value = false;
                }
              }),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(
                        child: Text(
                          'Lọc',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      content: SizedBox(
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Ngày thuê dự kiến'),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Theme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              listTenantsController.fromDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate:
                                                          DateTime(2022, 1, 1),
                                                      lastDate:
                                                          DateTime(2050, 1, 1));
                                              if (listTenantsController
                                                      .fromDate !=
                                                  null) {
                                                listTenantsController
                                                    .fromDateController
                                                    .text = DateFormat(
                                                        'dd-MM-yyyy')
                                                    .format(
                                                        listTenantsController
                                                            .fromDate!);
                                              }
                                            },
                                            child: RiceTextField(
                                              enabled: false,
                                              controller: listTenantsController
                                                  .fromDateController,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Text(' - '),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Theme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: InkWell(
                                              onTap: () async {
                                                listTenantsController.toDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate: DateTime(
                                                            2022, 1, 1),
                                                        lastDate: DateTime(
                                                            2050, 1, 1));
                                                if (listTenantsController
                                                        .toDate !=
                                                    null) {
                                                  listTenantsController
                                                      .toDateController
                                                      .text = DateFormat(
                                                          'dd-MM-yyyy')
                                                      .format(
                                                          listTenantsController
                                                              .toDate!);
                                                }
                                              },
                                              child: RiceTextField(
                                                enabled: false,
                                                controller:
                                                    listTenantsController
                                                        .toDateController,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () {
                                if (listTenantsController.fromDate == null) {
                                  SahaAlert.showError(
                                      message: "Bạn chưa chọn ngày bắt đầu");
                                  return;
                                }
                                if (listTenantsController.toDate == null) {
                                  SahaAlert.showError(
                                      message: "Bạn chưa chọn ngày kết thúc");
                                  return;
                                }
                                if (listTenantsController.toDate!.isBefore(
                                    listTenantsController.fromDate!)) {
                                  SahaAlert.showError(
                                      message:
                                          "Vui lòng chọn ngày kết thúc sau ngày bắt đầu");
                                  return;
                                }
                                listTenantsController.getAllTenants(
                                    isRefresh: true);
                                Get.back();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(12)),
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
                    );
                  },
                );
              },
              icon: const Icon(Icons.filter_alt)),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.to(() => AddUpdateTenantScreen())!.then((value) =>
      //         {listTenantsController.getAllTenants(isRefresh: true)});
      //     ;
      //   },
      //   backgroundColor: Color(0xFFEF4355),
      //   child: const Icon(Icons.add),
      // ),
      body: Container(
        child: Column(
          children: [
            ColoredBox(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                onTap: (v) {
                  listTenantsController.status = v == 0 ? 2 : 0;
                 // listTenantsController.isRented = v == 0 ? true : false;

                  listTenantsController.getAllTenants(isRefresh: true);
                  
                },
                tabs: const [
                  Tab(
                    child: Text(
                      'Khách đã làm hợp đồng',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Khách chưa làm hợp đồng',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => listTenantsController.loadInit.value
                    ? SahaLoadingFullScreen()
                    : listTenantsController.listTenants.isEmpty
                        ? const Center(
                            child: Text('Không có người thuê'),
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
                                      listTenantsController.isLoading.value
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
                              await listTenantsController.getAllTenants(
                                  isRefresh: true);
                              refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              await listTenantsController.getAllTenants();
                              refreshController.loadComplete();
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: listTenantsController.listTenants
                                    .map((e) => itemTenants(renter: e))
                                    .toList(),
                              ),
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddRenterPotentialScreen())!.then((value) =>
              {listTenantsController.getAllTenants(isRefresh: true)});
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemTenants({required Renter renter}) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => RenterDetailScreen(
                  renterId: renter.id ?? 0,
                ));
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
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipOval(
                child: Image.network(
                  renter.avatarImage ?? '',
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
                    Text(
                      renter.name ?? 'Chưa có thông tin',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      renter.phoneNumber ?? 'Chưa có thông tin',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text("Só/tên phòng: ${renter.hasContract == true ? (renter.contractActive?.motelRoom?.motelName ?? '') : renter.motelName}"),
                    if(renter.nameTowerExpected != null)
                    Text('Tên toà nhà: ${renter.hasContract == true ? (renter.contractActive?.tower?.towerName ?? '') : renter.nameTowerExpected ?? ''}'),
                         if(renter.hasContract == false)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ngày thuê dự kiến: ${DateFormat("dd-MM-yyyy").format(renter.estimateRentalDate ?? DateTime.now())}"),
                        Text("Thời hạn thuê dự kiến: ${renter.estimateRentalPeriod ?? ''} tháng"),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     SizedBox(
                      width: Get.width - 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (renter.hasContract == false)
                            InkWell(
                              onTap: () {
                                Get.to(()=>AddContractScreen(
                                  renterInput: renter,
                                  motelRoomInput:renter.motelId == null ? null : renter.motelRoom,
                                  tower:renter.towerId == null ? null : Tower(id: renter.towerId,towerName: renter.nameTowerExpected),
                                ));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(children: const [
                                  Icon(
                                    Icons.note_alt_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'Tạo hợp đồng',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                              ),
                            ),
                          if (renter.hasContract == true)
                            InkWell(
                              onTap: () {
                                Get.to(()=>AddBillScreen(contractInput : renter.contractActive));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(children: const [
                                  Icon(
                                    Icons.note_add,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'Hoá đơn',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                              ),
                            ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (renter.hasContract == false) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Center(
                                        child: Text(
                                          'Xoá người thuê',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      content: SizedBox(
                                        width: Get.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Bạn xác định muốn xoá người thuê ${renter.name ?? ""} khỏi danh sách người thuê ?",
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        20, 10, 20, 10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: const Center(
                                                      child: Text(
                                                        "Suy nghĩ lại",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    listTenantsController
                                                        .deleteTenants(
                                                            tenantsId:
                                                                renter.id!)
                                                        .then((value) =>
                                                            listTenantsController
                                                                .getAllTenants(
                                                                    isRefresh:
                                                                        true));
                                                   
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        20, 10, 20, 10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: const Center(
                                                      child: Text(
                                                        "Xoá",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Center(
                                        child: Text(
                                          'Xoá người thuê',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      content: SizedBox(
                                        width: Get.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Bạn xác định muốn xoá người thuê ${renter.name ?? ""} khỏi danh sách người thuê ?",
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              "Hãy chấm dứt hợp đồng trước nha!",
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        20, 10, 20, 10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: const Center(
                                                      child: Text(
                                                        "Suy nghĩ lại",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                      Get.back();
                                                    Get.to(()=>AddContractScreen(
                                                      contractId: renter.contractActive?.id!,
                                                    ));
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: const Center(
                                                      child: Text(
                                                        "Chấm dứt hợp đồng",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(children: const [
                                Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  'Xoá',
                                  style: TextStyle(color: Colors.white),
                                )
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),

        ///
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
                  Call.call(renter.phoneNumber ?? '');
                },
              ),
              IconButton(
                icon: Icon(Icons.chat, color: Theme.of(context).primaryColor),
                onPressed: () {
                  Get.to(() => ChatDetailScreen(
                        toUser: renter.user ?? User(),
                      ));
                },
              ),
            ],
          ),
        )
      ],
    );

    // GestureDetector(
    //   onTap: () {
    //     Get.to(() => AddUpdateTenantScreen(
    //               tenantInput: renter,
    //               status: renterManageAdminController.status.value,
    //             ))!
    //         .then((value) => {
    //               renterManageAdminController.getAllAdminRenter(isRefresh: true)
    //             });

    //     // showModalBottomSheet<void>(
    //     //   shape: RoundedRectangleBorder(
    //     //     borderRadius: BorderRadius.circular(10.0),
    //     //   ),
    //     //   context: context,
    //     //   builder: (BuildContext context) {
    //     //     return Container(
    //     //       height: 130,
    //     //       margin: EdgeInsets.all(10),
    //     //       child: Column(
    //     //         children: [
    //     //           GestureDetector(
    //     //             onTap: () {
    //     //               Get.to(() => AddUpdateTenantScreen(
    //     //                         tenantInput: renter,
    //     //                       ))!
    //     //                   .then((value) => {
    //     //                         listTenantsController.getAllTenants(
    //     //                             isRefresh: true)
    //     //                       });
    //     //             },
    //     //             child: Container(
    //     //               width: Get.width,
    //     //               margin: EdgeInsets.all(10),
    //     //               padding: EdgeInsets.all(10),
    //     //               decoration: BoxDecoration(
    //     //                 color: Colors.white,
    //     //                 borderRadius: BorderRadius.circular(10),
    //     //                 boxShadow: [
    //     //                   BoxShadow(
    //     //                     color: Colors.grey.withOpacity(0.5),
    //     //                     spreadRadius: 1,
    //     //                     blurRadius: 1,
    //     //                     offset: Offset(0, 3), // changes position of shadow
    //     //                   ),
    //     //                 ],
    //     //               ),
    //     //               child: Text(
    //     //                 "Chỉnh sửa",
    //     //                 style: TextStyle(
    //     //                   fontSize: 16,
    //     //                   fontWeight: FontWeight.w500,
    //     //                 ),
    //     //                 textAlign: TextAlign.center,
    //     //               ),
    //     //             ),
    //     //           ),
    //     //           if (listTenantsController.status.value == 0)
    //     //             GestureDetector(
    //     //               onTap: () {
    //     //                 SahaDialogApp.showDialogYesNo(
    //     //                     mess: 'Bạn chắc chắn muốn xóa người thuê này?',
    //     //                     onClose: () {
    //     //                       Get.back();
    //     //                     },
    //     //                     onOK: () {
    //     //                       listTenantsController.deleteTenants(
    //     //                           tenantsId: renter.id!);
    //     //                     });
    //     //               },
    //     //               child: Container(
    //     //                 width: Get.width,
    //     //                 margin: EdgeInsets.all(10),
    //     //                 padding: EdgeInsets.all(10),
    //     //                 decoration: BoxDecoration(
    //     //                   color: Colors.white,
    //     //                   borderRadius: BorderRadius.circular(10),
    //     //                   boxShadow: [
    //     //                     BoxShadow(
    //     //                       color: Colors.grey.withOpacity(0.5),
    //     //                       spreadRadius: 1,
    //     //                       blurRadius: 1,
    //     //                       offset:
    //     //                           Offset(0, 3), // changes position of shadow
    //     //                     ),
    //     //                   ],
    //     //                 ),
    //     //                 child: Text(
    //     //                   "Xoá",
    //     //                   style: TextStyle(
    //     //                     fontSize: 16,
    //     //                     fontWeight: FontWeight.w500,
    //     //                   ),
    //     //                   textAlign: TextAlign.center,
    //     //                 ),
    //     //               ),
    //     //             ),
    //     //         ],
    //     //       ),
    //     //     );
    //     //   },
    //     // );
    //   },
    //   child: Container(
    //     margin: const EdgeInsets.only(
    //       top: 10,
    //       right: 10,
    //       left: 10,
    //     ),
    //     padding: const EdgeInsets.all(10),
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(10),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.5),
    //           spreadRadius: 1,
    //           blurRadius: 1,
    //           offset: const Offset(0, 3), // changes position of shadow
    //         ),
    //       ],
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               renter.name ?? "",
    //               style: const TextStyle(
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //             Row(
    //               children: [
    //                 const Icon(
    //                   Icons.phone,
    //                   size: 15,
    //                   color: Colors.grey,
    //                 ),
    //                 Text(
    //                   renter.phoneNumber ?? " ",
    //                   style: const TextStyle(
    //                     color: primaryColor,
    //                   ),
    //                 ),
    //               ],
    //             )
    //           ],
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Text(
    //           "CCCD/CMND: ${renter.cmndNumber ?? ""}",
    //           style: const TextStyle(
    //             color: Colors.green,
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Text(
    //           "Địa chỉ: ${renter.address ?? ""}",
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             Obx(
    //               () => renterManageAdminController.loadInit1.value
    //                   ? SahaLoadingWidget()
    //                   : Center(
    //                       child: InkWell(
    //                         onTap: () {
    //                           renterManageAdminController.search =
    //                               renter.phoneNumber;
    //                           renterManageAdminController.getAllUsers(
    //                               isRefresh: true);
    //                         },
    //                         child: Container(
    //                           padding: const EdgeInsets.only(
    //                               left: 10, right: 10, top: 5, bottom: 5),
    //                           decoration: BoxDecoration(
    //                               color: Theme.of(context).primaryColor,
    //                               borderRadius: BorderRadius.circular(10)),
    //                           child: Row(
    //                             children: const [
    //                               Icon(
    //                                 Icons.chat_rounded,
    //                                 color: Colors.white,
    //                               ),
    //                               SizedBox(
    //                                 width: 10,
    //                               ),
    //                               Text(
    //                                 'Chat',
    //                                 style: TextStyle(
    //                                   color: Colors.white,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //             ),
    //             InkWell(
    //               onTap: () {
    //                 Call.call(renter.phoneNumber ?? "");
    //               },
    //               child: Container(
    //                 padding: const EdgeInsets.only(
    //                     left: 10, right: 10, top: 5, bottom: 5),
    //                 decoration: BoxDecoration(
    //                     color: Colors.deepOrange,
    //                     borderRadius: BorderRadius.circular(10)),
    //                 child: Row(
    //                   children: const [
    //                     Icon(
    //                       Icons.phone,
    //                       color: Colors.white,
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     Text(
    //                       'Gọi',
    //                       style: TextStyle(
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
