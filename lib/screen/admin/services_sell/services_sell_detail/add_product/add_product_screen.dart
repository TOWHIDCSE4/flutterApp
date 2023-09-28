import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/const/type_image.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../components/button/saha_button.dart';
import '../../../../../components/text_field/sahashopTextFieldColor.dart';
import '../../../../../components/widget/image/select_images.dart';
import '../../../../../model/image_assset.dart';
import '../../../../../utils/string_utils.dart';
import 'add_product_controller.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key,required this.categoryId,this.productId}) {
    controller = AddProductController(categoryId: categoryId,productId: productId);
  }
  late AddProductController controller;
  final int categoryId;
  final int? productId;
  
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: productId == null ? "Thêm sản phẩm" : "Sửa sản phẩm",
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              ()=>controller.loadInit.value ? SahaLoadingFullScreen(): Column(
                children: [
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectImages(
                        maxImage: 10,
                        type: ANOTHER_FILES_FOLDER,
                        title: 'Ảnh sản phẩm',
                        subTitle: 'Tối đa 10 hình',
                        onUpload: () {
                          controller.doneUploadImage.value = false;
                        },
                        images: controller.listImages.toList(),
                        doneUpload: (List<ImageData> listImages) {
                          print(
                              "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                          controller.listImages(listImages);
                          if ((listImages.map((e) => e.linkImage ?? "x"))
                              .toList()
                              .contains('x')) {
                            SahaAlert.showError(message: 'Lỗi ảnh');
                            return;
                          }
                          controller.serviceSellReq.value.images =
                              (listImages.map((e) => e.linkImage ?? "x")).toList();
                     
                          controller.doneUploadImage.value = true;
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: SahaTextFieldColor(
                          labelText: "Tên sản phẩm",
                          hintText: "Nhập tên sản phẩm",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                          maxLines: 1,
                          withAsterisk: true,
                          controller: controller.nameProduct,
                          onChanged: (v) {
                            controller.serviceSellReq.value.name = v!;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        flex: 2,
                        child: SahaTextFieldColor(
                          labelText: "Giá thành",
                          hintText: "Nhập giá",
                            textInputType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [ThousandsFormatter()],
                          suffix: Text(
                            "VNĐ",
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                          maxLines: 1,
                          withAsterisk: true,
                          controller: controller.priceProduct,
                          onChanged: (v) {
                             controller.serviceSellReq.value.price =
                                  double.tryParse(SahaStringUtils()
                                      .convertFormatText(v));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SahaTextFieldColor(
                    labelText: "Mô tả sản phẩm",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    hintText: "Nhập mô tả sản phẩm",
                    withAsterisk: true,
                    controller: controller.description,
                    onChanged: (v) {
                      controller.serviceSellReq.value.description =v!;
                    },
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
                color: controller.doneUploadImage.value
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                text:productId == null ? 'Thêm sản phẩm' : "Cập nhật",
                onPressed: () {
                  if (controller.doneUploadImage.value == true) {
                    if (_formKey.currentState!.validate()) {
                      if(productId == null){
                        controller.addServiceSell();
                      }else{
                        controller.updateServiceSell();
                      }
                      
                    }
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
