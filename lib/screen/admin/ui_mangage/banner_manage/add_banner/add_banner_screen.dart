import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gohomy/screen/admin/ui_mangage/banner_manage/add_banner/add_banner_controller.dart';

import '../../../../../components/button/saha_button.dart';
import '../../../../../components/text_field/text_field_no_border.dart';

import '../../../../../const/type_image.dart';
import '../../../../profile/edit_profile/widget/select_avatar_image.dart';

class AddBannerScreen extends StatefulWidget {
  const AddBannerScreen({Key? key}) : super(key: key);

  @override
  State<AddBannerScreen> createState() => _AddBannerScreenState();
}

class _AddBannerScreenState extends State<AddBannerScreen> {
  AddBannerController addBannerController = AddBannerController();
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
            title: const Text('Thêm banner')),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              SahaTextFieldNoBorder(
                withAsterisk: true,
                controller: addBannerController.titleController,
                onChanged: (v) {
                  addBannerController.banner.value.title = v;
                },
                validator: (value) {
                  if ((value ??'').isEmpty) {
                    return 'Không được để trống';
                  }
                  return null;
                },
                labelText: "Tên banner",
                hintText: "Nhập tên banner",
              ),
              SahaTextFieldNoBorder(
                withAsterisk: true,
                controller: addBannerController.actionLinkController,
                onChanged: (v) {
                  addBannerController.banner.value.actionLink = v;
                },
                validator: (value) {
                  if ((value ??'').isEmpty) {
                    return 'Không được để trống';
                  }
                  return null;
                },
                labelText: "Link banner",
                hintText: "Nhập link banner",
              ),
              Obx(
                () => SelectAvatarImage(
                  type: ANOTHER_FILES_FOLDER,
                  linkLogo: addBannerController.linkUrl.value == ""
                      ? null
                      : addBannerController.linkUrl.value,
                  onChange: (link) {
                    print(link);
                    addBannerController.linkUrl.value = link;
                    addBannerController.banner.value.imageUrl = link;
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                text: 'Thêm banner',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addBannerController.addBanner();
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
