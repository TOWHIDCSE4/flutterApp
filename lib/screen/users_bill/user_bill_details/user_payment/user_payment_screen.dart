import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/deposit_withdraw_page.dart';
import 'package:gohomy/screen/profile/profile_details/profile_details_page.dart';
import 'package:gohomy/screen/users_bill/user_bill_details/user_payment/user_payment_controller.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/button/saha_button.dart';
import '../../../../components/widget/image/select_images.dart';
import '../../../../const/type_image.dart';
import '../../../../model/bill.dart';
import '../../../../model/image_assset.dart';
import '../../../../utils/string_utils.dart';

class UserPaymentScreen extends StatefulWidget {
  Bill bill;
  UserPaymentScreen({Key? key, required this.bill}) : super(key: key);

  @override
  State<UserPaymentScreen> createState() => _UserPaymentScreenState();
}

class _UserPaymentScreenState extends State<UserPaymentScreen> {
  UserPaymentController userPaymentController = UserPaymentController();
  DataAppController dataAppController = Get.find<DataAppController>();
  @override
  void initState() {
    super.initState();
    userPaymentController.bill.value = widget.bill;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              color: Theme.of(context).primaryColor,
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
                          if (dataAppController
                              .currentUser.value.cmndNumber ==
                              null) {
                            SahaDialogApp.showDialogBalance(
                                title: "Chưa kích hoạt ví",
                                mess:
                                'Ví Renren của bạn chưa được kích hoạt. Hãy kích hoạt ví rồi quay lại nha.',
                                actionText: 'Kích hoạt ví',
                                onOK: () {
                                  Get.to(() => const ProfileDetailsPage());
                                });
                            return;
                          }
                          if (dataAppController
                              .currentUser.value.goldenCoins! <
                              userPaymentController.bill.value.totalFinal!) {
                            SahaDialogApp.showDialogBalance(
                                title: "Số dư không đủ",
                                mess:
                                'Opps~ Hình như số dư trong ví của bạn không đủ rồi. Hãy nạp thêm vào ví để tiếp tục thanh toán nha.',
                                actionText: 'Nạp ví',
                                onOK: () {
                                  Get.to(() => DepositWithdrawPage(
                                    goldenCoins: dataAppController
                                        .currentUser.value.goldenCoins,
                                    silverCoins: dataAppController
                                        .currentUser.value.silverCoins,
                                  ));
                                });
                            return;
                          }
                          userPaymentController.bill.value.datePayment =
                              DateTime.now();
                          userPaymentController.bill.value.status = 1;
                          userPaymentController.bill.value.motelId =
                              widget.bill.motel!.id;
                          userPaymentController.putUserPayment(widget.bill.id);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(title: const Text('Thanh toán')),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.bill.id}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  if (widget.bill.datePayment != null)
                    Row(
                      children: [
                        Text(
                          DateFormat('dd-MM-yyyy').format(widget.bill.datePayment!),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        const Icon(Icons.calendar_month),
                      ],
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(CupertinoIcons.house),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(child: Text('${widget.bill.motel?.motelName}')),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Icon(CupertinoIcons.doc_plaintext),
                  const SizedBox(
                    width: 4,
                  ),
                  Text('Ghi chú : ${widget.bill.note ?? ""}'),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tiền phòng :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    '${SahaStringUtils().convertToMoney(widget.bill.totalMoneyMotel ?? "0")} đ',
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tiền dịch vụ :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    '${SahaStringUtils().convertToMoney(widget.bill.totalMoneyService ?? "0")} đ',
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Giảm giá :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    '${SahaStringUtils().convertToMoney(widget.bill.discount ?? "0")} đ',
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng cộng :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    '${SahaStringUtils().convertToMoney(widget.bill.totalFinal ?? "0")} đ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              const Divider(),
              // const SizedBox(
              //   height: 8,
              // ),
              // Obx(
              //   () => Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: SelectImages(
              //       type: BILL_FILES_FOLDER,
              //       maxImage: 10,
              //       title: 'Ảnh thanh toán',
              //       subTitle: 'Tối đa 10 hình',
              //       onUpload: () {},
              //       images: userPaymentController.listImages.toList(),
              //       doneUpload: (List<ImageData> listImages) {
              //         print(
              //             "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
              //         userPaymentController.listImages(listImages);
              //         if ((listImages.map((e) => e.linkImage ?? "x"))
              //             .toList()
              //             .contains('x')) {
              //           SahaAlert.showError(message: 'Lỗi ảnh');
              //           return;
              //         }
              //         userPaymentController.bill.value.images =
              //             (listImages.map((e) => e.linkImage ?? "")).toList();
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
