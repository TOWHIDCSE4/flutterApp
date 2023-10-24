import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/admin/support/help_post/add_help_post/add_help_post_screen.dart';
import 'package:gohomy/screen/admin/support/help_post/help_post_controller.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/support/help_post/update_help_post.dart/update_help_post_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../data/remote/response-request/admin_manage/all_help_post_res.dart';

class HelpPostScreen extends StatefulWidget {
  const HelpPostScreen({Key? key}) : super(key: key);

  @override
  State<HelpPostScreen> createState() => _HelpPostScreenState();
}

class _HelpPostScreenState extends State<HelpPostScreen> {
  HelpPostController helpPostController = HelpPostController();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: const Text('Bài đăng hỗ trợ'),
      ),
      body: Obx(
        () => helpPostController.loadInit.value
            ? SahaLoadingFullScreen()
            : helpPostController.listHelpPost.isEmpty
                ? const Center(
                    child: Text('Chưa có bài đăng nào'),
                  )
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const MaterialClassicHeader(),
                    onRefresh: () async {
                      await helpPostController.getAllAdminHelpPost(
                          isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await helpPostController.getAllAdminHelpPost();
                      refreshController.loadComplete();
                    },
                    controller: refreshController,
                    child: ListView.builder(
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemCount: helpPostController.listHelpPost.length,
                        itemBuilder: (BuildContext context, int index) {
                          return helpPost(
                              helpPostController.listHelpPost[index]);
                        }),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddHelpPostScreen())!.then((value) =>
              helpPostController.getAllAdminHelpPost(isRefresh: true));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget helpPost(HelpPostData helpPostData) {
    return InkWell(
      onTap: () {
        Get.to(() => UpdateHelpPostScreen(
                  helpPostData: helpPostData,
                ))!
            .then((value) =>
                helpPostController.getAllAdminHelpPost(isRefresh: true));
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
