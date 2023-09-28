import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/admin/services_sell/services_sell_detail/detail_product/product_detail_controller.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../../../../../components/empty/saha_empty_avatar.dart';
import '../../../../../components/widget/image/product_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../add_services_sell/add_services_sell_screen.dart';
import '../add_product/add_product_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key, required this.productId}) {
    controller = ProductDetailController(productId: productId);
  }
  late ProductDetailController controller;
  final int productId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Chi tiết sản phẩm",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => controller.loadInit.value
              ? SahaLoadingFullScreen()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImage(
                          listImageUrl: controller.serviceSell.value.images),
                      const Divider(),
                      Text(
                        controller.serviceSell.value.name ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Text(
                        '${SahaStringUtils().convertToUnit(controller.serviceSell.value.price ?? 0)} VNĐ',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      Text("Đã bán: ${controller.serviceSell.value.sold ?? 0}"),
                      Container(
                        height: 8,
                        color: Colors.grey[100],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: () {
                                Get.to(()=>AddProductScreen(productId: productId,categoryId:controller.serviceSell.value.categoryServiceSellId! ,))!.then((value) => controller.getServiceSell());
                              },
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 8, 10, 8),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Chỉnh sửa',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    left: 30,
                                    child: Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                SahaDialogApp.showDialogYesNo(
                                    mess: "Bạn chắc chắn xoá không",
                                    onOK: () {
                                      controller.deleteServiceSell();
                                    });
                              },
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Xoá',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    left: 30,
                                    child: Icon(
                                      FontAwesomeIcons.trashCan,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 8,
                        color: Colors.grey[100],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Mô tả sản phẩm",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(controller.serviceSell.value.description ?? ''),
                      // Container(
                      //   height: 8,
                      //   color: Colors.grey[100],
                      // ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // Text(
                      //   "Đánh giá sản phẩm",
                      //   style: TextStyle(
                      //       color: Theme.of(context).primaryColor,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      // Row(
                      //   children: [
                      //     RatingBarIndicator(
                      //       itemSize: 20,
                      //       rating: 4.5,
                      //       direction: Axis.horizontal,
                      //       itemCount: 5,
                      //       itemPadding:
                      //           const EdgeInsets.symmetric(horizontal: 4.0),
                      //       itemBuilder: (context, _) => const Icon(
                      //         Icons.star,
                      //         color: Colors.amber,
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text(
                      //       "4.6/5",
                      //       style: TextStyle(
                      //           color: Theme.of(context).primaryColor),
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     const Text(
                      //       "(15 đánh giá)",
                      //       style: TextStyle(color: Colors.grey),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     comment(),
                      //   ],
                      // )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget comment() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.network(
            '',
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
            child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 235, 235),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phạm Huyền Trang",
                style: TextStyle(
                    color: Theme.of(Get.context!).primaryColor, fontSize: 16),
              ),
              RatingBarIndicator(
                itemSize: 20,
                rating: 4,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
              Text(
                  "Sản phẩm tốt ship nhanh ,dùng hết rồi quay lại đánh gia thật là tuyệt vời"),
            ],
          ),
        ))
      ],
    );
  }
}
