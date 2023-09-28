import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../components/widget/image_picker_single/image_picker_single.dart';
import '../../../../const/type_image.dart';
import 'intro_manage_controller.dart';

class IntroManageScreen extends StatelessWidget {
  IntroManageScreen({super.key});

  final IntroManageController controller = IntroManageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Cài đặt intro",
      ),
      body: Obx(
        () => controller.loadInit.value
            ? SahaLoadingFullScreen()
            : Column(
                children: [
                  Column(
                    children: [
                      const Text('Ảnh intro'),
                      Obx(
                        () => ImagePickerSingle(
                          type: RENTER_FILES_FOLDER,
                          width: Get.width / 2,
                          height: Get.height/2,
                          linkLogo: controller.adminConfig.value.introApp,
                          onChange: (link) {
                            print(link);
                            controller.adminConfig.value.introApp = link;
                          },
                        ),
                      ),
                    ],
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
              text: 'Cập nhật',
              onPressed: () {
                controller.addConfig();
              },
            ),
          ],
        ),
      ),
    );
  }
}
