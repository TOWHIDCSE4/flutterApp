import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/ui_mangage/discover_manage/discover_item/add_discover_item/add_discover_item_controller.dart';

import '../../../../../../components/button/saha_button.dart';
import '../../../../../../components/dialog/dialog.dart';
import '../../../../../../const/type_image.dart';
import '../../../../../../model/admin_discover.dart';
import '../../../../../profile/edit_profile/widget/select_avatar_image.dart';

class AddDiscoverItemScreen extends StatefulWidget {
  AddDiscoverItemScreen({Key? key, this.adminDiscover}) : super(key: key);
  AdminDiscover? adminDiscover;
  @override
  State<AddDiscoverItemScreen> createState() => _AddDiscoverItemScreenState();
}

class _AddDiscoverItemScreenState extends State<AddDiscoverItemScreen> {
  AddDiscoverItemController addDiscoverItemController =
      AddDiscoverItemController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm chi tiết khám phá'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Chọn địa điểm",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    SahaDialogApp.showDialogAddressChoose(
                        hideAll: true,
                        idProvince: widget.adminDiscover?.province,
                        callback: (v) {
                          if (v.id != null) {
                            addDiscoverItemController
                                .adminDiscoverItem.value.district = v.id;
                            addDiscoverItemController.name.value = v.name;
                            Get.back();
                          }
                        },
                        accept: () {});
                  },
                  child: Obx(
                    () => Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                                addDiscoverItemController.name.value == ''
                                    ? 'chọn địa điểm'
                                    : addDiscoverItemController.name.value),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => SelectAvatarImage(
                type: ANOTHER_FILES_FOLDER,
                linkLogo: addDiscoverItemController.linkUrl.value == ""
                    ? null
                    : addDiscoverItemController.linkUrl.value,
                onChange: (link) {
                  print(link);
                  addDiscoverItemController.linkUrl.value = link;
                  addDiscoverItemController.adminDiscoverItem.value.image =
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
              text: 'Thêm chi tiết khám phá',
              onPressed: () {
                addDiscoverItemController.adminDiscoverItem.value
                    .adminDiscoverId = widget.adminDiscover?.id;
                addDiscoverItemController.addDiscoverItem();
              },
            ),
          ],
        ),
      ),
    );
  }
}
