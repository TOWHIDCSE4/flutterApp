import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/components/button/saha_button.dart';
import 'package:gohomy/components/divide/divide.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/user.dart';
import 'package:gohomy/screen/admin/service_sell/orders/detail/order_admin_detail_controller.dart';
import 'package:gohomy/screen/chat/chat_detail/chat_detail_screen.dart';
import 'package:gohomy/utils/call.dart';

import '../../../../../components/empty/saha_empty_image.dart';
import '../../../../../model/order.dart';
import '../../../../../utils/color_utils.dart';
import '../../../../../utils/date_utils.dart';
import '../../../../../utils/string_utils.dart';

// ignore: must_be_immutable
class OrderAdminHistoryDetailScreen extends StatelessWidget {
  //final Order order;
  int id;
  var user = User().obs;
  late OrderAdminDetailController orderAdminDetailController;

  OrderAdminHistoryDetailScreen({required this.id}) {
    // orderHistoryDetailController =
    //     Get.put(OrderHistoryDetailController(orderCode: order));
    orderAdminDetailController = OrderAdminDetailController(id: id);
  }

//  late OrderHistoryDetailController orderHistoryDetailController;

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
        title: const Text("Thông tin đơn hàng"),
      ),
      body: Obx(
        () => orderAdminDetailController.loadInit.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Địa chỉ nhận hàng của khách:",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: Get.width * 0.7,
                                  child: Text(
                                    "${orderAdminDetailController.order.value.name ?? "Chưa có tên"}  | ${orderAdminDetailController.order.value.phoneNumber ?? "Chưa có số điện thoại"}",
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.7,
                                  child: Text(
                                    orderAdminDetailController
                                            .order.value.email ??
                                        "Chưa có Email",
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: orderAdminDetailController
                                                    .order.value.email ==
                                                null
                                            ? Colors.red
                                            : null),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.7,
                                  child: Text(
                                    orderAdminDetailController
                                            .order.value.addressDetail ??
                                        "Chưa có địa chỉ chi tiết",
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.7,
                                  child: Text(
                                    "${orderAdminDetailController.order.value.wardsName ?? "Chưa có Phường/Xã"}, ${orderAdminDetailController.order.value.districtName ?? "Chưa có Quận/Huyện"}, ${orderAdminDetailController.order.value.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                                    style: TextStyle(
                                        color: Colors.grey[700], fontSize: 13),
                                    maxLines: 2,
                                  ),
                                ),
                                if (orderAdminDetailController
                                        .order.value.note !=
                                    null)
                                  Text.rich(
                                    TextSpan(
                                      text: 'Lưu ý: ',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          decoration: TextDecoration.underline),
                                      children: [
                                        TextSpan(
                                          text: orderAdminDetailController
                                                  .order.value.note ??
                                              '',
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 8,
                      color: Colors.grey[200],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Các mặt hàng đã mua:",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    (orderAdminDetailController.order.value.listCategory ?? [])
                            .isEmpty
                        ? Container()
                        : Column(
                            children: [
                              ...(orderAdminDetailController
                                          .order.value.listCategory ??
                                      [])
                                  .map((e) => Column(
                                        children: [
                                          ...(e.listServiceSell ?? [])
                                              .map((e) => itemProduct(e))
                                        ],
                                      ))
                            ],
                          ),
                    SahaDivide(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("Mã đơn hàng"),
                              const Spacer(),
                              Text(orderAdminDetailController
                                      .order.value.orderCode ??
                                  ''),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "Thời gian đặt hàng",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const Spacer(),
                              Text(
                                "${SahaDateUtils().getDDMMYY(orderAdminDetailController.order.value.createdAt!)} ${SahaDateUtils().getHHMM(orderAdminDetailController.order.value.createdAt!)}",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(4),
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.monetization_on_rounded,
                                color: Theme.of(context).primaryColor,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Phương thức thanh toán: "),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Thanh toán khi nhận hàng",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Tạm tính: ",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const Spacer(),
                              Text(
                                "₫${SahaStringUtils().convertToMoney(orderAdminDetailController.order.value.totalBeforeDiscount ?? 0)}",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "Phí vận chuyển: ",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const Spacer(),
                              Text(
                                "+ ₫${SahaStringUtils().convertToMoney(orderAdminDetailController.order.value.totalShippingFee)}",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          (orderAdminDetailController
                                          .order.value.totalShippingFee ??
                                      0) ==
                                  0
                              ? Container()
                              : Row(
                                  children: [
                                    Text(
                                      "Miễn phí vận chuyển: ",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "- ₫${SahaStringUtils().convertToMoney(orderAdminDetailController.order.value.totalShippingFee ?? 0)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text("Thành tiền: "),
                              const Spacer(),
                              Text(
                                  "₫${SahaStringUtils().convertToMoney(orderAdminDetailController.order.value.totalFinal ?? 0)}")
                            ],
                          ),
                          // const Divider()
                        ],
                      ),
                    ),
                    if (orderAdminDetailController.order.value.orderStatus ==
                            0 ||
                        orderAdminDetailController.order.value.orderStatus == 3)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0
                            ),
                            child: Text("Liên hệ khách hàng:"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Call.call(orderAdminDetailController
                                          .order.value.phoneNumber ??
                                      '');
                                },
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 60,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Text(
                                        "Gọi",
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor),
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                              InkWell(
                                onTap: () async {
                                  if(orderAdminDetailController.order.value.userId != null) {
                                    user.value = await orderAdminDetailController.getUserInfo(userId: orderAdminDetailController.order.value.userId!) as User;
                                    if(user.value != null) {
                                      Get.to(() => ChatDetailScreen(
                                        toUser: user.value,
                                      ));
                                    }
                                  }
                                },
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.message,
                                        size: 60,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Text(
                                        "Nhắn tin",
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor),
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          height: 80,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (orderAdminDetailController.order.value.orderStatus == 0)
                    Expanded(
                      child: SahaButtonFullParent(
                        color: Colors.green,
                        text: 'Xác nhận đơn hàng',
                        onPressed: () {
                          updateOrderAdmin(
                              orderAdminDetailController.order.value.id!, 3);
                        },
                      ),
                    ),
                  if (orderAdminDetailController.order.value.orderStatus == 3)
                    Expanded(
                      child: SahaButtonFullParent(
                        color: Colors.green,
                        text: 'Giao hàng thành công',
                        onPressed: () {
                          updateOrderAdmin(
                              orderAdminDetailController.order.value.id!, 2);
                        },
                      ),
                    ),
                  if (orderAdminDetailController.order.value.orderStatus == 0 ||
                      orderAdminDetailController.order.value.orderStatus == 3)
                    Expanded(
                      child: SahaButtonFullParent(
                        colorBorder: Colors.grey,
                        color: Colors.white,
                        textColor: Colors.grey,
                        text: 'Huỷ đơn hàng',
                        onPressed: () {
                          updateOrderAdmin(
                              orderAdminDetailController.order.value.id!, 1);
                        },
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateOrderAdmin(int orderId, int stt) async {
    try {
      var data = await RepositoryManager.adminManageRepository
          .updateOrderAdmin(orderId: orderId, orderStatus: stt);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back(result: stt);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteOrderAdmin(int orderId) async {
    try {
      var data = await RepositoryManager.adminManageRepository
          .deleteOrderAdmin(orderId: orderId);
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Widget itemProduct(ListServiceSell listServiceSell) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey[200]!)),
                  child: CachedNetworkImage(
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    imageUrl: (listServiceSell.images ?? []).isEmpty
                        ? ''
                        : listServiceSell.serviceSell!.images![0],
                    errorWidget: (context, url, error) =>
                        const SahaEmptyImage(),
                  ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(listServiceSell.nameServiceSell ?? '')),
                      const SizedBox(
                        width: 4,
                      ),
                      Text("x${listServiceSell.quantity ?? 0}")
                    ],
                  ),
                  Text(
                    "${SahaStringUtils().convertToUnit(listServiceSell.serviceSell?.price ?? 0)} VNĐ",
                    style:
                        TextStyle(color: Theme.of(Get.context!).primaryColor),
                  )
                ],
              ))
            ],
          ),
        ),
        const Divider(
          height: 1,
        )
      ],
    );
  }
}
