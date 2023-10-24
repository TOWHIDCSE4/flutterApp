import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/service_sell.dart';
import 'package:gohomy/screen/profile/service_sell/product_user_detail/product_user_detail_screen.dart';
import '../../../screen/home/home_controller.dart';
import '../../../utils/string_utils.dart';
import '../../empty/saha_empty_image.dart';
import '../../loading/loading_container.dart';

class ServiceSellItem extends StatelessWidget {
  ServiceSellItem({
    Key? key,
    this.width,
    required this.onBuyNow,
    required this.onAddToCart,
    required this.serviceSell,
  });

  double? width;
  Function onBuyNow;
  Function onAddToCart;
  ServiceSell serviceSell;
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: width,
      child: Container(
        margin: const EdgeInsets.all(7),
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => RoomInformationScreen(
                //         roomPostId: post.id!,
                //       )),
                // ).then((value) => homeController.getAllHomeApp());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      Get.to(
                          () => ProductUserDetailScreen(id: serviceSell.id!));
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: (serviceSell.images ?? []).isNotEmpty
                                ? serviceSell.images![0]
                                : "",
                            //placeholder: (context, url) => const SahaLoadingContainer(),
                            errorWidget: (context, url, error) =>
                                const SahaEmptyImage(),
                          ),
                        ),
                      ],
                    ),
                  )),
                  // if (post.totalViews != null &&
                  //     post.totalViews != 0 &&
                  //     isAdmin == true)

                  SizedBox(
                    height: 130,
                    child: Stack(children: [
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Row(
                            children: [
                              Text(
                                "${Random().nextInt(1000) + 300}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.remove_red_eye,
                                color: Theme.of(Get.context!).primaryColor,
                                size: 14,
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  serviceSell.name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                      letterSpacing: 0.1,
                                      color: Colors.black),
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${SahaStringUtils().convertToMoney(serviceSell.price ?? 0)} VNĐ',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      onBuyNow();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Center(
                                        child: Text(
                                          "Mua ngay",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    onAddToCart();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Icon(
                                        Icons.add_shopping_cart_rounded,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
