import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gohomy/screen/admin/decentralization_admin/update_decentralization/update_decentralization_controller.dart';

import '../../../../components/button/saha_button.dart';

class UpdateDecentralizationScreen extends StatelessWidget {
  UpdateDecentralizationScreen({Key? key, required this.id}) : super(key: key) {
    updateDecentralizationController = UpdateDecentralizationController(id: id);
  }
  int id;

  final _formKey = GlobalKey<FormState>();
  late UpdateDecentralizationController updateDecentralizationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: const Text('Sửa phân quyền'),
      ),
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
                        controller: updateDecentralizationController
                            .nameEditingController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Chưa nhập tên phân quyền';
                          }
                          return null;
                        },
                        onChanged: (v) {
                          updateDecentralizationController
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
                        controller: updateDecentralizationController
                            .desEditingController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Chưa nhập mô tả phân quyền';
                          }
                          return null;
                        },
                        onChanged: (v) {
                          updateDecentralizationController
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
                              value: updateDecentralizationController
                                      .decentralization.value.viewBadge ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization.value.viewBadge = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization.value.manageMotel ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization.value.manageMotel = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization.value.manageUser ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization.value.manageUser = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization.value.manageMoPost ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .manageMoPost = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization.value.manageContract ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .manageContract = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization.value.manageBill ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization.value.manageBill = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization.value.manageMessage ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .manageMessage = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization
                                      .value
                                      .manageReportProblem ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .manageReportProblem = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization.value.manageService ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .manageService = value;
                                print(updateDecentralizationController
                                    .decentralization.value.manageService);
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization
                                      .value
                                      .manageOrderServiceSell ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .manageOrderServiceSell = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization
                                      .value
                                      .manageNotification ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .manageNotification = value;
                                updateDecentralizationController
                                    .decentralization
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
                        const Text("Cài đặt banner"),
                        Obx(
                          () => CupertinoSwitch(
                              value: updateDecentralizationController
                                      .decentralization.value.settingBanner ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .settingBanner = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization.value.settingContact ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .settingContact = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization.value.settingHelp ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization.value.settingHelp = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization
                                      .value
                                      .manageMotelConsult ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .manageMotelConsult = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization
                                      .value
                                      .manageReportStatistic ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .manageReportStatistic = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization
                                      .value
                                      .manageServiceSell ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .manageServiceSell = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization
                                      .value
                                      .ableDecentralization ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .ableDecentralization = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization.value.manageRenter ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .manageRenter = value;
                                updateDecentralizationController
                                    .decentralization
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
                              value: updateDecentralizationController
                                      .decentralization
                                      .value
                                      .manageCollaborator ??
                                  false,
                              onChanged: (bool value) {
                                updateDecentralizationController
                                    .decentralization
                                    .value
                                    .manageCollaborator = value;
                                updateDecentralizationController
                                    .decentralization
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
              text: 'Cập nhật phân quyền',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  updateDecentralizationController.updateDecentralization(
                      id: id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
