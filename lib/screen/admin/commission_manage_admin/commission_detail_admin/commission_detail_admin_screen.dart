import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:intl/intl.dart';

import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../components/widget/image/show_image.dart';
import '../../../../utils/string_utils.dart';
import 'commission_detail_admin_controller.dart';

class CommissionDetailAdminScreen extends StatelessWidget {
  CommissionDetailAdminScreen({super.key, required this.id}) {
    commissionDetailAdminController = CommissionDetailAdminController(id: id);
  }

  int id;

  late CommissionDetailAdminController commissionDetailAdminController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SahaAppBar(
          titleText: 'Chi tiết hoa hồng chủ nhà',
        ),
        body: Obx(
          () => commissionDetailAdminController.loadInit.value
              ? SahaLoadingFullScreen()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
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
                                  'Tên chủ nhà :',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  commissionDetailAdminController
                                          .commissionManage.value.host?.name ??
                                      "Chưa có thông tin",
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
                                  'Số diện thoại:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  commissionDetailAdminController
                                          .commissionManage
                                          .value
                                          .host
                                          ?.phoneNumber ??
                                      'Chưa có thông tin',
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
                                  'Số tiền cần thanh toán',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${SahaStringUtils().convertToMoney(commissionDetailAdminController.commissionManage.value.moneyCommissionAdmin ?? "0")} đ',
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  commissionDetailAdminController
                                          .commissionManage
                                          .value
                                          .moPost
                                          ?.title ??
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
                                  'Ngày tạo :',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy').format(
                                      commissionDetailAdminController
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
                      const SizedBox(
                        height: 10,
                      ),
                      if (commissionDetailAdminController
                              .commissionManage.value.status !=
                          0)
                        Column(
                          children: [
                            Container(
                              width: Get.width,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.deepOrange),
                              child: const Center(
                                child: Text(
                                  'Ảnh thanh toán',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Wrap(
                              children: [
                                ...commissionDetailAdminController
                                    .commissionManage.value.imagesHostPaid!
                                    .map((e) => images(e))
                              ],
                            )
                          ],
                        )
                    ],
                  ),
                ),
        ),
        bottomNavigationBar: Obx(
          () =>
              commissionDetailAdminController.commissionManage.value.status != 3
                  ? const SizedBox()
                  : Container(
                      margin: const EdgeInsets.all(10),
                      height: 65,
                      child: InkWell(
                        onTap: () {
                          commissionDetailAdminController
                              .confirmCommissionAdmin(status: 2);
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
                    ),
        ));
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
            imageUrl: images,
            //placeholder: (context, url) => SahaLoadingWidget(),
            errorWidget: (context, url, error) => const SahaEmptyImage(),
          ),
        ),
      ),
    );
  }
}
