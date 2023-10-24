import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/model/service.dart';
import 'package:gohomy/utils/string_utils.dart';

import 'add_service/add_service_screen.dart';
import 'service_controller.dart';

class ServiceScreen extends StatelessWidget {
  ServiceController serviceController = ServiceController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Dịch vụ",
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFEF4355),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddServiceScreen())!
              .then((value) => {serviceController.getAllService()});
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  children: [
                    ...serviceController.listService.map((e) {
                      return itemService(service: e, context: context);
                    }).toList()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemService({required Service service, context}) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddServiceScreen(
                  serviceInput: service,
                ))!
            .then((value) => {serviceController.getAllService()});
      },
      child: Container(
        width: Get.width / 3.3,
        height: 130,
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
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              service.serviceIcon != null && service.serviceIcon!.isNotEmpty
                  ? service.serviceIcon ?? ""
                  : "",
              width: 25,
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Text(
                service.serviceName ?? "",
              ),
            ),
            Text(
              "${SahaStringUtils().convertToMoney(service.serviceCharge ?? "")}đ/${service.serviceUnit ?? ""}",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
