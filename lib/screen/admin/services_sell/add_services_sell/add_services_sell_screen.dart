import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/divide/divide.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/components/text_field/sahashopTextField.dart';
import 'package:gohomy/components/text_field/sahashopTextFieldColor.dart';
import 'package:gohomy/const/type_image.dart';
import 'package:gohomy/screen/admin/services_sell/add_services_sell/add_services_sell_controller.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../components/widget/image_picker_single/image_picker_single.dart';

class AddServicesSellScreen extends StatelessWidget {
  AddServicesSellScreen({super.key,this.categoryId}) {
    controller = AddServicesSellController(categoryId: categoryId);
  }
  late AddServicesSellController controller;
  final int? categoryId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: categoryId == null ? "Thêm dịch vụ bán" : "Cập nhật dịch vụ",
        ),
        body: Obx(
          () => controller.loadInit.value
              ? SahaLoadingFullScreen()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SahaTextFieldColor(
                        withAsterisk: true,
                        labelText: "Tên dịch vụ bán",
                        hintText: "Nhập tên dịch vụ bán",
                        controller: controller.nameService,
                        onChanged: (v){
                          controller.categoryReq.value.name = v!;
                        },
                      ),
                      const Text(
                        'Icon dịch vụ:',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Obx(
                        () => ImagePickerSingle(
                          type: ANOTHER_FILES_FOLDER,
                          width: Get.width / 3,
                          height: Get.width / 4,
                          linkLogo: controller.categoryReq.value.image,
                          onChange: (link) {
                            controller.categoryReq.value.image = link;
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
                  text:categoryId == null ? 'Thêm danh mục' : "Cập nhật danh mục",
                  onPressed: () {
                    if(categoryId == null){
                      controller.addCategory();
                    }else{
                      controller.updateAdminCategory();
                    }
                    
                  },
                  color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
