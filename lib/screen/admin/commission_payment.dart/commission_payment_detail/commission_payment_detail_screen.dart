import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../components/appbar/saha_appbar.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../utils/string_utils.dart';
import 'commission_payment_detail_controller.dart';

class CommissionPaymentDetailScreen extends StatelessWidget {
  CommissionPaymentDetailScreen({super.key, required this.id}) {
    commissionPaymentDetailController =
        CommissionPaymentDetailController(id: id);
  }

  int id;

  late CommissionPaymentDetailController commissionPaymentDetailController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SahaAppBar(
          titleText: 'Chi tiết hoa hồng CTV',
        ),
        body: Obx(
          () => commissionPaymentDetailController.loadInit.value
              ? SahaLoadingFullScreen()
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Tên người giới thiệu :',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              commissionPaymentDetailController
                                      .commissionManage.value.user?.name ??
                                  '',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Tên người được giới thiệu :',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              commissionPaymentDetailController.commissionManage
                                      .value.userReferral?.name ??
                                  '',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Số tiền thanh toán mỗi CTV :',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '${SahaStringUtils().convertToMoney(commissionPaymentDetailController.commissionManage.value.moneyCommissionUser ?? "0")} đ ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Tổng cần thanh toán cho CTV :',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              '${SahaStringUtils().convertToMoney((commissionPaymentDetailController.commissionManage.value.moneyCommissionUser ?? 0) * 2)} đ ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Từ bài đăng',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                commissionPaymentDetailController
                                        .commissionManage.value.moPost?.title ??
                                    '',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Ngày tạo :',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy').format(
                                  commissionPaymentDetailController
                                      .commissionManage.value.createdAt!),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: Obx(
          () => commissionPaymentDetailController
                      .commissionManage.value.statusCommissionCollaborator !=
                  0
              ? const SizedBox()
              : Container(
                  margin: const EdgeInsets.all(10),
                  height: 65,
                  child: InkWell(
                    onTap: () {
                      commissionPaymentDetailController.confirmCommissionUser(
                          status: 2);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.deepOrange),
                      child: const Center(
                        child: Text('Xác nhận duyệt trả hoa hồng',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
        ));
  }
}
