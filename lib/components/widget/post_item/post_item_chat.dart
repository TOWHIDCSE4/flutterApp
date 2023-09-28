import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../const/motel_type.dart';
import '../../../model/motel_post.dart';
import '../../../screen/find_room/room_information/room_information_screen.dart';
import '../../../utils/string_utils.dart';
import '../../empty/saha_empty_image.dart';

class PostItemChat extends StatelessWidget {
   PostItemChat(
      {Key? key,
        this.width,
        this.showCart = true,
        required this.post,
        required this.isAdmin});
  final double? width;
  final bool? showCart;
  final MotelPost post;
  final  bool isAdmin;
  double? minMoney;
    double? maxMoney;


  @override
  Widget build(BuildContext context) {
     
     if(post.towerId != null && post.listMotel != null && post.listMotel!.isNotEmpty){
            maxMoney = post.listMotel!
        .reduce(
            (value, element) => value.money! > element.money! ? value : element)
        .money;
         minMoney = post.listMotel!
        .reduce(
            (value, element) => value.money! < element.money! ? value : element)
        .money;
      }
    return Container(
      color: Colors.white,
      //height: Get.height,
      width: width,
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),

        child: InkWell(
          onTap: () {
            print('========>${post.listMotel.toString()}');
            Get.to(() => RoomInformationScreen(
              roomPostId: post.id!,
            ));

          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      ((post.images ?? []).isNotEmpty ? post.images![0] : "") + "?reduce_file=true",
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                      // imageUrl:
                      //     (post.images ?? []).isNotEmpty ? post.images![0] : "",
                      //placeholder: (context, url) => const SahaLoadingContainer(),
                      errorBuilder: (context, url, error) => const SahaEmptyImage(height: 120,width: 130,),
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
                      minFontSize: 13,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          height: 1.1,
                          letterSpacing: 0.1,
                          color: post.hostRank == 2
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      maxLines: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.border_style_outlined,
                              color: Colors.grey,
                              size: 12,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              '${post.area ?? ''} m2',
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
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
                              size: 12,
                            ),
                            Text(
                              '${post.capacity ?? 0}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (post.sex == 0)
                          const Text(
                            "Nam / Nữ",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        if (post.sex == 1)
                          const Text(
                            'Nam',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        if (post.sex == 2)
                          const Text(
                            'Nữ',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
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
                           post.towerId != null ?
                              '${SahaStringUtils().convertToMoney(minMoney ?? 0)} - ${SahaStringUtils().convertToMoney(maxMoney ?? 0)} đ':
                              '${SahaStringUtils().convertToMoney(post.money ?? 0)} VNĐ/${typeUnitRoom[post.type ?? 0]}',
                          style: TextStyle(
                              color: post.hostRank == 2
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 13,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: Text(
                            '${post.addressDetail ?? ""}${post.addressDetail == null ? "" : ", "}${post.wardsName ?? ""}${post.wardsName != null ? ", " : ""}${post.districtName ?? ""}${post.districtName != null ? ", " : ""}${post.provinceName ?? ""}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                    Text(post.towerId != null ? "Tên toà nhà: ${post.towerName ?? ""}" : "Số/tên phòng: ${post.motelName ?? ''}",style:  TextStyle(color: Theme.of(context).primaryColor,fontSize: 12,),)
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
