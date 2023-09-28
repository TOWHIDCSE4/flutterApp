import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/const/type_image.dart';
import 'package:gohomy/screen/owner/commission/commission_detail/commission_detail_controller.dart';
import 'package:intl/intl.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../components/widget/image/select_images.dart';
import '../../../../model/image_assset.dart';
import '../../../../utils/string_utils.dart';
import '../../../home/home_controller.dart';

class CommissionDetailManageScreen extends StatelessWidget {
  CommissionDetailManageScreen({super.key, required this.id}) {
    commissionDetailManageController = CommissionDetailManageController(id: id);
  }
  int id;

  late CommissionDetailManageController commissionDetailManageController;
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SahaAppBar(
          titleText: 'Chi tiết chuyển hoa hồng',
        ),
        body: Obx(
          () => commissionDetailManageController.loadInit.value
              ? SahaLoadingFullScreen()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
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
                                  'Tên chủ nhà :',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  commissionDetailManageController
                                          .commissionManage.value.host?.name ??
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
                                  'Số tiền cần thanh toán',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${SahaStringUtils().convertToMoney(commissionDetailManageController.commissionManage.value.moneyCommissionAdmin ?? "0")} đ',
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
                                  commissionDetailManageController
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
                                  commissionDetailManageController
                                              .commissionManage
                                              .value
                                              .createdAt ==
                                          null
                                      ? ''
                                      : DateFormat('dd-MM-yyyy').format(
                                          commissionDetailManageController
                                              .commissionManage
                                              .value
                                              .createdAt!),
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
                        height: 15,
                      ),
                      Column(
                        children: [
                          Container(
                            width: Get.width,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Center(
                                child: Text(
                              'Thông tin chuyển tiền',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                          Container(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Số tài khoản :'),
                                    Text(homeController.homeApp.value
                                            .adminContact?.bankAccountNumber ??
                                        '')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Tên ngân hàng :'),
                                    Text(homeController.homeApp.value
                                            .adminContact?.bankName ??
                                        '')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Tài khoản thụ hưởng :'),
                                    Text(homeController.homeApp.value
                                            .adminContact?.bankAccountName ??
                                        '')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectImages(maxImage: 10,
                            type: ANOTHER_FILES_FOLDER,
                            title: 'Ảnh thanh toán',
                            subTitle: 'Tối đa 10 hình',
                            onUpload: () {},
                            images: commissionDetailManageController.listImages
                                .toList(),
                            doneUpload: (List<ImageData> listImages) {
                              print(
                                  "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                              commissionDetailManageController
                                  .listImages(listImages);
                              if ((listImages.map((e) => e.linkImage ?? "x"))
                                  .toList()
                                  .contains('x')) {
                                SahaAlert.showError(message: 'Lỗi ảnh');
                                return;
                              }
                              commissionDetailManageController
                                      .commissionManage.value.imagesHostPaid =
                                  (listImages.map((e) => e.linkImage ?? ""))
                                      .toList();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        bottomNavigationBar: Obx(() =>
            commissionDetailManageController.commissionManage.value.status == 0
                ? Container(
                    margin: const EdgeInsets.all(10),
                    height: 65,
                    child: InkWell(
                      onTap: () {
                        commissionDetailManageController
                            .commissionManage.value.status = 3;
                        commissionDetailManageController
                            .confirmCommissionManage(id: id);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).primaryColor),
                        child: const Center(
                          child: Text('Xác nhận đã thanh toán',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  )
                : const SizedBox()));
  }
}
