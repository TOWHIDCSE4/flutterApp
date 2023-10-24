import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/admin/support/category_help_post/update_category/update_category_controller.dart';

import '../../../../../components/button/saha_button.dart';
import '../../../../../components/dialog/dialog.dart';
import '../../../../../components/text_field/sahashopTextField.dart';
import '../../../../../const/type_image.dart';
import '../../../../profile/edit_profile/widget/select_avatar_image.dart';

class UpdateCategoryScreen extends StatefulWidget {
  UpdateCategoryScreen({Key? key, required this.id}) : super(key: key);
  int id;
  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  UpdateCategoryController updateCategoryController =
      UpdateCategoryController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    updateCategoryController.getCategoryHelp(id: widget.id);
  }

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
                  // begin: Alignment.bottomLeft,
                  // end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
          title: const Text('Cập nhật danh mục'),
          actions: [
            GestureDetector(
              onTap: () {
                SahaDialogApp.showDialogYesNo(
                    mess: "Bạn có chắc muốn xoá bài đăng này",
                    onClose: () {},
                    onOK: () {
                      updateCategoryController.deleteCategoryHelp(
                          id: widget.id);
                    });
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                child: const Icon(
                  FontAwesomeIcons.trashCan,
                ),
              ),
            )
          ],
        ),
        body: Obx(
          () => updateCategoryController.loadInit.value
              ? SahaLoadingFullScreen()
              : Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SahaTextField(
                          validator: (value) {
                            if ((value ??'').isEmpty) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                          withAsterisk: true,
                          labelText: 'Danh mục bài đăng hỗ trợ',
                          hintText: "Nhập tiêu đề danh mục",
                          controller: updateCategoryController.titleController,
                          onChanged: (v) {
                            updateCategoryController.categoryPost.value.title =
                                v;
                          },
                        ),
                        SahaTextField(
                          validator: (value) {
                            if ((value ??'').isEmpty) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                          withAsterisk: true,
                          labelText: 'Mô tả',
                          hintText: "Nhập mô tả",
                          controller:
                              updateCategoryController.descriptionController,
                          onChanged: (v) {
                            updateCategoryController
                                .categoryPost.value.description = v;
                          },
                        ),
                        Obx(
                          () => SelectAvatarImage(
                            type: ANOTHER_FILES_FOLDER,
                            linkLogo:
                                updateCategoryController.linkUrl.value == ""
                                    ? null
                                    : updateCategoryController.linkUrl.value,
                            onChange: (link) {
                              print(link);
                              updateCategoryController.linkUrl.value = link;
                              updateCategoryController
                                  .categoryPost.value.imageUrl = link;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                text: 'Cập nhật danh mục bài dăng hỗ trợ',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateCategoryController.categoryPost.value.isShow = true;
                    updateCategoryController.updateCategoryHelp(id: widget.id);
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
