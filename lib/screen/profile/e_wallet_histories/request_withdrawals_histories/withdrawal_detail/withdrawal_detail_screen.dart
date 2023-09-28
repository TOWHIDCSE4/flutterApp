import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../components/appbar/saha_appbar.dart';
import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../components/button/saha_button.dart';
import '../../../../../components/dialog/dialog.dart';
import '../../../../../components/empty/saha_empty_avatar.dart';
import '../../../../../components/loading/loading_full_screen.dart';
import '../../../../../components/loading/loading_widget.dart';
import '../../../../../utils/string_utils.dart';
import 'withdrawal_detail_controller.dart';

class UserWithdrawalDetailScreen extends StatelessWidget {
  UserWithdrawalDetailScreen({super.key, required this.id}) {
    userWithdrawalDetailController = UserWithdrawalDetailController(id: id);
  }
  int id;
  late UserWithdrawalDetailController userWithdrawalDetailController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SahaAppBar(
          titleText: 'Chi tiết yêu cầu rút tiền',
          // actions: [
          //   GestureDetector(
          //     onTap: () {
          //       SahaDialogApp.showDialogYesNo(
          //           mess: "Bạn có chắc muốn xoá phòng trọ",
          //           onClose: () {
          //             Get.back();
          //           },
          //           onOK: () {});
          //     },
          //     child: Container(
          //       margin: EdgeInsets.all(10),
          //       child: Icon(
          //         FontAwesomeIcons.trashCan,
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => userWithdrawalDetailController.loadInit.value
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
                                    imageUrl: userWithdrawalDetailController
                                            .withdrawal
                                            .value
                                            .user
                                            ?.avatarImage ??
                                        '',
                                    placeholder: (context, url) =>
                                        SahaLoadingWidget(),
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
                                          userWithdrawalDetailController
                                                  .withdrawal
                                                  .value
                                                  .user
                                                  ?.name ??
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
                                      userWithdrawalDetailController.withdrawal
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
                                '${SahaStringUtils().convertToMoney(userWithdrawalDetailController.withdrawal.value.amountMoney ?? '0')} đ'),
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
                                userWithdrawalDetailController
                                    .withdrawal.value.createdAt!)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (userWithdrawalDetailController
                                .withdrawal.value.dateWithdrawalApproved !=
                            null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Ngày xác nhận :'),
                              Text(DateFormat('dd-MM-yyyy').format(
                                  userWithdrawalDetailController.withdrawal
                                      .value.dateWithdrawalApproved!)),
                            ],
                          ),
                      ],
                    ),
                  ),
          ),
        ),
        bottomNavigationBar: Obx(
            () => userWithdrawalDetailController.withdrawal.value.status == 0
                ? SizedBox(
                    height: 65,
                    child: Row(
                      children: [
                        SahaButtonFullParent(
                          color: Theme.of(context).primaryColor,
                          text: 'Sửa số tiền muốn rút',
                          onPressed: () {
                            SahaDialogApp.showDialogInput(
                              textInput: userWithdrawalDetailController
                                  .withdrawal.value.amountMoney
                                  .toString(),
                              isNumber: true,
                              onInput: (v) {
                                if (v == '') {
                                  SahaAlert.showError(
                                      message: 'Vui lòng nhập số tiền');
                                  return;
                                }
                                userWithdrawalDetailController
                                        .withdrawal.value.amountMoney =
                                    double.parse(
                                        SahaStringUtils().convertFormatText(v));
                                userWithdrawalDetailController.updateWithdrawal(
                                    id: id);
                              },
                              title: 'Nhập số tiền muốn rút',
                            );
                          },
                        ),
                        SahaButtonFullParent(
                          color: Theme.of(context).primaryColor,
                          text: 'Huỷ yêu cầu rút tiền',
                          onPressed: () {
                            userWithdrawalDetailController.updateWithdrawal(
                                id: id, status: 1);
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox()));
  }
}
