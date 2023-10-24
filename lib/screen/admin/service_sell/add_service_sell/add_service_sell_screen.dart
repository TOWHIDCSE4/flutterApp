import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/text_field/sahashopTextField.dart';
import 'package:gohomy/screen/admin/service_sell/add_service_sell/add_service_sell_controller.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/button/saha_button.dart';
import '../../../../components/widget/image/select_images.dart';
import '../../../../components/widget/image_picker_single/image_picker_single.dart';
import '../../../../const/type_image.dart';
import '../../../../model/image_assset.dart';

class AddServiceSellScreen extends StatefulWidget {
  const AddServiceSellScreen({Key? key}) : super(key: key);

  @override
  State<AddServiceSellScreen> createState() => _AddServiceSellScreenState();
}

class _AddServiceSellScreenState extends State<AddServiceSellScreen> {
  AddServiceSellController addServiceSellController =
      AddServiceSellController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
            title: const Text('Thêm dịch vụ bán')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SahaTextField(
                    withAsterisk: true,
                    labelText: "Tên dịch vụ bán",
                    hintText: "Nhâp tên dịch vụ bán",
                    validator: ((value) {
                      if (value == '') {
                        return 'Không được để trống';
                      }

                      return null;
                    }),
                    controller: addServiceSellController.nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SahaTextField(
                    withAsterisk: true,
                    labelText: "Giá dịch vụ bán",
                    hintText: "Nhập giá dịch vụ bán",
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    validator: ((value) {
                      if (value == '') {
                        return 'Không được để trống';
                      }

                      return null;
                    }),
                    controller: addServiceSellController.priceController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SahaTextField(
                    withAsterisk: true,
                    labelText: "Mô tả dịch vụ bán",
                    hintText: "Mô tả dịch vụ bán",
                    textInputType: TextInputType.multiline,
                    controller: addServiceSellController.desController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectImages(
                        type: ANOTHER_FILES_FOLDER,
                        title: 'Ảnh dịch vụ',maxImage: 10,
                        subTitle: 'Tối đa 10 hình',
                        onUpload: () {},
                        images: addServiceSellController.listImages.toList(),
                        doneUpload: (List<ImageData> listImages) {
                          print(
                              "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                          addServiceSellController.listImages(listImages);
                          if ((listImages.map((e) => e.linkImage ?? "x"))
                              .toList()
                              .contains('x')) {
                            SahaAlert.showError(message: 'Lỗi ảnh');
                            return;
                          }
                          addServiceSellController.serviceSell.value.images =
                              (listImages.map((e) => e.linkImage ?? ""))
                                  .toList();
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'Icon dịch vụ:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Obx(
                    () => ImagePickerSingle(
                      type: RENTER_FILES_FOLDER,
                      width: Get.width / 3,
                      height: Get.width / 4,
                      linkLogo: addServiceSellController
                          .serviceSell.value.serviceSellIcon,
                      onChange: (link) {
                        print(link);
                        addServiceSellController
                            .serviceSell.value.serviceSellIcon = link;
                      },
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
                text: 'Thêm dịch vụ',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addServiceSellController.serviceSell.value.name =
                        addServiceSellController.nameController.text;
                    addServiceSellController.serviceSell.value.price =
                        double.parse(
                            addServiceSellController.priceController.text);
                    addServiceSellController.serviceSell.value.description =
                        addServiceSellController.desController.text;
                    addServiceSellController.addServiceSell();
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
