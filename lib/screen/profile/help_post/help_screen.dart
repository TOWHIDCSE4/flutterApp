import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/home/home_controller.dart';
import 'package:gohomy/screen/profile/help_post/help_controller.dart';
import 'package:gohomy/screen/profile/help_post/help_post_details/help_post_details_screen.dart';
import 'package:gohomy/utils/call.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/loading/loading_widget.dart';
import '../../../data/remote/response-request/admin_manage/all_help_post_res.dart';
import '../../../model/category_help_post.dart';
import '../../../utils/debounce.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  HelpController helpController = HelpController();
  RefreshController refreshController = RefreshController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => helpController.isSearch.value == true
              ? Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        helpController.search.value = value;
                        helpController.getAllHelpPost(isRefresh: true);
                      },
                      controller: helpController.searchEdit,
                      autofocus: helpController.isSearch.value ? true : false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.only(right: 15, top: 20, bottom: 5),
                        border: InputBorder.none,
                        hintText: "Tìm kiếm",
                        suffixIcon: IconButton(
                          onPressed: () {
                            helpController.searchEdit.clear();
                            //chatListController.listBoxChatSearch([]);
                            helpController.search.value = '';
                            helpController.getAllHelpPost(isRefresh: true);
                            FocusScope.of(context).unfocus();

                            helpController.isSearch.value = false;
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 15,
                          ),
                        ),
                      ),
                      onChanged: (v) {
                        EasyDebounce.debounce('debounce_timer_chatlist_search',
                            const Duration(milliseconds: 500), () {
                          helpController.search.value = v;
                          helpController.getAllHelpPost(isRefresh: true);

                          // if (v == '') {
                          //   chatListController.listBoxChatSearch([]);
                          // } else {
                          //   chatListController.textSearch = v;
                          //   chatListController.getAllBoxChat(isRefresh: true);
                          // }
                        });
                      },
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                )
              : const Text('Hỗ trợ'),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (helpController.isSearch.value == false) {
                  helpController.isSearch.value = true;
                } else {
                  helpController.isSearch.value = false;
                }
              }),
        ],
      ),
      body: Obx(
        () => helpController.loadInit.value
            ? SahaLoadingFullScreen()
            : helpController.listCategoryHelpPost.isEmpty
                ? const Center(
                    child: Text('Chưa có bài hỗ trợ'),
                  )
                : Column(
                    children: [
                      if (helpController.search.value == '')
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  helpController.allPost.value = true;
                                  helpController.idChoose.value = 0;
                                  //helpController.choose = null;
                                  helpController.getAllHelpPost(
                                      isRefresh: true);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: helpController.idChoose.value == 0
                                      ? BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          color: Colors.white,
                                        )
                                      : const BoxDecoration(),
                                  child: Center(
                                      child: Text(
                                    'Tất cả',
                                    style: TextStyle(
                                        color:
                                            helpController.idChoose.value == 0
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ),
                              ),
                              ...helpController.listCategoryHelpPost.value
                                  .map((e) => categoryItem(e)),
                            ],
                          ),
                        ),
                      Expanded(
                        child: helpController.listHelpPost.isEmpty
                            ? const Center(
                                child: Text('Chưa có bài hỗ trợ'),
                              )
                            : SmartRefresher(
                                footer: CustomFooter(
                                  builder: (
                                    BuildContext context,
                                    LoadStatus? mode,
                                  ) {
                                    Widget body = Container();
                                    if (mode == LoadStatus.idle) {
                                      body = Obx(() =>
                                          helpController.isLoading.value
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
                                controller: refreshController,
                                enablePullDown: true,
                                enablePullUp: true,
                                header: const MaterialClassicHeader(),
                                onRefresh: () async {
                                  await helpController.getAllHelpPost(
                                      isRefresh: true);
                                  refreshController.refreshCompleted();
                                },
                                onLoading: () async {
                                  await helpController.getAllHelpPost();
                                  refreshController.loadComplete();
                                },
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      ...helpController.listHelpPost
                                          .map((e) => helpPost(e))
                                    ],
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icon_admin/trong-muc-trung-tam-tro-giup.png',
              height: 80,
              width: 80,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Cần hỗ trợ thêm ?"),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Call.call(Get.find<HomeController>()
                            .homeApp
                            .value
                            .adminContact
                            ?.phoneNumber ??
                        '');
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      'Trò chuyện ngay',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Call.call(Get.find<HomeController>()
                            .homeApp
                            .value
                            .adminContact
                            ?.phoneNumber ??
                        '');
                  },
                  child: Text(
                    "Hoặc gọi đến RENCITY",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryItem(CategoryHelpPost categoryHelpPost) {
    return InkWell(
      onTap: () {
        helpController.idChoose.value = categoryHelpPost.id!;
        helpController.allPost.value = false;
        //helpController.choose = categoryHelpPost.id!;
        helpController.getAllHelpPost(isRefresh: true);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: helpController.idChoose == categoryHelpPost.id
            ? BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Theme.of(context).primaryColor)),
                color: Colors.white,
              )
            : const BoxDecoration(),
        child: Center(
            child: Text(
          categoryHelpPost.title ?? '',
          style: TextStyle(
              color: helpController.idChoose == categoryHelpPost.id
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              fontWeight: FontWeight.w500),
        )),
      ),
    );
  }

  Widget helpPost(HelpPostData helpPostData) {
    return InkWell(
      onTap: () {
        Get.to(() => HelpPostDetailsScreen(id: helpPostData.id!));
      },
      child: Container(
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    imageUrl: helpPostData.helpPost?.imageUrl ?? '',
                    //placeholder: (context, url) => SahaLoadingWidget(),
                    errorWidget: (context, url, error) => const SahaEmptyImage(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      helpPostData.helpPost?.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      helpPostData.categoryHelpPost?.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      helpPostData.helpPost?.summary ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
