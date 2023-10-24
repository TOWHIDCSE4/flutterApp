import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/const/type_image.dart';
import 'package:gohomy/screen/admin/support/help_post/update_help_post.dart/update_help_post_controller.dart';

import '../../../../../components/button/saha_button.dart';
import '../../../../../components/dialog/dialog.dart';
import '../../../../../components/text_field/sahashopTextField.dart';
import '../../../../../components/text_field/text_field_no_border.dart';
import '../../../../../data/remote/response-request/admin_manage/all_help_post_res.dart';
import '../../../../profile/edit_profile/widget/select_avatar_image.dart';
import '../../choose_category/choose_category_screen.dart';

class UpdateHelpPostScreen extends StatefulWidget {
  UpdateHelpPostScreen({Key? key, required this.helpPostData})
      : super(key: key);
  HelpPostData helpPostData;
  @override
  State<UpdateHelpPostScreen> createState() => _UpdateHelpPostScreenState();
}

class _UpdateHelpPostScreenState extends State<UpdateHelpPostScreen> {
  UpdateHelpPostController updateHelpPostController =
      UpdateHelpPostController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    updateHelpPostController.getHelpPost(id: widget.helpPostData.id!);
    widget.helpPostData.categoryHelpPost != null
        ? updateHelpPostController.listCategorySelected.value = [
            widget.helpPostData.categoryHelpPost!
          ]
        : [];
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
          title: const Text('Sửa bài đăng hỗ trợ'),
          actions: [
            GestureDetector(
              onTap: () {
                SahaDialogApp.showDialogYesNo(
                    mess: "Bạn có chắc muốn xoá bài đăng này",
                    onClose: () {},
                    onOK: () async {
                      await updateHelpPostController.deleteHelpPost(
                          id: widget.helpPostData.id!);
                      Get.back();
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
          () => updateHelpPostController.loadInit.value
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
                          labelText: 'Tiêu đề bài đăng hỗ trợ',
                          hintText: ' Nhập tiêu đề bài đăng hỗ trợ',
                          controller: updateHelpPostController.titleController,
                          withAsterisk: true,
                          onChanged: (v) {
                            updateHelpPostController
                                .helpPostRequest.value.title = v;
                          },
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => ChooseCategoryScreen(
                                  onChoose: (v) {
                                    updateHelpPostController
                                        .categoryNameController
                                        .text = v.value[0].title;
                                    updateHelpPostController
                                        .helpPostRequest
                                        .value
                                        .categoryHelpPostId = v.value[0].id;
                                    updateHelpPostController
                                        .listCategorySelected
                                        .value = [v.value[0]];
                                  },
                                  listCategorySelected: updateHelpPostController
                                      .listCategorySelected,
                                ));
                          },
                          child: SahaTextFieldNoBorder(
                            onTap: () {
                              Get.to(() => ChooseCategoryScreen(
                                    onChoose: (v) {
                                      updateHelpPostController
                                          .categoryNameController
                                          .text = v.value[0].title;
                                      updateHelpPostController
                                          .helpPostRequest
                                          .value
                                          .categoryHelpPostId = v.value[0].id;
                                      updateHelpPostController
                                          .listCategorySelected
                                          .value = [v.value[0]];
                                    },
                                    listCategorySelected:
                                        updateHelpPostController
                                            .listCategorySelected,
                                  ));
                            },
                            readOnly: true,
                            validator: (value) {
                              if ((value ??'').isEmpty) {
                                return 'Không được để trống';
                              }
                              return null;
                            },
                            labelText: 'Danh mục bài đăng hỗ trợ',
                            hintText: 'Chọn danh mục bài đăng',
                            controller:
                                updateHelpPostController.categoryNameController,
                            withAsterisk: true,
                          ),
                        ),
                        SahaTextField(
                          validator: (value) {
                            if ((value ??'').isEmpty) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                          labelText: 'Tóm tắt bài đăng hỗ trợ',
                          hintText: 'Nhập tóm tắt bài đăng',
                          controller:
                              updateHelpPostController.summaryController,
                          withAsterisk: true,
                          onChanged: (v) {
                            updateHelpPostController
                                .helpPostRequest.value.summary = v;
                          },
                        ),
                        Obx(
                          () => SelectAvatarImage(
                            type: ANOTHER_FILES_FOLDER,
                            linkLogo:
                                updateHelpPostController.linkUrl.value == ""
                                    ? null
                                    : updateHelpPostController.linkUrl.value,
                            onChange: (link) {
                              print(link);
                              updateHelpPostController.linkUrl.value = link;
                              updateHelpPostController
                                  .helpPostRequest.value.imageUrl = link;
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
                                offset:
                                    const Offset(1, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: SahaTextFieldNoBorder(
                            enabled: true,
                            controller:
                                updateHelpPostController.contentController,
                            onChanged: (v) {
                              updateHelpPostController
                                  .helpPostRequest.value.content = v;
                            },
                            textInputType: TextInputType.multiline,
                            maxLine: 5,
                            labelText: "Nội dung",
                            hintText: "Nhập nội dung",
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
                text: 'Update bài dăng hỗ trợ',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateHelpPostController.updateHelpPost(
                        id: widget.helpPostData.id!);
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
