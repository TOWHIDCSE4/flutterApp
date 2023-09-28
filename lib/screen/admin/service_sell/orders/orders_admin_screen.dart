import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/loading/loading_full_screen.dart';
import '../../../../components/text_field/saha_text_field_search.dart';
import '../../../../utils/debounce.dart';
import 'detail/order_admin_detail_screen.dart';
import 'orders_admin_controller.dart';
import 'widget/order_admin_item_widget.dart';

class OrdersAdminScreen extends StatefulWidget {
  @override
  State<OrdersAdminScreen> createState() => _OrdersAdminScreenState();
}

class _OrdersAdminScreenState extends State<OrdersAdminScreen>
    with SingleTickerProviderStateMixin {
  OrdersAdminController ordersController = OrdersAdminController();
  RefreshController refreshController = RefreshController();

  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          () => ordersController.isSearch.value == true
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
                        ordersController.textSearch = value;
                        ordersController.getAllOrder(
                          isRefresh: true,
                        );
                      },
                      controller: ordersController.searchEdit,
                      autofocus: ordersController.isSearch.value ? true : false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                            right: 15, top: 20, bottom: 5),
                        border: InputBorder.none,
                        hintText: "Tìm kiếm",
                        suffixIcon: IconButton(
                          onPressed: () {
                            ordersController.searchEdit.clear();
                            ordersController.listOrder([]);
                            ordersController.textSearch = '';
                            ordersController.getAllOrder(
                              isRefresh: true,
                            );
                            FocusScope.of(context).unfocus();

                            ordersController.isSearch.value = false;
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 15,
                          ),
                        ),
                      ),
                      onChanged: (v) {
                        EasyDebounce.debounce(
                            'order_admin', const Duration(milliseconds: 500),
                            () {
                          ordersController.textSearch = v;
                          ordersController.getAllOrder(
                            isRefresh: true,
                          );
                        });
                      },
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                )
              : const Text('Danh sách đơn hàng'),
        ),
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
                    controller: tabController,
                    onTap: (v) {
                      ordersController.status.value = v == 0 ? 0 : v == 1 ? 3 : v == 2 ? 2 : 1;
                      ordersController.getAllOrder(isRefresh: true); 
                    },
                    tabs: [
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Chờ xác nhận',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 10,
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
                              'Đang giao',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 10,
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
                              'Đã hoàn thành',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 10,
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
                              'Đã huỷ',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 10,
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
          // SahaTextFieldSearch(
          //   hintText: "Tìm kiếm phòng trọ",
          //   onChanged: (va) {
          //     EasyDebounce.debounce(
          //         'list_motel_room', const Duration(milliseconds: 300), () {
          //       widget.adminMotelRoomController.textSearch = va;
          //       widget.adminMotelRoomController
          //           .getAllAdminMotelRoom(isRefresh: true);
          //     });
          //   },
          //   onClose: () {
          //     widget.adminMotelRoomController.textSearch = "";
          //     widget.adminMotelRoomController
          //         .getAllAdminMotelRoom(isRefresh: true);
          //   },
          // ),
          Expanded(
            child: Obx(
              () => ordersController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : SmartRefresher(
                      footer: CustomFooter(
                        builder: (
                          BuildContext context,
                          LoadStatus? mode,
                        ) {
                          Widget body = Container();
                          if (mode == LoadStatus.idle) {
                            body = Obx(() => ordersController.isLoading.value
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
                        await ordersController.getAllOrder(isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await ordersController.getAllOrder();
                        refreshController.loadComplete();
                      },
                      child: ListView.builder(
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          itemCount: ordersController.listOrder.length,
                          itemBuilder: (BuildContext context, int index) {
                            var e = ordersController.listOrder[index];
                            return OrderAdminItemWidget(
                              order: e,
                              onTap: () {
                                Get.to(() => OrderAdminHistoryDetailScreen(
                                          //order: e,
                                          id: e.id!,
                                        ))!
                                    .then((value) => {
                                          print(value),
                                          if (value == 2)
                                            {
                                              tabController.animateTo(1),
                                              ordersController.getAllOrder(
                                                  isRefresh: true)
                                            },
                                          if (value == 1)
                                            {
                                              tabController.animateTo(2),
                                              ordersController.getAllOrder(
                                                  isRefresh: true)
                                            }
                                        });
                              },
                            );
                          }),
                    ),
            ),
          ),
        ],
      ),
    
    
    
    );
  }
}
