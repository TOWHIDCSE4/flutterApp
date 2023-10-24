import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/button/saha_button.dart';
import '../../../../components/widget/image/select_images.dart';
import '../../../../const/type_image.dart';
import '../../../../model/contract.dart';
import '../../../../model/image_assset.dart';
import 'contract_deposit_payment_controller.dart';

class ContractDepositScreen extends StatelessWidget {
  late ContractDepositPaymentController contractDepositPaymentController;
  Contract contract;
  ContractDepositScreen({required this.contract}) {
    contractDepositPaymentController =
        ContractDepositPaymentController(contractInput: contract);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('Xác nhận tiền đặt cọc'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tên ngân hàng: "),
                    Text(contract.host?.bankName ?? 'Chưa có thông tin')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Số tài khoản: "),
                    Text(
                        contract.host?.bankAccountNumber ?? 'Chưa có thông tin')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tên người thụ hưởng: "),
                    Text(contract.host?.bankAccountName ?? 'Chưa có thông tin')
                  ],
                ),
              ],
            ),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectImages(
                type: CONTRACT_FILES_FOLDER,
                title: 'Ảnh thanh toán',
                maxImage: 10,
                subTitle: 'Tối đa 10 hình',
                onUpload: () {},
                images: contractDepositPaymentController.listImages.toList(),
                doneUpload: (List<ImageData> listImages) {
                  print(
                      "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                  contractDepositPaymentController.listImages(listImages);
                  if ((listImages.map((e) => e.linkImage ?? "x"))
                      .toList()
                      .contains('x')) {
                    SahaAlert.showError(message: 'Lỗi ảnh');
                    return;
                  }
                  contractDepositPaymentController.images =
                      (listImages.map((e) => e.linkImage ?? "")).toList();
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            Obx(
              ()=> SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                isLoading: contractDepositPaymentController.isLoadingUpdate.value,
                text: 'Xác nhận thanh toán',
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Xác nhận thanh toán'),
                      content: const Text('Bạn có chắc chắn muốn thanh toán ?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            contractDepositPaymentController.confirmContract(
                                id: contract.id!);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
