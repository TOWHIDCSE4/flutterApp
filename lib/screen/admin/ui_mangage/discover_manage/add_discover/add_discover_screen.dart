import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/screen/admin/ui_mangage/discover_manage/add_discover/add_discover_controller.dart';

import '../../../../../components/button/saha_button.dart';
import '../../../../../const/type_image.dart';
import '../../../../profile/edit_profile/widget/select_avatar_image.dart';

class AddDiscoverScreen extends StatefulWidget {
  const AddDiscoverScreen({Key? key}) : super(key: key);

  @override
  State<AddDiscoverScreen> createState() => _AddDiscoverScreenState();
}

class _AddDiscoverScreenState extends State<AddDiscoverScreen> {
  AddDiscoverController addDiscoverController = AddDiscoverController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm khám phá')),
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
                Obx(
                  () => InkWell(
                    onTap: () {
                      SahaDialogApp.showDialogAddressChoose(
                          hideAll: true,
                          callback: (v) {
                            if (v.id != null) {
                              addDiscoverController
                                  .adminDiscover.value.province = v.id;
                              addDiscoverController.name.value = v.name;
                              Get.back();
                            }
                          },
                          accept: () {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(addDiscoverController.name.value == ''
                                ? 'chọn địa điểm'
                                : addDiscoverController.name.value),
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
                linkLogo: addDiscoverController.linkUrl.value == ""
                    ? null
                    : addDiscoverController.linkUrl.value,
                onChange: (link) {
                  print(link);
                  addDiscoverController.linkUrl.value = link;
                  addDiscoverController.adminDiscover.value.image = link;
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
              text: 'Thêm khám phá',
              onPressed: () {
                addDiscoverController.addDiscover();
              },
            ),
          ],
        ),
      ),
    );
  }
}
