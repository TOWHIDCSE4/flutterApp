import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:gohomy/components/text_field/sahashopTextField.dart';
import 'package:gohomy/screen/admin/ui_mangage/discover_manage/discover_item/update_discover_item/update_discover_item_controller.dart';

import '../../../../../../components/button/saha_button.dart';
import '../../../../../../components/dialog/dialog.dart';
import '../../../../../../const/type_image.dart';
import '../../../../../profile/edit_profile/widget/select_avatar_image.dart';

class UpdateDiscoverItemScreen extends StatefulWidget {
  UpdateDiscoverItemScreen({Key? key, this.id}) : super(key: key);
  int? id;
  @override
  State<UpdateDiscoverItemScreen> createState() =>
      _UpdateDiscoverItemScreenState();
}

class _UpdateDiscoverItemScreenState extends State<UpdateDiscoverItemScreen> {
  UpdateDiscoverItemController updateDiscoverItemController =
      UpdateDiscoverItemController();

  @override
  void initState() {
    super.initState();
    updateDiscoverItemController.getDiscoverItem(id: widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              updateDiscoverItemController.discoverItem.value.districtName ??
                  ''),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              SahaDialogApp.showDialogYesNo(
                  mess: "Bạn có chắc muốn xoá chi tiet khám phá này",
                  onClose: () {},
                  onOK: () {
                    updateDiscoverItemController.deleteDiscoverItem(
                        id: widget.id!);
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SahaTextField(
                labelText: 'Content',
                controller: updateDiscoverItemController.contentController,
                hintText: 'Nhập content',
                onChanged: (v) {
                  updateDiscoverItemController.discoverItem.value.content = v;
                }),
            Obx(
              () => SelectAvatarImage(
                type: ANOTHER_FILES_FOLDER,
                linkLogo: updateDiscoverItemController.linkUrl.value == ""
                    ? null
                    : updateDiscoverItemController.linkUrl.value,
                onChange: (link) {
                  print(link);
                  updateDiscoverItemController.linkUrl.value = link;
                  updateDiscoverItemController.discoverItem.value.image = link;
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
              text: 'Cập nhật chi tiết khám phá',
              onPressed: () {
                updateDiscoverItemController.updateDiscoverItem(id: widget.id!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
