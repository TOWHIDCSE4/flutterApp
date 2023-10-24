import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:intl/intl.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../components/widget/image/show_image.dart';
import '../../../../model/service.dart';
import '../../../../utils/string_utils.dart';
import '../add_bill/add_bill_screen.dart';
import 'bill_details_controller.dart';

class BillDetails extends StatelessWidget {
  int billId;
  BillDetails({Key? key, required this.billId}) : super(key: key) {
    billDetailsController = BillDetailsController(billId: billId);
  }

  late BillDetailsController billDetailsController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // begin: Alignment.bottomLeft,
                  // end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
          title: const Text('Chi tiết hóa đơn'),
          actions: [
            Obx(() => billDetailsController.bill.value.status == 0 ||
                    billDetailsController.bill.value.status == 2
                ? IconButton(
                    onPressed: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: 'Bạn có chắc chắn muốn xoá hoá đơn này chứ ?',
                          onOK: () {
                            billDetailsController.deleteBill(
                                billDetailsController.bill.value.id!);
                          });
                    },
                    icon: const Icon(Icons.delete))
                : Container())
          ]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Obx(
          () => billDetailsController.loadInit.value
              ? SahaLoadingFullScreen()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mã hoá đơn: ${billDetailsController.bill.value.id}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Hóa đơn tháng : ${billDetailsController.bill.value.content ?? ""}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      if (billDetailsController.bill.value.datePayment != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat('dd-MM-yyyy').format(
                                  billDetailsController
                                      .bill.value.datePayment!),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.calendar_month,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      if(billDetailsController.bill.value.motel?.towerId != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(CupertinoIcons.building_2_fill),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(billDetailsController
                                        .bill.value.motel?.towerName ??
                                    ""),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(CupertinoIcons.house),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(billDetailsController
                                    .bill.value.motel?.motelName ??
                                ""),
                          ),
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
                          Text(
                              'Ghi chú: ${billDetailsController.bill.value.note == null ? '...' : billDetailsController.bill.value.note!}'),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            '${SahaStringUtils().convertToMoney(billDetailsController.bill.value.totalMoneyMotel ?? "0")} đ',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            '${SahaStringUtils().convertToMoney(billDetailsController.bill.value.totalMoneyService ?? "0")} đ',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            '${SahaStringUtils().convertToMoney(billDetailsController.bill.value.discount ?? "0")} đ',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
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
                            'Đã dùng tiền cọc thanh toán :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            '- ${SahaStringUtils().convertToMoney(billDetailsController.bill.value.totalMoneyHasPaidByDeposit ?? "0")} đ',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
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
                            'Tổng thanh toán :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            '${SahaStringUtils().convertToMoney(billDetailsController.bill.value.totalFinal ?? "0")} đ',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor),
                        child: const Center(
                            child: Text(
                          'Dịch vụ',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )),
                      ),
                      billDetailsController.bill.value.serviceClose == null
                          ? Container()
                          : Column(
                              children: billDetailsController.bill.value
                                  .serviceClose!.listServiceCloseItems!
                                  .map((item) => serviceItem(item, context))
                                  .toList(),
                            ),
                      billDetailsController.bill.value.status == 1 ||
                              billDetailsController.bill.value.status == 2
                          ? Column(
                              children: [
                                Container(
                                  width: size.width,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).primaryColor),
                                  child: const Center(
                                      child: Text(
                                    'Ảnh thanh toán',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: billDetailsController
                                              .bill.value.images ==
                                          null
                                      ? const Center(
                                          child: Text(
                                            'Không có ảnh',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : Wrap(
                                          children: [
                                            ...billDetailsController
                                                .bill.value.images!
                                                .map((e) => imagesPayment(e)),
                                          ],
                                        ),
                                )
                              ],
                            )
                          : Container(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => billDetailsController.bill.value.status == 2
            ? const SizedBox(
                height: 1,
                width: 1,
              )
            : SizedBox(
                height: 65,
                child: Column(
                  children: [
                    SahaButtonFullParent(
                      color: billDetailsController.bill.value.status == 1
                          ? Colors.green
                          : Theme.of(context).primaryColor,
                      text: billDetailsController.bill.value.status == 1
                          ? 'Xác nhận đã thanh toán'
                          : 'Chỉnh sửa',
                      onPressed: () {
                        if (billDetailsController.bill.value.status == 1) {
                          billDetailsController.billStatus(
                              billDetailsController.bill.value.id!, 2);
                        } else {
                          Get.to(() => AddBillScreen(
                                    billInput: billDetailsController.bill.value,
                                  ))!
                              .then((value) => billDetailsController.getOneBill(
                                  id: billDetailsController.bill.value.id!));
                        }
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget serviceItem(Service item, context) {
    if (item.typeUnit == 0) {
      return Container(
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    item.serviceIcon != null && item.serviceIcon!.isNotEmpty
                        ? item.serviceIcon ?? ""
                        : "",
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${item.serviceName} ( ${item.serviceUnit} )',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              Wrap(
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     ShowImage.seeImage(
                  //       listImageUrl: (item.images ?? []),
                  //       index: 0,
                  //     );
                  //   },
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(5.0),
                  //     child: CachedNetworkImage(
                  //       height: 100,
                  //       width: 100,
                  //       fit: BoxFit.cover,
                  //       imageUrl:
                  //           (item.images ?? []).isEmpty ? "" : item.images![0],
                  //       placeholder: (context, url) => SahaLoadingWidget(),
                  //       errorWidget: (context, url, error) => SahaEmptyImage(),
                  //     ),
                  //   ),
                  // ),
                  ...item.images!.map((e) => images(e))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Chỉ số cũ:',
                  ),
                  Text(
                    '${item.oldQuantity} ${item.serviceUnit}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Chỉ số mới:',
                  ),
                  Text(
                    '${item.quantity} ${item.serviceUnit}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Số lượng tiêu thụ:',
                  ),
                  Text(
                    '${num.parse(item.quantity.toString()) - num.parse(item.oldQuantity.toString())} ${item.serviceUnit}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Đơn giá:',
                  ),
                  Text(
                    '${SahaStringUtils().convertToMoney(item.serviceCharge ?? "0")} đ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thành tiền :',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Text(
                    '${SahaStringUtils().convertToMoney(item.total ?? "0")} đ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (item.typeUnit == 3) {
      return Container(
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    item.serviceIcon != null && item.serviceIcon!.isNotEmpty
                        ? item.serviceIcon ?? ""
                        : "",
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${item.serviceName} ( Số lần )',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              Wrap(
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(5.0),
                  //   child: CachedNetworkImage(
                  //     height: 100,
                  //     width: 100,
                  //     fit: BoxFit.cover,
                  //     imageUrl:
                  //         (item.images ?? []).isEmpty ? "" : item.images![0],
                  //     placeholder: (context, url) => SahaLoadingWidget(),
                  //     errorWidget: (context, url, error) => SahaEmptyImage(),
                  //   ),
                  // ),
                  ...item.images!.map((e) => images(e))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Số lần dử dụng:',
                  ),
                  Text(
                    '${item.quantity}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Đơn giá:',
                  ),
                  Text(
                    '${SahaStringUtils().convertToMoney(item.serviceCharge ?? "0")} đ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thành tiền:',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Text(
                    '${SahaStringUtils().convertToMoney(item.total ?? "0")} đ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (item.typeUnit == 1) {
      return Container(
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    item.serviceIcon != null && item.serviceIcon!.isNotEmpty
                        ? item.serviceIcon ?? ""
                        : "",
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    '${item.serviceName} ( Người/Số lượng )',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              Wrap(
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(5.0),
                  //   child: CachedNetworkImage(
                  //     height: 100,
                  //     width: 100,
                  //     fit: BoxFit.cover,
                  //     imageUrl:
                  //         (item.images ?? []).isEmpty ? "" : item.images![0],
                  //     placeholder: (context, url) => SahaLoadingWidget(),
                  //     errorWidget: (context, url, error) => SahaEmptyImage(),
                  //   ),
                  // ),
                  ...item.images!.map((e) => images(e))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Số người/Số lượng:',
                  ),
                  Text(
                    '${item.quantity}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Đơn giá:',
                  ),
                  Text(
                    '${SahaStringUtils().convertToMoney(item.serviceCharge ?? "0")} đ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thành tiền:',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Text(
                    '${SahaStringUtils().convertToMoney(item.total ?? "0")} đ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    item.serviceIcon != null && item.serviceIcon!.isNotEmpty
                        ? item.serviceIcon ?? ""
                        : "",
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    '${item.serviceName} ( Phòng )',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              Wrap(
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(5.0),
                  //   child: CachedNetworkImage(
                  //     height: 100,
                  //     width: 100,
                  //     fit: BoxFit.cover,
                  //     imageUrl:
                  //         (item.images ?? []).isEmpty ? "" : item.images![0],
                  //     placeholder: (context, url) => SahaLoadingWidget(),
                  //     errorWidget: (context, url, error) => SahaEmptyImage(),
                  //   ),
                  // ),
                  ...item.images!.map((e) => images(e))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Số lượng :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    '${item.quantity}',
                    //'1',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Đơn giá :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    '${SahaStringUtils().convertToMoney(item.serviceCharge ?? "0")} đ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thành tiền :',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Text(
                    '${SahaStringUtils().convertToMoney(item.total ?? "0")} đ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget imagesPayment(String images) {
    return InkWell(
      onTap: () {
        ShowImage.seeImage(
            listImageUrl:
                (billDetailsController.bill.value.images ?? []).toList(),
            index: (billDetailsController.bill.value.images ?? [])
                .toList()
                .indexOf(images));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: CachedNetworkImage(
          height: 100,
          width: 100,
          fit: BoxFit.cover,
          imageUrl: images ?? '',
          //placeholder: (context, url) => SahaLoadingWidget(),
          errorWidget: (context, url, error) => const SahaEmptyImage(),
        ),
      ),
    );
  }

  Widget images(String images) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          ShowImage.seeImage(listImageUrl: [images], index: 0);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: CachedNetworkImage(
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            imageUrl: images ?? '',
            //placeholder: (context, url) => SahaLoadingWidget(),
            errorWidget: (context, url, error) => const SahaEmptyImage(),
          ),
        ),
      ),
    );
  }
}
