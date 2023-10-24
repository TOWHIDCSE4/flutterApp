import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/admin/ui_mangage/banner_manage/update_banner/update_banner_controller.dart';
import 'package:get/get.dart';
import '../../../../../components/button/saha_button.dart';
import '../../../../../components/dialog/dialog.dart';
import '../../../../../components/text_field/text_field_no_border.dart';
import '../../../../../const/type_image.dart';
import '../../../../profile/edit_profile/widget/select_avatar_image.dart';

class UpdateBannerScreen extends StatefulWidget {
  UpdateBannerScreen({Key? key, required this.id}) : super(key: key);
  int id;
  @override
  State<UpdateBannerScreen> createState() => _UpdateBannerScreenState();
}

class _UpdateBannerScreenState extends State<UpdateBannerScreen> {
  final _formKey = GlobalKey<FormState>();
  UpdateBannerController updateBannerController = UpdateBannerController();
  @override
  @override
  void initState() {
    super.initState();
    updateBannerController.getBanner(id: widget.id);
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
          title: const Text('Chỉnh sửa banner'),
          actions: [
            GestureDetector(
              onTap: () {
                SahaDialogApp.showDialogYesNo(
                    mess: "Bạn có chắc muốn xoá banner này",
                    onClose: () {},
                    onOK: () {
                      updateBannerController.deleteBanner(id: widget.id);
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
          () => updateBannerController.loadInit.value
              ? SahaLoadingFullScreen()
              : Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SahaTextFieldNoBorder(
                        withAsterisk: true,
                        controller: updateBannerController.titleController,
                        onChanged: (v) {
                          updateBannerController.banner.value.title = v;
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
                        controller: updateBannerController.actionLinkController,
                        onChanged: (v) {
                          updateBannerController.banner.value.actionLink = v;
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
                          linkLogo: updateBannerController.linkUrl.value == ""
                              ? null
                              : updateBannerController.linkUrl.value,
                          onChange: (link) {
                            print(link);
                            updateBannerController.linkUrl.value = link;
                            updateBannerController.banner.value.imageUrl = link;
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
                text: 'Cập nhật banner',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateBannerController.updateBanner(id: widget.id);
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
