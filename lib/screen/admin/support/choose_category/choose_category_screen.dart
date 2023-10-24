import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/category_help_post.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/loading/loading_container.dart';
import '../../../../components/loading/loading_full_screen.dart';
import 'choose_category_controller.dart';

class ChooseCategoryScreen extends StatefulWidget {
  ChooseCategoryScreen(
      {Key? key, required this.onChoose, this.listCategorySelected})
      : super(key: key);
  Function onChoose;
  List<CategoryHelpPost>? listCategorySelected;
  @override
  State<ChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  ChooseCategoryController chooseCategoryController =
      ChooseCategoryController();
  @override
  void initState() {
    super.initState();
    chooseCategoryController.listCategorySelected.value =
        widget.listCategorySelected ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chọn loại bài đăng hỗ trợ')),
      body: Column(
        children: [
          // SahaTextFieldSearch(
          //   hintText: "Tìm kiếm người thuê",
          //   onChanged: (va) {
          //     EasyDebounce.debounce('list_users', Duration(milliseconds: 300),
          //         () {
          //       chooseRenterController.textSearch = va;
          //       chooseRenterController.getAllRenter(isRefresh: true);
          //     });
          //   },
          //   onClose: () {
          //     chooseRenterController.textSearch = "";
          //     chooseRenterController.getAllRenter(isRefresh: true);
          //   },
          // ),
          Expanded(
            child: Obx(
              () => chooseCategoryController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : SingleChildScrollView(
                      child: Column(
                        children: chooseCategoryController.listCategoryPost
                            .map((e) => itemRenter(e))
                            .toList(),
                      ),
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Xác nhận",
              onPressed: () {
                if (chooseCategoryController.listCategorySelected.isNotEmpty) {
                  widget
                      .onChoose(chooseCategoryController.listCategorySelected);
                }
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemRenter(CategoryHelpPost post) {
    return InkWell(
      onTap: () {
        chooseCategoryController.listCategorySelected([post]);
        // if (only == true) {
        //   chooseRenterController.listRenterSelected([renter]);
        // } else {
        //   if (chooseRenterController.listRenterSelected
        //       .map((e) => e.id)
        //       .toList()
        //       .contains(renter.id)) {
        //     chooseRenterController.listRenterSelected
        //         .removeWhere((e) => e.id == renter.id);
        //   } else {
        //     chooseRenterController.listRenterSelected.add(renter);
        //   }
        // }
      },
      child: Container(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3000),
                child: CachedNetworkImage(
                  imageUrl: post.imageUrl ?? '',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  //placeholder: (context, url) => const SahaLoadingContainer(),
                  errorWidget: (context, url, error) => const SahaEmptyAvata(
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          post.title ?? "Chưa đặt tên",
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Checkbox(
                value: chooseCategoryController.listCategorySelected
                    .map((e) => e.id)
                    .toList()
                    .contains(post.id),
                onChanged: (v) {
                  chooseCategoryController.listCategorySelected([post]);
                  // if (only == true) {
                  //   chooseRenterController.listRenterSelected([renter]);
                  // } else {
                  //   if (chooseRenterController.listRenterSelected
                  //       .map((e) => e.id)
                  //       .toList()
                  //       .contains(renter.id)) {
                  //     chooseRenterController.listRenterSelected
                  //         .removeWhere((e) => e.id == renter.id);
                  //   } else {
                  //     chooseRenterController.listRenterSelected.add(renter);
                  //   }
                  // }
                })
          ],
        ),
      ),
    );
  }
}
