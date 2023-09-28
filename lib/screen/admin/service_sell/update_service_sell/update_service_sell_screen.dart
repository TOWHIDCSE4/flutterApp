import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/text_field/text_field_no_border.dart';
import 'package:gohomy/screen/admin/service_sell/update_service_sell/update_service_sell_controller.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/button/saha_button.dart';
import '../../../../components/text_field/sahashopTextField.dart';
import '../../../../components/widget/image/select_images.dart';
import '../../../../components/widget/image_picker_single/image_picker_single.dart';
import '../../../../const/type_image.dart';
import '../../../../model/image_assset.dart';
import '../../../../model/service_sell.dart';

class UpdateServiceSellScreen extends StatefulWidget {
  UpdateServiceSellScreen({Key? key, required this.serviceSell})
      : super(key: key);
  ServiceSell serviceSell;

  @override
  State<UpdateServiceSellScreen> createState() =>
      _UpdateServiceSellScreenState();
}

class _UpdateServiceSellScreenState extends State<UpdateServiceSellScreen> {
  UpdateServiceSellController updateServiceSellController =
      UpdateServiceSellController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    updateServiceSellController.serviceSell.value = widget.serviceSell;
    nameController.text = widget.serviceSell.name!;
    priceController.text = widget.serviceSell.price.toString();
    updateServiceSellController.listImages((widget.serviceSell.images ?? [])
        .map((e) => ImageData(linkImage: e))
        .toList());
    updateServiceSellController.serviceSell.value.serviceSellIcon =
        widget.serviceSell.serviceSellIcon;
    updateServiceSellController.description.text =
        widget.serviceSell.description ?? '';
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
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Color(0xFFEF4355),
                    Color(0xFFFF964E),
                  ]),
            ),
          ),
          title: const Text('Sửa dịch vụ bán'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SahaTextFieldNoBorder(
                    labelText: 'Tên dịch vụ bán',
                    controller: nameController,
                    withAsterisk: true,
                    onChanged: (v) {
                      updateServiceSellController.serviceSell.value.name = v;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    hintText: "Nhập tên dich vu",
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SahaTextFieldNoBorder(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    labelText: 'Gia dịch vụ bán',
                    controller: priceController,
                    withAsterisk: true,
                    onChanged: (v) {
                      updateServiceSellController.serviceSell.value.price =
                          double.tryParse(v!) ?? 0;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    hintText: "Nhập tên dich vu",
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SahaTextField(
                    withAsterisk: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Mô tả dịch vụ bán",
                    hintText: "Mô tả dịch vụ bán",
                    textInputType: TextInputType.multiline,
                    controller: updateServiceSellController.description,
                    onChanged: (v) {
                      updateServiceSellController
                          .serviceSell.value.description = v;
                    },
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectImages(
                        type: ANOTHER_FILES_FOLDER,
                        title: 'Ảnh phòng trọ',
                        subTitle: 'Tối đa 10 hình',
                        maxImage: 10,
                        onUpload: () {},
                        images: updateServiceSellController.listImages.toList(),
                        doneUpload: (List<ImageData> listImages) {
                          print(
                              "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");

                          updateServiceSellController.listImages(listImages);
                          if ((listImages.map((e) => e.linkImage ?? "x"))
                              .toList()
                              .contains('x')) {
                            SahaAlert.showError(message: 'Lỗi ảnh');
                            return;
                          }
                          updateServiceSellController.serviceSell.value.images =
                              (listImages.map((e) => e.linkImage ?? ""))
                                  .toList();
                          print(updateServiceSellController
                              .serviceSell.value.images);
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 8),
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
                      linkLogo: updateServiceSellController
                          .serviceSell.value.serviceSellIcon,
                      onChange: (link) {
                        print(link);
                        updateServiceSellController
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
                text: 'Xác nhận',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateServiceSellController.updateServiceSell(
                        id: widget.serviceSell.id!,
                        serviceSell:
                            updateServiceSellController.serviceSell.value);
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
