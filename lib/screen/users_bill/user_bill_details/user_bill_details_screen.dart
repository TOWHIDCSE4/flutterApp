import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/users_bill/user_bill_details/user_bill_details_controller.dart';
import 'package:gohomy/screen/users_bill/user_bill_details/user_payment/user_payment_screen.dart';
import 'package:intl/intl.dart';

import '../../../components/button/saha_button.dart';
import '../../../components/empty/saha_empty_image.dart';
import '../../../components/loading/loading_full_screen.dart';
import '../../../components/loading/loading_widget.dart';

import '../../../components/widget/image/show_image.dart';
import '../../../model/service.dart';
import '../../../utils/string_utils.dart';

class UserBillDetailsScreen extends StatefulWidget {
  const UserBillDetailsScreen({Key? key, required this.billId})
      : super(key: key);
  final int billId;

  @override
  State<UserBillDetailsScreen> createState() => _UserBillDetailsScreenState();
}

class _UserBillDetailsScreenState extends State<UserBillDetailsScreen> {
  UserBillDetailsController userBillDetailsController =
      UserBillDetailsController();
  @override
  void initState() {
    super.initState();
    userBillDetailsController.getUserBill(widget.billId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar:
          Obx(() => userBillDetailsController.bill.value.status == 0
              ? SizedBox(
                  height: 65,
                  child: Column(
                    children: [
                      SahaButtonFullParent(
                        color: Theme.of(context).primaryColor,
                        text: 'Thanh toán',
                        onPressed: () {
                          Get.to(() => UserPaymentScreen(
                              bill: userBillDetailsController.bill.value));
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                )),
      appBar: AppBar(
        title: const Text('Chi tiết hóa đơn'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(
            () => userBillDetailsController.isLoading.value
                ? SahaLoadingFullScreen()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mã hóa đơn:${userBillDetailsController.bill.value.id}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Hóa đơn tháng : ${userBillDetailsController.bill.value.content}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (userBillDetailsController.bill.value.datePayment !=
                          null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy').format(userBillDetailsController.bill.value.datePayment!),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
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
                          Expanded(
                            child: Text(
                                '${userBillDetailsController.bill.value.motel?.motelName}'),
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
                              'Ghi chú : ${userBillDetailsController.bill.value.note ?? ""}'),
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
                            '${SahaStringUtils().convertToMoney(userBillDetailsController.bill.value.totalMoneyMotel ?? "0")} đ',
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
                            '${SahaStringUtils().convertToMoney(userBillDetailsController.bill.value.totalMoneyService ?? "0")} đ',
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
                            'Thanh toán bởi tiền đặt cọc :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            '${SahaStringUtils().convertToMoney(userBillDetailsController.bill.value.totalMoneyHasPaidByDeposit ?? "0")} đ',
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
                            '${SahaStringUtils().convertToMoney(userBillDetailsController.bill.value.discount ?? "0")} đ',
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
                            'Tổng cộng :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            '${SahaStringUtils().convertToMoney(userBillDetailsController.bill.value.totalFinal ?? "0")} đ',
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor),
                        child: const Center(
                            child: Text(
                          'Dịch vụ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        )),
                      ),
                      userBillDetailsController.bill.value.serviceClose == null
                          ? Container()
                          : Column(
                              children: userBillDetailsController.bill.value
                                  .serviceClose!.listServiceCloseItems!
                                  .map((item) => serviceItem(item))
                                  .toList(),
                            ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget serviceItem(Service item) {
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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              item.images != null
                  ? Wrap(
                      children: [...item.images!.map((e) => images(e))],
                    )
                  : Container(),
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
                  const Text(
                    'Thành tiền:',
                    style: TextStyle(
                        color: Colors.green,
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
                    //'${item.serviceName} ( ${item.serviceUnit} )',
                    '${item.serviceName} (Người)',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              item.images != null
                  ? Wrap(
                      children: [...item.images!.map((e) => images(e))],
                    )
                  : Container(),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Số người :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    //'${item.quantity} ${item.serviceUnit}',
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
                  const Text(
                    'Thành tiền :',
                    style: TextStyle(
                        color: Colors.green,
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
    } else if (item.typeUnit == 2) {
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
                    //'${item.serviceName} ( ${item.serviceUnit} )',
                    '${item.serviceName} (Phòng)',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              item.images != null
                  ? Wrap(
                      children: [...item.images!.map((e) => images(e))],
                    )
                  : Container(),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Số lượng:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    //'${item.quantity} ${item.serviceUnit}',
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
                  const Text(
                    'Thành tiền :',
                    style: TextStyle(
                        color: Colors.green,
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
              item.images != null
                  ? Wrap(
                      children: [...item.images!.map((e) => images(e))],
                    )
                  : Container(),
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
                  const Text(
                    'Thành tiền:',
                    style: TextStyle(
                        color: Colors.green,
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
