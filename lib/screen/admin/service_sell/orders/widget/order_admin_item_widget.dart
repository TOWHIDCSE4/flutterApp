import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/utils/date_utils.dart';

import '../../../../../components/empty/saha_empty_image.dart';
import '../../../../../model/order.dart';
import '../../../../../utils/string_utils.dart';

class OrderAdminItemWidget extends StatelessWidget {
  final Order order;
  final Function? onTap;
   int quantityProduct = 0;

   OrderAdminItemWidget({
    Key? key,
    required this.order,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    for(int i = 0;i<order.listCategory!.length;i++){
      quantityProduct = quantityProduct + order.listCategory![i].listServiceSell!.length;
    }
    return InkWell(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (order.listCategory ?? []).isEmpty
                      ? "Lỗi dịch vụ"
                      : order.listCategory![0].name ?? "Lỗi dịch vụ",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${SahaDateUtils().getDDMMYY(order.createdAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(order.createdAt ?? DateTime.now())}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
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
                          : order.listCategory![0].image ?? '',
                      errorWidget: (context, url, error) =>
                          const SahaEmptyImage(),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if((order.listCategory ?? []).isNotEmpty)
                         ...order.listCategory![0].listServiceSell!.map((e) => itemProduct(e))

                          // Column(
                          //   children: [
                          //     Row(
                          //       children: [
                          //         const Spacer(),
                          //         Text(
                          //           " x ${(order.listServiceSell ?? []).isEmpty ? "Lỗi dịch vụ" : order.listServiceSell![0].quantity ?? 0}",
                          //           style: TextStyle(
                          //               fontSize: 13, color: Colors.grey[600]),
                          //         ),
                          //       ],
                          //     ),
                          //     Row(
                          //       children: [
                          //         const Spacer(),
                          //         Text(
                          //           "đ${SahaStringUtils().convertToMoney((order.listServiceSell ?? []).isEmpty ? 0 : (order.listServiceSell![0].itemPrice ?? 0))}",
                          //         ),
                          //       ],
                          //     )
                          //   ],
                          // ),
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
                        "Xem thêm sản phẩm",
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ),
                  )
                : const SizedBox(),
            const Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    "$quantityProduct sản phẩm",
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
          ],
        ),
      ),
    );
  }

  Widget itemProduct(ListServiceSell listServiceSell) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Expanded(child: Text(listServiceSell.nameServiceSell ?? '')),
            const SizedBox(
              width: 4,
            ),
            Text("x${listServiceSell.quantity ?? 0}")
          ],
        ),
        Text(
          "${SahaStringUtils().convertToUnit(listServiceSell.serviceSell?.price ?? 0)} VNĐ",
          style: TextStyle(color: Theme.of(Get.context!).primaryColor),
        )
      ],
    );
  }
}
