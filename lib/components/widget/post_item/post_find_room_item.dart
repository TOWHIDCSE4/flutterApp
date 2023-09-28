import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../const/motel_type.dart';
import '../../../model/motel_post.dart';
import '../../../model/post_roommate.dart';
import '../../../screen/data_app_controller.dart';
import '../../../screen/find_room/post_roommate/post_roommate_screen.dart';
import '../../../utils/string_utils.dart';
import '../../empty/saha_empty_image.dart';

class PostFindRoomItem extends StatelessWidget {
  const PostFindRoomItem(
      {Key? key,
      this.isInPost,
      this.showCart = true,
      required this.post,
      this.height,
      this.width,this.isLogin});

  final bool? showCart;
  final bool? isInPost;
  final PostRoommate post;
  final double? height;
  final double? width;
  final bool? isLogin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 300,
      width:
          width ?? (isInPost == true ? Get.width / 2.2 : (Get.width - 10) / 2),
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(7),
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                Get.to(()=>PostRoommateScreen(postRoommateId: post.id!,));
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
                        // if (post.hostRank == 1)
                        //   Positioned(
                        //       top: 10,
                        //       left: 10,
                        //       child: SvgPicture.asset(
                        //           width: 25, 'assets/reward.svg')),
                        // if (post.hostRank == 2)
                        //   Positioned(
                        //       top: 10,
                        //       left: -10,
                        //       child: Image.asset(width: 50, 'assets/vip.png')),
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
                              '${post.capacity ?? 0}',
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
                            height: 40,
                            child: AutoSizeText(
                              (post.title ?? "").toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              minFontSize: 15,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
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
                            Icon(
                              FontAwesomeIcons.dollarSign,
                              color: Theme.of(context).primaryColor,
                              size: 14,
                            ),
                            Text(
                              '${SahaStringUtils().convertToMoney(post.money ?? 0)} VNĐ/${typeUnitRoom[post.type ?? 0]}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500),
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
                                 isLogin != true ? "${post.districtName ?? ""}${post.districtName != null ? ", " : ""}${post.provinceName ?? ""}":
                                                    '${post.addressDetail ?? ""}${post.addressDetail == null ? "" : ", "}${post.wardsName ?? ""}${post.wardsName != null ? ", " : ""}${post.districtName ?? ""}${post.districtName != null ? ", " : ""}${post.provinceName ?? ""}',
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
                        )
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
