import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/text_field/sahashopTextField.dart';
import 'package:gohomy/screen/admin/support/category_help_post/add_category/add_category_controller.dart';

import '../../../../../components/button/saha_button.dart';
import '../../../../../const/type_image.dart';
import '../../../../profile/edit_profile/widget/select_avatar_image.dart';

class AddCategoryHelpPostScreen extends StatefulWidget {
  const AddCategoryHelpPostScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryHelpPostScreen> createState() =>
      _AddCategoryHelpPostScreenState();
}

class _AddCategoryHelpPostScreenState extends State<AddCategoryHelpPostScreen> {
  AddCategoryController addCategoryController = AddCategoryController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Color(0xFFEF4355),
                    Color(0xFFFF964E),
                  ]),
            ),
          ),
          title: const Text('Thêm danh mục bài đăng hỗ trợ'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SahaTextField(
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return 'Không được để trống';
                    }
                    return null;
                  },
                  withAsterisk: true,
                  labelText: 'Danh mục bài đăng hỗ trợ',
                  hintText: "Nhập tên danh mục",
                  controller: addCategoryController.titleController,
                  onChanged: (v) {
                    addCategoryController.categoryPost.value.title = v;
                  },
                ),
                SahaTextField(
                  validator: (value) {
                    if ((value??'').isEmpty) {
                      return 'Không được để trống';
                    }
                    return null;
                  },
                  withAsterisk: true,
                  labelText: 'Mô tả',
                  hintText: "Nhập mô tả",
                  controller: addCategoryController.descriptionController,
                  onChanged: (v) {
                    addCategoryController.categoryPost.value.description = v;
                  },
                ),
                Obx(
                  () => SelectAvatarImage(
                    type: ANOTHER_FILES_FOLDER,
                    linkLogo: addCategoryController.linkUrl.value == ""
                        ? null
                        : addCategoryController.linkUrl.value,
                    onChange: (link) {
                      print(link);
                      addCategoryController.linkUrl.value = link;
                      addCategoryController.categoryPost.value.imageUrl = link;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                text: 'Thêm danh mục bài dăng hỗ trợ',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addCategoryController.categoryPost.value.isShow = true;
                    addCategoryController.addCategoryHelpPost();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
