import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/button/saha_button.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/service.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../../../components/appbar/saha_appbar.dart';
import '../service/add_service/add_service_screen.dart';
import 'choose_service_controller.dart';

class ChooseServiceScreen extends StatelessWidget {
  List<Service>? listServiceInput;
  List<Service> serviceInput;
  Function onChoose;
  bool? isFromMotelManage;
  ChooseServiceScreen(
      {this.listServiceInput,
      required this.onChoose,
      this.isFromMotelManage,
      required this.serviceInput}) {
    chooseServiceController = ChooseServiceController(
        listServiceInput: listServiceInput, serviceInput: serviceInput);
  }

  late ChooseServiceController chooseServiceController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SahaAppBar(
        titleText: 'Chọn dịch vụ',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => AddServiceScreen(
                      isFromMotelManage: isFromMotelManage,
                      onSubmit: (v) {
                        chooseServiceController.listService.add(v);
                        chooseServiceController.listServiceSelected.add(v);
                        chooseServiceController.listService.refresh();
                         onChoose(chooseServiceController.listServiceSelected,
                      chooseServiceController.listService);
                      Get.back();
                      },
                    ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              color: Theme.of(context).primaryColor,
              text: "Xác nhận",
              onPressed: () {
                if (chooseServiceController.listServiceSelected.isNotEmpty) {
                  onChoose(chooseServiceController.listServiceSelected,
                      chooseServiceController.listService);
                } else {
                  onChoose(chooseServiceController.listServiceSelected,
                      chooseServiceController.listService);
                }
                Get.back();
              },
            ),
          ],
        ),
      ),
      body: Obx(
        () => chooseServiceController.isLoading.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
                child: Column(
                  children: chooseServiceController.listService
                      .map((e) => itemService(
                          e, chooseServiceController.listService.indexOf(e)))
                      .toList(),
                ),
              ),
      ),
    );
  }

  Widget itemService(Service service, int index) {
    return InkWell(
      onTap: () {
        Get.to(() => AddServiceScreen(
              serviceInput: service,
              isFromMotelManage: true,
              onSubmit: (Service v) {
                var index = chooseServiceController.listServiceSelected.indexWhere((e) => e.serviceName == v.serviceName);
                if(index != -1){
                  chooseServiceController.listServiceSelected[index] =v;
                }
                chooseServiceController.listService[index] = v;
                chooseServiceController.listService.refresh();
              },
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            service.serviceIcon != null
                ? Image.asset(
                    service.serviceIcon ?? "",
                    width: 40,
                    height: 40,
                  )
                : const SizedBox(),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.serviceName ?? ""),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${SahaStringUtils().convertToMoney(service.serviceCharge ?? 0)}/${service.serviceUnit}",
                    style: TextStyle(
                      color: Theme.of(Get.context!).primaryColor,
                    ),
                  )
                ],
              ),
            ),
            Checkbox(
                value: chooseServiceController.listServiceSelected
                    .map((e) => e.serviceName)
                    .toList()
                    .contains(service.serviceName),
                onChanged: (v) {
                  if (chooseServiceController.listServiceSelected
                      .map((e) => e.serviceName)
                      .toList()
                      .contains(service.serviceName)) {
                    chooseServiceController.listServiceSelected.removeAt(
                        chooseServiceController.listServiceSelected.indexWhere(
                            (e) => e.serviceName == service.serviceName));
                  } else {
                    chooseServiceController.listServiceSelected.add(service);
                  }
                })
          ],
        ),
      ),
    );
  }
}
