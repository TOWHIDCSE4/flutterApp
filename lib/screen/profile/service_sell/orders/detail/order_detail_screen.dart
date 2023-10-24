import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/data_app_controller.dart';

import 'package:gohomy/screen/profile/service_sell/orders/detail/order_detail_controller.dart';

import '../../../../../components/divide/divide.dart';
import '../../../../../components/empty/saha_empty_image.dart';
import '../../../../../model/order.dart';
import '../../../../../utils/call.dart';

import '../../../../../utils/date_utils.dart';
import '../../../../../utils/string_utils.dart';
import '../../../../home/home_controller.dart';

// ignore: must_be_immutable
class OrderHistoryDetailScreen extends StatelessWidget {
  final String orderCode;
  HomeController homeController = Get.find();
  late OrderDetailController orderDetailController;

  OrderHistoryDetailScreen({required this.orderCode}) {
    orderDetailController = OrderDetailController(orderCode: orderCode);
  }

//  late OrderHistoryDetailController orderHistoryDetailController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: const Text("Thông tin đơn hàng"),
      ),
      body: Obx(
        () => orderDetailController.loadInit.value
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
                                    "${orderDetailController.order.value.name ?? "Chưa có tên"}  | ${orderDetailController.order.value.phoneNumber ?? "Chưa có số điện thoại"}",
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.7,
                                  child: Text(
                                    orderDetailController.order.value.email ??
                                        "Chưa có Email",
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: orderDetailController
                                                    .order.value.email ==
                                                null
                                            ? Colors.red
                                            : null),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.7,
                                  child: Text(
                                    orderDetailController
                                            .order.value.addressDetail ??
                                        "Chưa có địa chỉ chi tiết",
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.7,
                                  child: Text(
                                    "${orderDetailController.order.value.wardsName ?? "Chưa có Phường/Xã"}, ${orderDetailController.order.value.districtName ?? "Chưa có Quận/Huyện"}, ${orderDetailController.order.value.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                                    style: TextStyle(
                                        color: Colors.grey[700], fontSize: 13),
                                    maxLines: 2,
                                  ),
                                ),
                                if (orderDetailController.order.value.note !=
                                    null)
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "Lưu ý:",
                                          style: TextStyle(
                                              fontSize: 16,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        TextSpan(
                                          text:
                                              "  ${orderDetailController.order.value.note ?? ''}",
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

                    (orderDetailController.order.value.listCategory ?? [])
                            .isEmpty
                        ? Container()
                        : Column(
                            children: [
                              ...(orderDetailController
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
                              Text(
                                  orderDetailController.order.value.orderCode ??
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
                                "${SahaDateUtils().getDDMMYY(orderDetailController.order.value.createdAt!)} ${SahaDateUtils().getHHMM(orderDetailController.order.value.createdAt!)}",
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
                    SahaDivide(),
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
                                "₫${SahaStringUtils().convertToMoney(orderDetailController.order.value.totalBeforeDiscount ?? 0)}",
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
                                "Tổng tiền vận chuyển:",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const Spacer(),
                              Text(
                                "+ ₫${SahaStringUtils().convertToMoney(orderDetailController.order.value.totalShippingFee)}",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          (orderDetailController.order.value.totalShippingFee ??
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
                                      "- ₫${SahaStringUtils().convertToMoney(orderDetailController.order.value.totalShippingFee ?? 0)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text("Tổng thanh toán: "),
                              const Spacer(),
                              Text(
                                  "₫${SahaStringUtils().convertToMoney(orderDetailController.order.value.totalFinal ?? 0)}")
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),

                    // InkWell(
                    //   onTap: () {
                    //     Call.call(homeController
                    //             .homeApp.value.adminContact?.phoneNumber ??
                    //         "");
                    //     print(homeController
                    //             .homeApp.value.adminContact?.phoneNumber ??
                    //         "");
                    //   },
                    //   child: Container(
                    //     height: 40,
                    //     decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.grey[500]!)),
                    //     child: Center(
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Container(
                    //               padding: const EdgeInsets.all(4),
                    //               height: 30,
                    //               width: 30,
                    //               decoration: const BoxDecoration(
                    //                 color: Color(0xFFF5F6F9),
                    //                 shape: BoxShape.circle,
                    //               ),
                    //               child: Icon(
                    //                 Icons.admin_panel_settings,
                    //                 color: Theme.of(context).primaryColor,
                    //               )),
                    //           const SizedBox(
                    //             width: 10,
                    //           ),
                    //           const Text("Liên hệ Shop")
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SahaDivide(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Container(
        height: 110,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => orderDetailController.order.value.orderStatus == 0 ||
                        orderDetailController.order.value.orderStatus == 3
                    ? Expanded(
                        child: InkWell(
                          onTap: () {
                            Call.call(Get.find<HomeController>()
                                    .homeApp
                                    .value
                                    .adminContact
                                    ?.phoneNumber ??
                                '');
                          },
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Liên hệ shop",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox()),
                Obx(() => orderDetailController.order.value.orderStatus == 0
                    ? Expanded(
                        child: InkWell(
                          onTap: () {
                            SahaDialogApp.showDialogYesNo(
                                mess: "Bạn chắc chắn muốn huỷ đơn chứ?",
                                onOK: () {
                                  orderDetailController.updateStatusOrder();
                                });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey)),
                            child: const Center(
                                child: Text(
                              "Huỷ đơn hàng",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            )),
                          ),
                        ),
                      )
                    : const SizedBox()),
                Obx(() => orderDetailController.order.value.orderStatus == 1 &&
                        orderDetailController.order.value.userId ==
                            Get.find<DataAppController>().currentUser.value.id
                    ? InkWell(
                        onTap: () {
                          SahaDialogApp.showDialogYesNo(
                              mess: "Bạn có chắc chắn đặt lại không?",
                              onOK: () {
                                orderDetailController.reOrder();
                              });
                        },
                        child: Container(
                          width: Get.width / 1.5,
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                              child: Text(
                            "Đặt lại",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          )),
                        ),
                      )
                    : const SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
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
                        : listServiceSell.images![0],
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
