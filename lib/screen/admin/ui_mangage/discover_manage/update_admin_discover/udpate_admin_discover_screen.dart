import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/admin_discover.dart';
import 'package:gohomy/screen/admin/ui_mangage/discover_manage/update_admin_discover/update_admin_discover_controller.dart';

import '../../../../../components/button/saha_button.dart';
import '../../../../../components/text_field/sahashopTextField.dart';
import '../../../../../const/type_image.dart';
import '../../../../profile/edit_profile/widget/select_avatar_image.dart';

class UpdateAdminDiscoverScreen extends StatefulWidget {
  UpdateAdminDiscoverScreen({Key? key, required this.adminDiscover})
      : super(key: key);
  AdminDiscover adminDiscover;
  @override
  State<UpdateAdminDiscoverScreen> createState() =>
      _UpdateAdminDiscoverScreenState();
}

class _UpdateAdminDiscoverScreenState extends State<UpdateAdminDiscoverScreen> {
  UpdateAdminDiscoverController updateAdminDiscoverController =
      UpdateAdminDiscoverController();
  @override
  void initState() {
    super.initState();
    updateAdminDiscoverController.adminDiscover.value = widget.adminDiscover;
    updateAdminDiscoverController.contentController.text =
        widget.adminDiscover.content ?? '';
    updateAdminDiscoverController.linkUrl.value =
        widget.adminDiscover.image ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chỉnh sửa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SahaTextField(
                labelText: 'Content',
                controller: updateAdminDiscoverController.contentController,
                hintText: 'Nhập content',
                onChanged: (v) {
                  updateAdminDiscoverController.adminDiscover.value.content = v;
                }),
            Obx(
              () => SelectAvatarImage(
                type: ANOTHER_FILES_FOLDER,
                linkLogo: updateAdminDiscoverController.linkUrl.value == ""
                    ? null
                    : updateAdminDiscoverController.linkUrl.value,
                onChange: (link) {
                  print(link);
                  updateAdminDiscoverController.linkUrl.value = link;
                  updateAdminDiscoverController.adminDiscover.value.image =
                      link;
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
              text: 'Cập nhật khám phá',
              onPressed: () {
                updateAdminDiscoverController.udpateDiscover(
                    id: widget.adminDiscover.id!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
