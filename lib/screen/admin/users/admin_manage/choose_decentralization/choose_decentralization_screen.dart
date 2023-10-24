import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/decentralization.dart';
import 'package:gohomy/screen/admin/users/admin_manage/choose_decentralization/choose_decentralization_controller.dart';

import '../../../../../components/button/saha_button.dart';

class ChooseDecentralizationScreen extends StatelessWidget {
  ChooseDecentralizationScreen(
      {Key? key, required this.onChoose, this.decentralizationChoose})
      : super(key: key);
  Function onChoose;
  Decentralization? decentralizationChoose;
  ChooseDecentralizationController chooseDecentralizationController =
      ChooseDecentralizationController();

  @override
  Widget build(BuildContext context) {
    if (decentralizationChoose != null) {
      chooseDecentralizationController.decentralizationChoose.value =
          decentralizationChoose!;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn phân quyền'),
      ),
      body: Obx(
        () => chooseDecentralizationController.loadInit.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
              child: Column(
                  children: [
                    ...chooseDecentralizationController.listDecentralization
                        .map((element) => itemDecentralization(element))
                  ],
                ),
            ),
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Xác nhận",
              onPressed: () {
                onChoose(chooseDecentralizationController
                    .decentralizationChoose.value);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemDecentralization(Decentralization decentralization) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                decentralization.name ?? '',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: Get.width /1.2,
                child: Text(
                  
                  decentralization.description ?? '',
                  style: TextStyle(color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Checkbox(
              value: chooseDecentralizationController
                      .decentralizationChoose.value.id ==
                  decentralization.id,
              onChanged: (v) {
                if (v == true) {
                  chooseDecentralizationController
                      .decentralizationChoose.value = decentralization;
                } else {
                  chooseDecentralizationController
                      .decentralizationChoose.value = Decentralization();
                }
                print(chooseDecentralizationController
                    .decentralizationChoose.value.name);
              })
        ],
      ),
    );
  }
}
