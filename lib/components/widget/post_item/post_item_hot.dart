import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../const/motel_type.dart';
import '../../../model/motel_post.dart';
import '../../../screen/find_room/room_information/room_information_screen.dart';
import '../../../screen/home/home_controller.dart';
import '../../../utils/string_utils.dart';
import '../../empty/saha_empty_image.dart';

class PostItemHot extends StatelessWidget {
  PostItemHot(
      {Key? key,
      this.width,
      this.showCart = true,
      required this.post,
      required this.isAdmin,
      this.isLogin});
  final double? width;
  final bool? showCart;
  final MotelPost post;
  final bool isAdmin;
  final bool? isLogin;
  double? minMoney;
  double? maxMoney;
  int? maxCapacity;
  int? maxArea;
  int? minArea;

  @override
  Widget build(BuildContext context) {
    if (post.towerId != null &&
        post.listMotel != null &&
        post.listMotel!.isNotEmpty) {
      maxMoney = post.listMotel!
          .reduce((value, element) =>
              value.money! > element.money! ? value : element)
          .money;
      minMoney = post.listMotel!
          .reduce((value, element) =>
              value.money! < element.money! ? value : element)
          .money;
    }
    if (post.towerId != null &&
        post.listMotel != null &&
        post.listMotel!.isNotEmpty) {
      maxCapacity = post.listMotel!
          .reduce((value, element) =>
              value.capacity! > element.capacity! ? value : element)
          .capacity;
    }
    if (post.towerId != null &&
        post.listMotel != null &&
        post.listMotel!.isNotEmpty) {
      maxArea = post.listMotel!
          .reduce(
              (value, element) => value.area! > element.area! ? value : element)
          .area;
      minArea = post.listMotel!
          .reduce(
              (value, element) => value.area! < element.area! ? value : element)
          .area;
    }

    return Container(
      color: Colors.white,
      //height: Get.height,
      width: width,
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(13, 13, 13, 13),
        child: InkWell(
          onTap: () {
            Get.to(() => RoomInformationScreen(
                  roomPostId: post.id!,
                ))!.then((value) => Get.find<HomeController>().getAllHomeApp());
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      ((post.images ?? []).isNotEmpty ? post.images![0] : "") +
                          "?reduce_file=true",
                      height: 120,
                      width: 130,
                      fit: BoxFit.cover,
                      // imageUrl:
                      //     (post.images ?? []).isNotEmpty ? post.images![0] : "",
                      //placeholder: (context, url) => const SahaLoadingContainer(),
                      errorBuilder: (context, url, error) =>
                          const SahaEmptyImage(
                        height: 120,
                        width: 130,
                      ),
                    ),
                  ),
                  Positioned.fill(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [
                            0.19,
                            0.5,
                          ],
                          colors: [
                            Colors.black.withOpacity(0.35),
                            Colors.transparent,
                          ],
                        )),
                  )),
                  if (post.isFavorite == true)
                    const Positioned(
                      top: 10,
                      right: 10,
                      child: Icon(
                        color: Colors.red,
                        Icons.favorite_rounded,
                        size: 25,
                      ),
                    ),
                  if (post.adminVerified == true)
                    Positioned(
                        bottom: 10,
                        left: 10,
                        child: SvgPicture.asset(
                            width: 25, 'assets/icon_service/shield.svg')),
                  if (post.totalViews != null &&
                      post.totalViews != 0 &&
                      isAdmin == true)
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: Row(
                          children: [
                            Text(
                              '${post.totalViews ?? 0}',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 10,
                            )
                          ],
                        )),
                  if (post.hostRank == 1)
                    Positioned(
                        top: 10,
                        left: 10,
                        child:
                            SvgPicture.asset(width: 25, 'assets/reward.svg')),
                  if (post.hostRank == 2)
                    Positioned(
                        top: 10,
                        left: -10,
                        child: Image.asset(width: 50, 'assets/vip.png')),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      post.hostRank == 2
                          ? (post.title ?? "").toUpperCase()
                          : (post.title ?? ""),
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 15,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          letterSpacing: 0.1,
                          color: post.hostRank == 2
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.border_style_outlined,
                              color: Colors.grey,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              post.towerId != null
                                  ? '${minArea ?? 0} - ${maxArea ?? 0} m2'
                                  : '${post.area} m2',
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 14,
                            ),
                            Text(
                              post.towerId != null
                                  ? "${maxCapacity ?? 0}"
                                  : '${post.capacity ?? 0}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        if (post.sex == 0)
                          const Text(
                            "Nam / Nữ",
                            style: TextStyle(color: Colors.grey),
                          ),
                        if (post.sex == 1)
                          const Text(
                            'Nam',
                            style: TextStyle(color: Colors.grey),
                          ),
                        if (post.sex == 2)
                          const Text(
                            'Nữ',
                            style: TextStyle(color: Colors.grey),
                          ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Icon(
                            FontAwesomeIcons.dollarSign,
                            color: Theme.of(context).primaryColor,
                            size: 14,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          post.towerId != null
                              ? '${SahaStringUtils().convertToMoney(minMoney ?? 0)} - ${SahaStringUtils().convertToMoney(maxMoney ?? 0)} đ'
                              : '${SahaStringUtils().convertToMoney(post.money ?? 0)} VNĐ/${typeUnitRoom[post.type ?? 0]}',
                          style: TextStyle(
                              color: post.hostRank == 2
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: Text(
                            isLogin != true
                                ? "${post.districtName ?? ""}${post.districtName != null ? ", " : ""}${post.provinceName ?? ""}"
                                : '${post.addressDetail ?? ""}${post.addressDetail == null ? "" : ", "}${post.wardsName ?? ""}${post.wardsName != null ? ", " : ""}${post.districtName ?? ""}${post.districtName != null ? ", " : ""}${post.provinceName ?? ""}',
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              height: 1.2,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      post.towerId != null
                          ? "Tên toà nhà: ${post.towerName ?? ""}"
                          : "Số/tên phòng: ${post.motelName ?? ''}",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
