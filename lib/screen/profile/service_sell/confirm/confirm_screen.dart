import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/cart_item.dart';
import 'package:gohomy/screen/profile/service_sell/cart/cart_controller.dart';
import 'package:gohomy/screen/profile/service_sell/orders/detail/order_detail_screen.dart';
import 'package:gohomy/screen/profile/service_sell/orders/orders_screen.dart';

import '../../../../components/empty/saha_empty_image.dart';
import '../../../../model/order.dart';

import '../../../../utils/color_utils.dart';
import '../../../../utils/string_utils.dart';
import '../choose_info_order/choose_info_order_screen.dart';
import 'confirm_controller.dart';

class ConfirmScreen extends StatelessWidget {
  ConfirmScreen({super.key}){
    confirmController = ConfirmController();
  }
  late ConfirmController confirmController;

  CartController cartController = Get.find();
 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Xác nhận đơn hàng"),
          ),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => InkWell(
                    onTap: () {
                      Get.to(() => ChooseInfoOrderScreen(
                            infoOrderReqInput:
                                confirmController.infoOrder.value,
                            confirm: (info) {
                              confirmController.infoOrder.value = info;
                              confirmController.infoOrder.refresh();

                              Get.back();
                            },
                          ));
                    },
                    child: Column(
                      children: [
                     
                           confirmController.infoOrder.value.addressDetail != null
                            ? Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on_rounded,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("Địa chỉ nhận hàng :"),
                                              SizedBox(
                                                width: Get.width * 0.7,
                                                child: Text(
                                                  "${confirmController.infoOrder.value.name ?? "Chưa có tên"}  | ${confirmController.infoOrder.value.phoneNumber ?? "Chưa có số điện thoại"}",
                                                  maxLines: 2,
                                                ),
                                              ),
                                              if (confirmController.infoOrder
                                                          .value.email !=
                                                      null &&
                                                  confirmController.infoOrder
                                                          .value.email !=
                                                      "")
                                                SizedBox(
                                                  width: Get.width * 0.7,
                                                  child: Text(
                                                    confirmController.infoOrder
                                                            .value.email ??
                                                        "Chưa có Email",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color: confirmController
                                                                    .infoOrder
                                                                    .value
                                                                    .email ==
                                                                null
                                                            ? Colors.red
                                                            : null),
                                                  ),
                                                ),
                                              SizedBox(
                                                width: Get.width * 0.7,
                                                child: Text(
                                                  confirmController
                                                          .infoOrder
                                                          .value
                                                          .addressDetail ??
                                                      "Chưa có địa chỉ chi tiết",
                                                  maxLines: 2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.7,
                                                child: Text(
                                                  "${confirmController.infoOrder.value.wardsName ?? "Chưa có Phường/Xã"}, ${confirmController.infoOrder.value.districtName ?? "Chưa có Quận/Huyện"}, ${confirmController.infoOrder.value.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 13),
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on_rounded,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Địa chỉ nhận hàng :"),
                                            SizedBox(
                                              width: Get.width * 0.7,
                                              child: const Text(
                                                "Chưa chọn địa chỉ nhận hàng (nhấn để chọn)",
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 14,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "packages/sahashop_customer/assets/icons/cart_icon.svg",
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Các mặt hàng đã đặt :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
           
                
            
                ...List.generate(
                  cartController.listCartItem.length,
                  (index) =>
                      itemServiceSell(cartController.listCartItem[index]),
                ),
                Container(
                  height: 55,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng số tiền (${cartController.listCartItem.length} sản phẩm) : ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Obx(
                        () => Text(SahaStringUtils().convertToMoney(
                            cartController.cart.value.totalBeforeDiscount ??
                                0)),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 8,
                  color: Colors.grey[200],
                ),
                // InkWell(
                //   onTap: () {
                //     Get.to(() => ChooseVoucherCustomerScreen());
                //   },
                //   child: Container(
                //     key: dataKeyPayment,
                //     height: 55,
                //     padding: const EdgeInsets.all(10.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Row(
                //           children: [
                //             SvgPicture.asset(
                //               "packages/sahashop_customer/assets/icons/receipt.svg",
                //               color: SahaColorUtils()
                //                   .colorPrimaryTextWithWhiteBackground(),
                //             ),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Text(
                //               'Shop Voucher : ',
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             ),
                //           ],
                //         ),
                //         Spacer(),
                //         Obx(
                //           () => confirmController
                //                       .cartController.voucherCodeChoose.value ==
                //                   ""
                //               ? Text("Chọn hoặc nhập mã")
                //               : Text(
                //                   "Mã: ${confirmController.cartController.voucherCodeChoose.value}",
                //                   style: TextStyle(fontSize: 13),
                //                 ),
                //         ),
                //         const SizedBox(width: 10),
                //         Icon(
                //           Icons.arrow_forward_ios,
                //           size: 12,
                //           color: SahaColorUtils()
                //               .colorPrimaryTextWithWhiteBackground(),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // Container(
                //   height: 8,
                //   color: Colors.grey[200],
                // ),
                InkWell(
                  onTap: () {
                    // Get.to(() => PaymentMethodCustomerScreen(
                    //       paymentPartnerId:
                    //           confirmController.paymentPartnerId.value,
                    //       callback: (String paymentMethodName,
                    //           int paymentPartnerId,
                    //           int paymentMethodId) {
                    //         confirmController.paymentMethodName.value =
                    //             paymentMethodName;
                    //         confirmController.paymentPartnerId.value =
                    //             paymentPartnerId;
                    //         confirmController.paymentMethodId.value =
                    //             paymentMethodId;
                    //       },
                    //     ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
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
                          const Text(
                            'Phương thức thanh toán',
                            maxLines: 2,
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 130,
                        child: Text(
                          "Thanh toán khi nhận hàng",
                          style: TextStyle(
                              fontSize: 13,
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground()),
                        ),
                      ),
                      // Icon(
                      //   Icons.arrow_forward_ios_rounded,
                      //   size: 14,
                      // )
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                Obx(
                  () => Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tạm tính :',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[700])),
                              Text(
                                  SahaStringUtils().convertToMoney(
                                      cartController
                                              .cart.value.totalBeforeDiscount ??
                                          0),
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[800])),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng tiền vận chuyển :',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[700])),
                              Text(
                                  "+ ${SahaStringUtils().convertToMoney((cartController.cart.value.totalShippingFee ?? 0))}",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[800])),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tổng thanh toán :',
                              ),
                              Text(
                                  SahaStringUtils().convertToMoney(
                                      cartController.cart.value.totalFinal ??
                                          0),
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[800])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 8,
                  color: Colors.grey[200],
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.grey[200],
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Icon(
                            Icons.document_scanner_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                            child: Text(
                                "Nhấn 'Đặt hàng' đồng nghĩa với việc bạn đồng ý tuân theo Điều khoản Rencity "),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 8,
                  color: Colors.grey[200],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Obx(
            () => Container(
              height: 100,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(0, 0.1), // Shadow position
                ),
              ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Tổng thanh toán",style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(
                        "${SahaStringUtils().convertToMoney(
                            cartController.cart.value.totalFinal ?? 0)} VNĐ" ,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    onTap: () async {
                      if(confirmController.loading.value == true){
                        return;
                      }
                      confirmController.order(onSuccess: (order) {
                        showDialogSuccess(order);
                      });
                    },
                    child: Obx(
                      () => Container(
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                            color: confirmController.loading.value
                                ? Colors.grey[300]
                                : Theme.of(context).primaryColor,
                            border: Border.all(color: Colors.grey[200]!)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Xác nhận",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6!
                                      .color,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget itemServiceSell(CartItem cartItem) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: (cartItem.serviceSell?.images ?? []).isEmpty
                            ? ''
                            : cartItem.serviceSell!.images![0],
                        errorWidget: (context, url, error) =>
                            const SahaEmptyImage(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.serviceSell?.name ?? "Lỗi sản phẩm",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          maxLines: 2,
                        ),
                        Text(
                          SahaStringUtils()
                              .convertToMoney(cartItem.itemPrice ?? 0),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground()),
                        ),
                      ],
                    ),
                    Text(" x${cartItem.quantity ?? 0}",
                        style: Theme.of(Get.context!).textTheme.bodyText1),
                  ],
                ),
              )
            ],
          ),
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }

  void showDialogSuccess(Order order) {
    var counter = 1.obs;
    late Timer timer;

    void startTimer() {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        (counter.value > 0) ? counter.value-- : timer.cancel();
        if (counter.value == 0) {
          timer.cancel();
          Get.back();
          Get.back();
          Get.back();
          Get.back();
          // Get.until(
          //   (route) => route.settings.name == "service_sell_screen",
          // );
          Get.to(() => OrdersScreen());
          Get.to(() => OrderHistoryDetailScreen(
                orderCode: order.orderCode!,
              ));
        }
        print(counter.value);
      });
    }

    var alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Colors.grey[200],
      elevation: 0.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "assets/gif/tick.gif",
            height: 125.0,
            width: 125.0,
          ),
          const SizedBox(
            height: 1,
          ),
          Text(
            'Đặt hàng thành công',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(Get.context!).primaryColor,
            ),
          ),
          Obx(
            () => Text(
              'Chuyển tiếp đến trang hoá đơn ${counter.value}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      timer.cancel();
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.back();
                      // Get.until(
                      //   (route) => route.settings.name == "service_sell_screen",
                      // );
                      Get.to(() => OrdersScreen());
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.grey,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      child: const Center(
                          child: Text(
                        'Thoát',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      timer.cancel();
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.back();
                      // Get.until(
                      //   (route) =>
                      //       route.settings.name == "service_sell_screen",
                      // );
                      // Get.to(() => OrdersScreen());
                      // Get.to(() => OrderHistoryDetailScreen(
                      //       orderCode: order.orderCode!,
                      //     ));
                      Get.to(() => OrdersScreen());
                      Get.to(() => OrderHistoryDetailScreen(
                            orderCode: order.orderCode!,
                          ));
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            colors: [
                              Colors.grey,
                              Colors.green,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      child: const Center(
                          child: Text(
                        'Hoá đơn',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              )
            ],
          ), //new column child
        ],
      ),
    );

    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext c) {
          startTimer();
          return alert;
        });
  }
}
