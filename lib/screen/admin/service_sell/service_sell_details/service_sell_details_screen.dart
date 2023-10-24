import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/screen/admin/service_sell/service_sell_controller.dart';
import 'package:gohomy/screen/admin/service_sell/service_sell_details/service_sell_details_controller.dart';
import 'package:gohomy/screen/admin/service_sell/update_service_sell/update_service_sell_screen.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../components/dialog/dialog.dart';
import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../components/text_field/text_field_no_border.dart';
import '../../../../utils/string_utils.dart';

class ServiceSellDetailsScreen extends StatefulWidget {
  ServiceSellDetailsScreen({Key? key, required this.id}) : super(key: key);
  int? id;
  @override
  State<ServiceSellDetailsScreen> createState() =>
      _ServiceSellDetailsScreenState();
}

class _ServiceSellDetailsScreenState extends State<ServiceSellDetailsScreen> {
  ServiceSellDetailsController serviceSellDetailsController =
      ServiceSellDetailsController();
  ServiceSellController serviceSellController = ServiceSellController();
  @override
  void initState() {
    super.initState();
    serviceSellDetailsController.getServiceSell(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // begin: Alignment.bottomLeft,
                  // end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
          title: const Text('Chi tiết dịch vụ bán'),
          actions: [
            GestureDetector(
              onTap: () {
                SahaDialogApp.showDialogYesNo(
                    mess: "Bạn có chắc muốn xoá dịch vụ này",
                    onClose: () {},
                    onOK: () async {
                      await serviceSellDetailsController
                          .deleteServiceSell(widget.id!);
                      serviceSellController
                          .getAllServiceSell(isRefresh: true)
                          .then((value) => Get.back());
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
        body: Obx(
          () => serviceSellDetailsController.isLoading.value
              ? SahaLoadingFullScreen()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Tên dịch vụ :',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.orange)),
                            Text(
                                '${serviceSellDetailsController.serviceSell.value.name}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[500])),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Giá dịch vụ :',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.orange)),
                            Text(
                              '${SahaStringUtils().convertToMoney(serviceSellDetailsController.serviceSell.value.price)} VND',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[500]),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: size.width,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).primaryColor),
                          child: const Center(
                            child: Text(
                              'Ảnh dịch vụ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        serviceSellDetailsController.serviceSell.value.images ==
                                null
                            ? const SahaEmptyImage()
                            : Wrap(
                                children: [
                                  ...serviceSellDetailsController
                                      .serviceSell.value.images!
                                      .map((e) => images(e)),
                                ],
                              ),
                        Container(
                          width: size.width,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).primaryColor),
                          child: const Center(
                            child: Text(
                              'Ảnh icon ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        serviceSellDetailsController
                                    .serviceSell.value.serviceSellIcon ==
                                null
                            ? const SahaEmptyImage()
                            : Wrap(
                                children: [
                                  images(serviceSellDetailsController
                                      .serviceSell.value.serviceSellIcon)
                                ],
                              ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset:
                                    const Offset(1, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: SahaTextFieldNoBorder(
                            enabled: false,
                            controller:
                                serviceSellDetailsController.description,
                            textInputType: TextInputType.multiline,
                            maxLine: 5,
                            labelText: "Ghi chú",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                text: 'Chỉnh sửa dịch vụ',
                onPressed: () {
                  Get.to(() => UpdateServiceSellScreen(
                            serviceSell:
                                serviceSellDetailsController.serviceSell.value,
                          ))!
                      .then((value) => serviceSellDetailsController
                          .getServiceSell(widget.id!));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget images(String? image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: CachedNetworkImage(
          height: 100,
          width: 100,
          fit: BoxFit.cover,
          imageUrl: image ?? '',
         // placeholder: (context, url) => SahaLoadingWidget(),
          errorWidget: (context, url, error) => const SahaEmptyImage(),
        ),
      ),
    );
  }
}
