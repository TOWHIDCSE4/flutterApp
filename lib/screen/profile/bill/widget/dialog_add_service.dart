import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class DialogAddService {
  static void showDialogServiceInput({
    String? nameService,
    double? price,
    int? quantity,
    required Function onDone,
  }) {
    TextEditingController nameEditingController =
        TextEditingController(text: nameService);

    TextEditingController priceEdit = TextEditingController(
        text: price == null ? "" : SahaStringUtils().convertToUnit(price));
    TextEditingController quantityEdit =
        TextEditingController(text: "${quantity ?? ""}");
    Get.dialog(
      AlertDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(
                    child: Text(
                  "Thêm dịch vụ",
                  textAlign: TextAlign.center,
                )),
              ],
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: nameEditingController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                style: const TextStyle(fontSize: 14),
                maxLines: 5,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  hintText: "Tên dịch vụ",
                  contentPadding: EdgeInsets.only(left: 5),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: priceEdit,
                keyboardType: TextInputType.number,
                inputFormatters: [ThousandsFormatter()],
                textInputAction: TextInputAction.done,
                style: const TextStyle(fontSize: 14),
                maxLines: 5,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  hintText: "Giá địch vụ",
                  contentPadding: EdgeInsets.only(left: 5),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: quantityEdit,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                style: const TextStyle(fontSize: 14),
                maxLines: 5,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  hintText: "Số lượng",
                  contentPadding: EdgeInsets.only(left: 5),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (nameEditingController.text != "" &&
                        (double.tryParse(SahaStringUtils()
                                    .convertFormatText(priceEdit.text)) ??
                                0.0) !=
                            0 &&
                        (int.tryParse(quantityEdit.text) ?? 0) != 0) {
                      onDone(
                          nameEditingController.text,
                          double.tryParse(SahaStringUtils()
                                  .convertFormatText(priceEdit.text)) ??
                              0.0,
                          int.tryParse(quantityEdit.text) ?? 0);
                    } else {
                      SahaAlert.showError(message: "Dịch vụ thêm không hợp lệ");
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        color: Theme.of(Get.context!).primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      'Xác nhận',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }

  static void showDialogFurnitureInput({
    String? nameService,
    int? quantity,
    bool? isFix,
    required Function onDone,
  }) {
    TextEditingController nameEditingController =
        TextEditingController(text: nameService);

    TextEditingController quantityEdit =
        TextEditingController(text: "${quantity ?? ""}");
    Get.dialog(
      AlertDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  isFix == null ? "Thêm nội thất" : 'Sửa nội thất',
                  textAlign: TextAlign.center,
                )),
              ],
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: nameEditingController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                style: const TextStyle(fontSize: 14),
                maxLines: 5,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  hintText: "Tên nội thât",
                  contentPadding: EdgeInsets.only(left: 5),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: quantityEdit,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                style: const TextStyle(fontSize: 14),
                maxLines: 5,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  hintText: "Số lượng",
                  contentPadding: EdgeInsets.only(left: 5),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    if (nameEditingController.text == '') {
                      SahaAlert.showError(message: 'Chưa nhập tên');
                      return;
                    }
                    if (quantityEdit.text == '') {
                      SahaAlert.showError(message: 'Chưa nhập số lượng');
                      return;
                    }
                    onDone(
                      nameEditingController.text,
                      quantityEdit.text,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        color: Theme.of(Get.context!).primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      'Xác nhận',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        color: Theme.of(Get.context!).primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      'Huỷ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }
}
