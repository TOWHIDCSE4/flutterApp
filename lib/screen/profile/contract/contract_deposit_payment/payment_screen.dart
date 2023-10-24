import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/profile/contract/contract_deposit_payment/payment_successful_screen.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/deposit_withdraw_page.dart';
import 'package:gohomy/screen/profile/profile_details/profile_details_page.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/button/saha_button.dart';
import '../../../../components/widget/image/select_images.dart';
import '../../../../const/type_image.dart';
import '../../../../model/contract.dart';
import '../../../../model/image_assset.dart';
import 'contract_deposit_payment_controller.dart';

class ContractPaymentScreen extends StatelessWidget {
  late ContractDepositPaymentController contractDepositPaymentController;
  Contract contract;

  ContractPaymentScreen({required this.contract}) {
    contractDepositPaymentController =
        ContractDepositPaymentController(contractInput: contract);
  }

  @override
  Widget build(BuildContext context) {
    DataAppController dataAppController = Get.find<DataAppController>();
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
        title: const Text('Thanh toán tiền cọc'),
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 15,
                    right: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chủ nhà',
                        style: TextStyle(
                            color: Colors.black54,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              contract.host?.name ?? '',
                              style: const TextStyle(),
                            ),
                          ),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 15,
                    right: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Số tiền',
                        style: TextStyle(
                            color: Colors.black54,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${SahaStringUtils().convertToMoney(contract.money) ?? ''} VNĐ',
                              style: const TextStyle(),
                            ),
                          ),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 15,
                    right: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Số tiền phải thanh toán',
                        style: TextStyle(
                            color: Colors.black54,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${SahaStringUtils().convertToMoney(contract.money) ?? ''} VNĐ',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Obx(
          //       () => Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: SelectImages(
          //       type: CONTRACT_FILES_FOLDER,
          //       title: 'Ảnh thanh toán',
          //       maxImage: 10,
          //       subTitle: 'Tối đa 10 hình',
          //       onUpload: () {},
          //       images: contractDepositPaymentController.listImages.toList(),
          //       doneUpload: (List<ImageData> listImages) {
          //         print(
          //             "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
          //         contractDepositPaymentController.listImages(listImages);
          //         if ((listImages.map((e) => e.linkImage ?? "x"))
          //             .toList()
          //             .contains('x')) {
          //           SahaAlert.showError(message: 'Lỗi ảnh');
          //           return;
          //         }
          //         contractDepositPaymentController.images =
          //             (listImages.map((e) => e.linkImage ?? "")).toList();
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            Obx(
              () => SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                isLoading:
                    contractDepositPaymentController.isLoadingUpdate.value,
                text: 'Thanh toán',
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
                            Navigator.pop(context);

                            // if (dataAppController
                            //         .currentUser.value.cmndNumber ==
                            //     null) {
                            //   SahaDialogApp.showDialogBalance(
                            //       title: "Chưa kích hoạt ví",
                            //       mess:
                            //           'Ví Renren của bạn chưa được kích hoạt. Hãy kích hoạt ví rồi quay lại nha.',
                            //       actionText: 'Kích hoạt ví',
                            //       onOK: () {
                            //         Get.to(() => const ProfileDetailsPage());
                            //       });
                            //   return;
                            // }
                            // if (dataAppController
                            //         .currentUser.value.goldenCoins! <
                            //     contract.money!) {
                            //   SahaDialogApp.showDialogBalance(
                            //       title: "Số dư không đủ",
                            //       mess:
                            //           'Opps~ Hình như số dư trong ví của bạn không đủ rồi. Hãy nạp thêm vào ví để tiếp tục thanh toán nha.',
                            //       actionText: 'Nạp ví',
                            //       onOK: () {
                            //         Get.to(() => DepositWithdrawPage(
                            //               goldenCoins: dataAppController
                            //                   .currentUser.value.goldenCoins,
                            //               silverCoins: dataAppController
                            //                   .currentUser.value.silverCoins,
                            //             ));
                            //       });
                            //   return;
                            // }
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
