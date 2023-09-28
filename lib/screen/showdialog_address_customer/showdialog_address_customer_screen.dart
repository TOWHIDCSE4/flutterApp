import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/loading/loading_full_screen.dart';
import '../choose_address_customer_screen/choose_address_customer_controller.dart';

class ShowDialogAddressCustomer extends StatelessWidget {
  final TypeAddress? typeAddress;
  final idProvince;
  final idDistrict;
  final Function? callback;

  late ChooseAddressCustomerController chooseAddressCustomerController;

  ShowDialogAddressCustomer({
    Key? key,
    this.typeAddress,
    this.idProvince,
    this.idDistrict,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    chooseAddressCustomerController = ChooseAddressCustomerController(
      typeAddress,
      idProvince,
      idDistrict,
    );

    return Scaffold(
      body: Obx(
        () => chooseAddressCustomerController.notEnteredProvince.value
            ? SizedBox(
                height: Get.height,
                width: Get.width,
                child: const Center(
                  child: Text("Chưa chọn địa chỉ Tỉnh/Thành Phố"),
                ),
              )
            : chooseAddressCustomerController.isLoadingAddress.value == true
                ? SahaLoadingFullScreen()
                : Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: chooseAddressCustomerController.listLocationAddress.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            callback!(chooseAddressCustomerController.listLocationAddress.value[index]);
                            Get.back();
                          },
                          child: ListTile(
                            title: Text(
                              chooseAddressCustomerController.listLocationAddress.value[index].name!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 1,
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
