import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/decentralization_admin/add_decentralization/add_decenlization_controller.dart';

import '../../../../components/button/saha_button.dart';

// ignore: must_be_immutable
class AddDecentralizationScreen extends StatelessWidget {
  AddDecentralizationScreen({Key? key}) : super(key: key);
  AddDecentralizationController addDecentralizationController =
      AddDecentralizationController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController desEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Color(0xFFEF4355),
                    Color(0xFFFF964E),
                  ]),
            ),
          ),
          title: const Text('Thêm phân quyền')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tên phân quyền: ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    SizedBox(
                      width: Get.width,
                      child: TextFormField(
                        controller: nameEditingController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Chưa nhập tên phân quyền';
                          }
                          return null;
                        },
                        onChanged: (v) {
                          addDecentralizationController
                              .decentralization.value.name = v;
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Nhập tên phân quyền",
                        ),
                        style: const TextStyle(fontSize: 14),
                        minLines: 1,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mô tả phân quyền: ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    SizedBox(
                      width: Get.width,
                      child: TextFormField(
                        controller: desEditingController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Chưa nhập mô tả phân quyền';
                          }
                          return null;
                        },
                        onChanged: (v) {
                          addDecentralizationController
                              .decentralization.value.description = v;
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Nhập mô tả phân quyền",
                        ),
                        style: const TextStyle(fontSize: 14),
                        minLines: 1,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Xem chỉ số"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.viewBadge ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController
                                    .decentralization.value.viewBadge = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quản lý phòng trọ"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.manageMotel ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController
                                    .decentralization.value.manageMotel = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quản lý người dùng"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.manageUser ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController
                                    .decentralization.value.manageUser = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quản lý bài đăng"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.manageMoPost ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.manageMoPost = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quản lý hợp đồng"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.manageContract ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.manageContract = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quản lý hoá đơn"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.manageBill ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController
                                    .decentralization.value.manageBill = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quản lý tin nhắn"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.manageMessage ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.manageMessage = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quản lý sự cố"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization
                                      .value
                                      .manageReportProblem ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.manageReportProblem = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quản lý dịch vụ"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.manageService ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.manageService = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quản lý đơn hàng"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization
                                      .value
                                      .manageOrderServiceSell ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.manageOrderServiceSell = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quản lý thông báo"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization
                                      .value
                                      .manageNotification ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.manageNotification = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Cài đặt giao diện"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.settingBanner ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.settingBanner = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Cài đặt liên hệ"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.settingContact ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.settingContact = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Cài đặt hỗ trợ/trợ giúp"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.settingHelp ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController
                                    .decentralization.value.settingHelp = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Cài đặt liên hệ tư vấn phòng"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization
                                      .value
                                      .manageMotelConsult ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.manageMotelConsult = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Cài đặt báo cáo thống kê"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization
                                      .value
                                      .manageReportStatistic ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.manageReportStatistic = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Cài đặt dịch vụ bán"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization
                                      .value
                                      .manageServiceSell ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.manageServiceSell = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Cài đặt quyền phân quyền"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization
                                      .value
                                      .ableDecentralization ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.ableDecentralization = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Cài đặt quản lý người thuê"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.manageRenter ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.manageRenter = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Cài đặt quản lý cộng tác viên"),
                        Obx(
                          () => CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization
                                      .value
                                      .manageCollaborator ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.manageCollaborator = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              color: Theme.of(context).primaryColor,
              text: 'Thêm phân quyền',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  addDecentralizationController.addDecentralization();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
