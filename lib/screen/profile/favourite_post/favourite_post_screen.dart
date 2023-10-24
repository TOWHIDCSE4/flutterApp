import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/profile/favourite_post/favourite_post_controller.dart';
import 'package:gohomy/screen/profile/favourite_post/favourite_post_details/favourite_details_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/loading/loading_widget.dart';
import '../../../const/motel_type.dart';
import '../../../model/motel_post.dart';
import '../../../utils/string_utils.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  FavouritePostController favouritePostController = FavouritePostController();
  RefreshController refreshController = RefreshController();
  @override
  void initState() {
    favouritePostController.getAllMotelPost(isRefresh: true);
    super.initState();
  }

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
        title: const Text('Bài đăng yêu thích'),
      ),
      body: Obx(
        () => favouritePostController.loadInit.value
            ? SahaLoadingFullScreen()
            : favouritePostController.favouritePost.isEmpty
                ? const Center(child: Text("Không có bài đăng"))
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const MaterialClassicHeader(),
                    footer: CustomFooter(
                      builder: (
                        BuildContext context,
                        LoadStatus? mode,
                      ) {
                        Widget body = Container();
                        if (mode == LoadStatus.idle) {
                          body = Obx(() =>
                              favouritePostController.isLoading.value
                                  ? const CupertinoActivityIndicator()
                                  : Container());
                        } else if (mode == LoadStatus.loading) {
                          body = const CupertinoActivityIndicator();
                        }
                        return SizedBox(
                          height: 100,
                          child: Center(child: body),
                        );
                      },
                    ),
                    onRefresh: () async {
                      await favouritePostController.getAllMotelPost(
                          isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await favouritePostController.getAllMotelPost();
                      refreshController.loadComplete();
                    },
                    controller: refreshController,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        ...favouritePostController.favouritePost.value
                            .map((e) => postItem(e))
                      ]),
                    ),
                  ),
      ),
    );
  }

  // Widget itemPost({required MotelPost motelPost, context}) {
  //   return GestureDetector(
  //     onTap: () {
  //       Get.to(() => FavouriteDetailsScreen(
  //                 roomPostId: motelPost.id,
  //               ))!
  //           .then((value) =>
  //               favouritePostController.getAllMotelPost(isRefresh: true));
  //     },
  //     child: Container(
  //       margin: EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.5),
  //             spreadRadius: 1,
  //             blurRadius: 1,
  //             offset: Offset(0, 3), // changes position of shadow
  //           ),
  //         ],
  //       ),
  //       padding: EdgeInsets.all(10),
  //       child: Row(
  //         children: [
  //           Stack(
  //             children: [
  //               Container(
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(5.0),
  //                   child: CachedNetworkImage(
  //                     height: 100,
  //                     width: 100,
  //                     fit: BoxFit.cover,
  //                     imageUrl: (motelPost.images ?? []).isEmpty
  //                         ? ""
  //                         : motelPost.images![0],
  //                     placeholder: (context, url) => SahaLoadingWidget(),
  //                     errorWidget: (context, url, error) => SahaEmptyImage(),
  //                   ),
  //                 ),
  //               ),
  //               Positioned(
  //                   bottom: -8,
  //                   left: -8,
  //                   child: IconButton(
  //                       onPressed: () {},
  //                       icon: motelPost.adminVerified == true
  //                           ? SvgPicture.asset(
  //                               width: 20, 'assets/icon_service/shield.svg')
  //                           : Container()))
  //             ],
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   "${motelPost.title}",
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(
  //                     top: 10,
  //                     bottom: 10,
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Text(
  //                             "Tiền phòng: ",
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                           ),
  //                           Text(
  //                             "${SahaStringUtils().convertToMoney(motelPost.money)}đ",
  //                           ),
  //                         ],
  //                       ),
  //                       Text(
  //                         "${motelPost.phoneNumber}",
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Text(
  //                   '${motelPost.addressDetail ?? ""}${motelPost.addressDetail == null ? "" : ", "}${motelPost.wardsName ?? ""}${motelPost.wardsName != null ? ", " : ""}${motelPost.districtName ?? ""}${motelPost.districtName != null ? ", " : ""}${motelPost.provinceName ?? ""}',
  //                   maxLines: 2,
  //                   style: TextStyle(
  //                     color: Colors.grey,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(
  //                     top: 5,
  //                     bottom: 5,
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Icon(
  //                             FontAwesomeIcons.peopleRoof,
  //                             color: Color(0xFF00B894),
  //                             size: 18,
  //                           ),
  //                           SizedBox(
  //                             width: 10,
  //                           ),
  //                           Text(
  //                             "${motelPost.capacity ?? ""}",
  //                           ),
  //                         ],
  //                       ),
  //                       Row(
  //                         children: [
  //                           Icon(
  //                             motelPost.sex == 0
  //                                 ? FontAwesomeIcons.marsAndVenus
  //                                 : motelPost.sex == 1
  //                                     ? FontAwesomeIcons.mars
  //                                     : FontAwesomeIcons.venus,
  //                             color: motelPost.sex == 0
  //                                 ? Color(0xFFBDC3C7)
  //                                 : motelPost.sex == 1
  //                                     ? Color(0xFF2980B9)
  //                                     : Color(0xFFE84393),
  //                             size: 15,
  //                           ),
  //                           SizedBox(
  //                             width: 5,
  //                           ),
  //                           Text(
  //                             motelPost.sex == 0
  //                                 ? "Nam, Nữ"
  //                                 : motelPost.sex == 1
  //                                     ? "Nam"
  //                                     : "Nữ",
  //                           ),
  //                         ],
  //                       ),
  //                       Row(
  //                         children: [
  //                           Icon(
  //                             FontAwesomeIcons.house,
  //                             color: Color(0xFFFDCB6E),
  //                             size: 15,
  //                           ),
  //                           SizedBox(
  //                             width: 10,
  //                           ),
  //                           Text("${motelPost.area ?? ""}m²"),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget postItem(MotelPost item) {
    return GestureDetector(
      onTap: () {
        Get.to(() => FavouriteDetailsScreen(
                  roomPostId: item.id,
                ))!
            .then((value) =>
                favouritePostController.getAllMotelPost(isRefresh: true));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
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
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: CachedNetworkImage(
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      imageUrl:
                          (item.images ?? []).isEmpty ? "" : item.images![0],
                      //placeholder: (context, url) => SahaLoadingWidget(),
                      errorWidget: (context, url, error) => const SahaEmptyImage(),
                    ),
                  ),
                ),
                if (item.isFavorite == true)
                  const Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(
                      color: Colors.red,
                      Icons.favorite_rounded,
                      size: 25,
                    ),
                  ),
                if (item.adminVerified == true)
                  Positioned(
                      bottom: 10,
                      left: 5,
                      child: SvgPicture.asset(
                          width: 25, 'assets/icon_service/shield.svg')),
                if (item.totalViews != null && item.totalViews != 0)
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              '${item.totalViews ?? 0}',
                              style:
                                  const TextStyle(fontSize: 12, color: Colors.white),
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
                if (item.hostRank == 1)
                  Positioned(
                      top: 10,
                      left: 5,
                      child: SvgPicture.asset(width: 25, 'assets/reward.svg')),
                if (item.hostRank == 2)
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.title}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        letterSpacing: 0.1,
                        color: item.hostRank == 2
                            ? Theme.of(context).primaryColor
                            : Colors.black),
                  ),
                  const SizedBox(
                    height: 5,
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
                            '${item.area} m2',
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
                            '${item.capacity ?? 0}',
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
                      if (item.sex == 0)
                        const Text(
                          "Nam / Nữ",
                          style: TextStyle(color: Colors.grey),
                        ),
                      if (item.sex == 1)
                        const Text(
                          'Nam',
                          style: TextStyle(color: Colors.grey),
                        ),
                      if (item.sex == 2)
                        const Text(
                          'Nữ',
                          style: TextStyle(color: Colors.grey),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 0,
                      bottom: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              '${SahaStringUtils().convertToMoney(item.money ?? 0)} VNĐ/${typeUnitRoom[item.type ?? 0]}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          "${item.phoneNumber}",
                        ),
                      ],
                    ),
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
                      Expanded(
                        child: Text(
                          '${item.addressDetail ?? ""}${item.addressDetail == null ? "" : ", "}${item.wardsName ?? ""}${item.wardsName != null ? ", " : ""}${item.districtName ?? ""}${item.districtName != null ? ", " : ""}${item.provinceName ?? ""}',
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
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
