import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/text_field/sahashopTextField.dart';
import 'package:gohomy/screen/admin/support/choose_category/choose_category_screen.dart';
import 'package:gohomy/screen/admin/support/help_post/add_help_post/add_help_post_controller.dart';

import '../../../../../components/button/saha_button.dart';
import '../../../../../components/text_field/text_field_no_border.dart';
import '../../../../../const/type_image.dart';
import '../../../../profile/edit_profile/widget/select_avatar_image.dart';

class AddHelpPostScreen extends StatefulWidget {
  const AddHelpPostScreen({Key? key}) : super(key: key);

  @override
  State<AddHelpPostScreen> createState() => _AddHelpPostScreenState();
}

class _AddHelpPostScreenState extends State<AddHelpPostScreen> {
  AddHelpPostController addHelpPostController = AddHelpPostController();
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
          title: const Text('Thêm bài đăng hỗ trợ'),
        ),
        body: Form(
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
                  labelText: 'Tiêu đề bài đăng hỗ trợ',
                  hintText: 'Nhập tiêu đề bài đăng hỗ trợ',
                  controller: addHelpPostController.titleController,
                  withAsterisk: true,
                  onChanged: (v) {
                    addHelpPostController.helpPostRequest.value.title = v;
                  },
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => ChooseCategoryScreen(
                          onChoose: (v) {
                            addHelpPostController.categoryNameController.text =
                                v.value[0].title;
                            addHelpPostController.helpPostRequest.value
                                .categoryHelpPostId = v.value[0].id;
                            addHelpPostController.listCategorySelected.value = [
                              v.value[0]
                            ];
                          },
                          listCategorySelected:
                              addHelpPostController.listCategorySelected,
                        ));
                  },
                  child: SahaTextFieldNoBorder(
                    onTap: () {
                      Get.to(() => ChooseCategoryScreen(
                            onChoose: (v) {
                              addHelpPostController.categoryNameController
                                  .text = v.value[0].title;
                              addHelpPostController.helpPostRequest.value
                                  .categoryHelpPostId = v.value[0].id;
                              addHelpPostController.listCategorySelected.value =
                                  [v.value[0]];
                            },
                            listCategorySelected:
                                addHelpPostController.listCategorySelected,
                          ));
                    },
                    readOnly: true,
                    // validator: (value) {
                    //   if (value!.length == null || value.isEmpty) {
                    //     return 'Không được để trống';
                    //   }
                    //   return null;
                    // },
                    labelText: 'Danh mục bài đăng hỗ trợ',
                    hintText: 'Chọn danh mục bài đăng hỗ trợ',
                    controller: addHelpPostController.categoryNameController,
                  ),
                ),
                SahaTextField(
                  // validator: (value) {
                  //   if (value!.length == null || value.isEmpty) {
                  //     return 'Không được để trống';
                  //   }
                  //   return null;
                  // },
                  labelText: 'Tóm tắt bài đăng hỗ trợ',
                  hintText: 'Nhập tóm tắt bài đăng',
                  controller: addHelpPostController.summaryController,

                  onChanged: (v) {
                    addHelpPostController.helpPostRequest.value.summary = v;
                  },
                ),
                Obx(
                  () => SelectAvatarImage(
                    type: ANOTHER_FILES_FOLDER,
                    linkLogo: addHelpPostController.linkUrl.value == ""
                        ? null
                        : addHelpPostController.linkUrl.value,
                    onChange: (link) {
                      print(link);
                      addHelpPostController.linkUrl.value = link;
                      addHelpPostController.helpPostRequest.value.imageUrl =
                          link;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(1, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SahaTextFieldNoBorder(
                    enabled: true,
                    controller: addHelpPostController.contentController,
                    onChanged: (v) {
                      addHelpPostController.helpPostRequest.value.content = v;
                    },
                    textInputType: TextInputType.multiline,
                    //maxLine: 5,
                    labelText: "Nội dung bài đăng",
                    hintText: "Nhập nội dung",
                    validator: (value) {
                      if ((value ??'').isEmpty) {
                        return 'Không được để trống';
                      }
                      return null;
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
                text: 'Thêm  bài dăng hỗ trợ',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addHelpPostController.addHelpPost();
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
