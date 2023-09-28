import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/utils/date_utils.dart';

import '../../../../../components/empty/saha_empty_image.dart';
import '../../../../../model/order.dart';
import '../../../../../utils/string_utils.dart';

class OrderItemWidget extends StatelessWidget {
  final Order order;
  final Function? onTap;

  const OrderItemWidget({
    Key? key,
    required this.order,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10.0),
              child: Text(
                "${SahaDateUtils().getDDMMYY(order.createdAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(order.createdAt ?? DateTime.now())}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: CachedNetworkImage(
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    imageUrl: (order.listCategory ?? []).isEmpty
                        ? ""
                        : order.listCategory![0].image
                               
                            ?? '',
                          
                    errorWidget: (context, url, error) => const SahaEmptyImage(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (order.listCategory ?? []).isEmpty ? "Lỗi dịch vụ" : order.listCategory![0].name ?? "Lỗi dịch vụ",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Spacer(),
                                Text(
                                  " x ${(order.listCategory ?? []).isEmpty ? "Lỗi dịch vụ" : order.listCategory![0].listServiceSell?[0].quantity ?? 0}",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                // Text(
                                //   "đ${SahaStringUtils().convertToMoney((order.listCategory ?? []).isEmpty ? 0 : (order.listCategory![0].itemPrice ?? 0))}",
                                // ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          (order.listCategory ?? []).length > 1
              ? Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      "Xem thêm dịch vụ",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ),
                )
              : Container(),
          const Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  "${(order.listCategory ?? []).length} dịch vụ",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const Spacer(),
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
                Row(
                  children: [
                    const Text("Thành tiền: "),
                    Text(
                      "đ${SahaStringUtils().convertToMoney(order.totalFinal)}",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: [
          //       InkWell(
          //         onTap: () async {
          //           // CartController cartController = Get.find();
          //           // if (order.lineItemsAtTime != null) {
          //           //   await Future.wait(
          //           //       order.lineItemsAtTime!.map((e) {
          //           //         if (e.id != null) {
          //           //           return cartController
          //           //               .addItemCart(e.id, 1, []);
          //           //         } else {
          //           //           return Future.value(null);
          //           //         }
          //           //       }));
          //           // }
          //           // Get.to(() => CartScreen());
          //         },
          //         child: Container(
          //           height: 35,
          //           width: 100,
          //           decoration: BoxDecoration(
          //               color: Theme.of(context).primaryColor,
          //               borderRadius: BorderRadius.circular(4)),
          //           child: Center(
          //             child: Text(
          //               "Mua lại",
          //               style: TextStyle(
          //                   color: Theme.of(context)
          //                       .primaryTextTheme
          //                       .headline6!
          //                       .color),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
            ),
            child: Row(
              children: [
                const Text(
                  "Mã đơn hàng ",
                ),
                const Spacer(),
                Text(
                  "${order.orderCode}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: 8,
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}
