import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/motel_post.dart';
import '../../../const/motel_type.dart';
import '../../../screen/data_app_controller.dart';
import '../../../screen/find_room/room_information/room_information_screen.dart';
import '../../../screen/home/home_controller.dart';
import '../../../utils/string_utils.dart';
import '../../empty/saha_empty_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../loading/loading_container.dart';

class PostItem extends StatelessWidget {
  PostItem(
      {Key? key,
      this.isInPost,
      this.showCart = true,
      required this.post,
      this.height,
      this.width,
      this.isLogin});

  final bool? showCart;
  final bool? isInPost;
  final MotelPost post;
  final double? height;
  final double? width;
  final bool? isLogin;
  int? maxCapacity;
  int? maxArea;
  int? minArea;

  @override
  Widget build(BuildContext context) {
    double? minMoney;
    double? maxMoney;
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

    return SizedBox(
      height: height ?? 350,
      width:
          width ?? (isInPost == true ? Get.width / 2.2 : (Get.width - 10) / 2),
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(7),
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoomInformationScreen(
                            roomPostId: post.id!,
                          )),
                ).then((value) => Get.find<HomeController>().getAllHomeApp());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              ((post.images ?? []).isNotEmpty
                                      ? post.images![0]
                                      : "") +
                                  "?reduce_file=true",
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              // imageUrl: (post.images ?? []).isNotEmpty
                              //     ? post.images![0]
                              //     : "",
                              // placeholder: (context, url) =>
                              //     const SahaLoadingContainer(),
                              errorBuilder: (context, url, error) =>
                                  const SahaEmptyImage(
                                height: double.infinity,
                                width: double.infinity,
                              ),
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
                            (Get.find<DataAppController>()
                                        .currentUser
                                        .value
                                        .isAdmin ??
                                    false) ==
                                true)
                          Positioned(
                              bottom: 10,
                              right: 10,
                              child: Container(
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
                                ),
                              )),
                        if (post.hostRank == 1)
                          Positioned(
                              top: 10,
                              left: 10,
                              child: SvgPicture.asset(
                                  width: 25, 'assets/reward.svg')),
                        if (post.hostRank == 2)
                          Positioned(
                              top: 10,
                              left: -10,
                              child: Image.asset(width: 50, 'assets/vip.png')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${SahaStringUtils().displayTimeAgoFromTime(post.createdAt ?? DateTime.now())}. ',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
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
                            const SizedBox(
                              width: 5,
                            ),
                            if (post.sex == 0 || post.sex == 1)
                              const Icon(
                                Icons.male_outlined,
                                size: 14,
                                color: Colors.grey,
                              ),
                            if (post.sex == 0 || post.sex == 2)
                              const Icon(
                                Icons.female_outlined,
                                size: 14,
                                color: Colors.grey,
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 35,
                            child: AutoSizeText(
                              post.hostRank == 2
                                  ? (post.title ?? "").toUpperCase()
                                  : (post.title ?? ""),
                              overflow: TextOverflow.ellipsis,
                              minFontSize: 15,
                              style: TextStyle(
                                color: post.hostRank == 2
                                    ? Theme.of(context).primaryColor
                                    : null,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                                letterSpacing: 0.1,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.border_style_outlined,
                              color: Colors.grey,
                              size: 14,
                            ),
                            Text(
                              post.towerId != null
                                  ? '${minArea ?? 0} - ${maxArea ?? 0} m2'
                                  : '${post.area} m2',
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.dollarSign,
                              color: Theme.of(context).primaryColor,
                              size: 14,
                            ),
                            Expanded(
                              child: Text(
                                post.towerId != null
                                    ? '${SahaStringUtils().convertToMoney(minMoney ?? 0)} - ${SahaStringUtils().convertToMoney(maxMoney ?? 0)} VNĐ'
                                    : '${SahaStringUtils().convertToMoney(post.money ?? 0)} VNĐ/${typeUnitRoom[post.type ?? 0]}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color:  Theme.of(context).primaryColor,
                                        
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey,
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
                         Text(post.towerId != null ? "Tên toà nhà: ${post.towerName ?? ""}" : "Số/tên phòng: ${post.motelName ?? ''}",style: const TextStyle(color: Colors.grey,fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)
                      ],
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
}
