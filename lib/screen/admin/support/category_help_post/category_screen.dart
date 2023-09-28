import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/category_help_post.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/support/category_help_post/add_category/add_category_screen.dart';
import 'package:gohomy/screen/admin/support/category_help_post/category_controller.dart';
import 'package:gohomy/screen/admin/support/category_help_post/update_category/update_category_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController categoryController = CategoryController();
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
          title: const Text('Danh mục bài đăng hỗ trợ')),
      body: Obx(
        () => categoryController.loadInit.value
            ? SahaLoadingFullScreen()
            : categoryController.listCategoryHelpPost.isEmpty
                ? const Center(
                    child: Text('Chưa có danh mục nào'),
                  )
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const MaterialClassicHeader(),
                    onRefresh: () async {
                      await categoryController.getAllAdminCategoryHelpPost(
                          isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await categoryController.getAllAdminCategoryHelpPost();
                      refreshController.loadComplete();
                    },
                    controller: refreshController,
                    child: ListView.builder(
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemCount:
                            categoryController.listCategoryHelpPost.length,
                        itemBuilder: (BuildContext context, int index) {
                          return categoryPost(
                              categoryController.listCategoryHelpPost[index]);
                        }),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddCategoryHelpPostScreen())!.then((value) =>
              categoryController.getAllAdminCategoryHelpPost(isRefresh: true));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget categoryPost(CategoryHelpPost post) {
    return InkWell(
      onTap: () {
        Get.to(() => UpdateCategoryScreen(id: post.id!))!.then((value) =>
            categoryController.getAllAdminCategoryHelpPost(isRefresh: true));
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
                    imageUrl: post.imageUrl ?? '',
                    //placeholder: (context, url) => SahaLoadingWidget(),
                    errorWidget: (context, url, error) => const SahaEmptyImage(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${post.title}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        "${post.description}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
