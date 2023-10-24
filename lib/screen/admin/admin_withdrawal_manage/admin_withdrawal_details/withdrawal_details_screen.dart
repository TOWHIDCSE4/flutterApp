import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/admin/admin_withdrawal_manage/admin_withdrawal_details/withdrawal_details_controller.dart';
import 'package:intl/intl.dart';

import '../../../../components/dialog/dialog.dart';
import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../utils/string_utils.dart';

class WithdrawalDetailsScreen extends StatelessWidget {
  WithdrawalDetailsScreen({super.key, required this.id}) {
    withdrawalDetailsController = WithdrawalDetailsController(id: id);
  }
  int id;
  late WithdrawalDetailsController withdrawalDetailsController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SahaAppBar(
          titleText: 'Chi tiết yêu cầu rút tiền',
          actions: [
            GestureDetector(
              onTap: () {
                SahaDialogApp.showDialogYesNo(
                    mess: "Bạn có chắc muốn xoá ",
                    onClose: () {
                      Get.back();
                    },
                    onOK: () {
                      withdrawalDetailsController.deleteWithdrawal();
                    });
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                child: const Icon(
                  FontAwesomeIcons.trashCan,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => withdrawalDetailsController.loadInit.value
                ? SahaLoadingFullScreen()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.orange, Colors.deepOrange],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: CachedNetworkImage(
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                    imageUrl: withdrawalDetailsController
                                            .withdrawal
                                            .value
                                            .user
                                            ?.avatarImage ??
                                        '',
                                    // placeholder: (context, url) =>
                                    //     SahaLoadingWidget(),
                                    errorWidget: (context, url, error) =>
                                        const SahaEmptyAvata(
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          withdrawalDetailsController.withdrawal
                                                  .value.user?.name ??
                                              'Chưa có tên',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      withdrawalDetailsController.withdrawal
                                              .value.user?.phoneNumber ??
                                          '',
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Số tiền yêu cầu thanh toán :'),
                            Text(
                                '${SahaStringUtils().convertToMoney(withdrawalDetailsController.withdrawal.value.amountMoney ?? '0')} đ'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Số tài khoản ngân hàng:'),
                            Text(withdrawalDetailsController
                                    .withdrawal.value.user?.bankAccountNumber ??
                                'Chưa có thông tin'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Tên ngân hàng :'),
                            Text(withdrawalDetailsController
                                    .withdrawal.value.user?.bankName ??
                                'Chưa có thông tin'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Tên chủ tài khoản :'),
                            Text(withdrawalDetailsController
                                    .withdrawal.value.user?.bankAccountName ??
                                'Chưa có thông tin'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Ngày yêu cầu :'),
                            Text(DateFormat('dd-MM-yyyy').format(
                                withdrawalDetailsController
                                    .withdrawal.value.createdAt!)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (withdrawalDetailsController
                                .withdrawal.value.dateWithdrawalApproved !=
                            null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Ngày xác nhận :'),
                              Text(DateFormat('dd-MM-yyyy').format(
                                  withdrawalDetailsController.withdrawal.value
                                      .dateWithdrawalApproved!)),
                            ],
                          ),
                      ],
                    ),
                  ),
          ),
        ),
        bottomNavigationBar:
            Obx(() => withdrawalDetailsController.withdrawal.value.status == 0
                ? SizedBox(
                    height: 65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            withdrawalDetailsController.verifyWithdrawal(
                                status: 2);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.deepOrange),
                            child: const Center(
                              child: Text('Xác nhận đã thanh toán',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            withdrawalDetailsController.verifyWithdrawal(
                                status: 1);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.deepOrange),
                            child: const Center(
                              child: Text(
                                'Huỷ yêu cầu thanh toán',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                        // SahaButtonFullParent(
                        //   color: Theme.of(context).primaryColor,
                        //   text: 'Xác nhận đã thanh toán',
                        //   onPressed: () {
                        //     withdrawalDetailsController.verifyWithdrawal(
                        //         status: 2);
                        //   },
                        // ),
                        // SahaButtonFullParent(
                        //   color: Theme.of(context).primaryColor,
                        //   text: 'Huỷ yêu cầu thanh toán',
                        //   onPressed: () {
                        //     withdrawalDetailsController.verifyWithdrawal(
                        //         status: 1);
                        //   },
                        // ),
                      ],
                    ),
                  )
                : const SizedBox()));
  }
}
