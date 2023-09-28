import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';

import '../../components/loading/loading_full_screen.dart';
import 'choose_address_customer_controller.dart';

class ChooseAddressCustomerScreen extends StatefulWidget {
  final TypeAddress? typeAddress;
  final idProvince;
  final idDistrict;
  final Function? callback;

  ChooseAddressCustomerScreen(
      {Key? key,
      this.typeAddress,
      this.idProvince,
      this.idDistrict,
      this.callback})
      : super(key: key);

  @override
  State<ChooseAddressCustomerScreen> createState() =>
      _ChooseAddressCustomerScreenState();
}

class _ChooseAddressCustomerScreenState
    extends State<ChooseAddressCustomerScreen> {
  late ChooseAddressCustomerController chooseAddressCustomerController;

  @override
  void initState() {
    chooseAddressCustomerController = ChooseAddressCustomerController(
        widget.typeAddress, widget.idProvince, widget.idDistrict);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() =>
            chooseAddressCustomerController.notEnteredProvince.value
                ? const Text("Chưa chọn địa chỉ Tỉnh/Thành Phố")
                : Text(chooseAddressCustomerController.nameTitleAppbar.value)),
        backgroundColor: primaryColor,
      ),
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
                : ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: chooseAddressCustomerController
                        .listLocationAddress.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          widget.callback!(chooseAddressCustomerController
                              .listLocationAddress.value[index]);
                          Get.back();
                        },
                        child: ListTile(
                          title: Text(
                            chooseAddressCustomerController
                                .listLocationAddress.value[index].name!,
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
    );
  }
}
