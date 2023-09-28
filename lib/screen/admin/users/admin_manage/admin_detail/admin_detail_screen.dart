import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/decentralization.dart';
import 'package:gohomy/screen/admin/users/admin_manage/admin_detail/admin_detail_controller.dart';
import 'package:gohomy/screen/admin/users/admin_manage/choose_decentralization/choose_decentralization_screen.dart';
import 'package:intl/intl.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../components/button/saha_button.dart';
import '../../../../../components/empty/saha_empty_avatar.dart';
import '../../../../../components/loading/loading_full_screen.dart';
import '../../../../../components/loading/loading_widget.dart';

class AdminDetailScreen extends StatelessWidget {
  AdminDetailScreen({Key? key, required this.id}) {
    adminDetailController = AdminDetailController(id: id);
  }
  int id;
  late AdminDetailController adminDetailController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin chi tiết'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
      ),
      body: Obx(
        () => adminDetailController.isLoading.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    children: [
                      Center(
                        child: ClipOval(
                          child: CachedNetworkImage(
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            imageUrl:
                                adminDetailController.admin.value.avatarImage ==
                                        null
                                    ? ''
                                    : adminDetailController
                                        .admin.value.avatarImage!,
                            //placeholder: (context, url) => SahaLoadingWidget(),
                            errorWidget: (context, url, error) =>
                                const SahaEmptyAvata(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(adminDetailController.admin.value.name ??
                              'Chưa có thông tin'),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text(adminDetailController
                                      .admin.value.phoneNumber ==
                                  null
                              ? "Chưa có thông tin"
                              : '(${adminDetailController.admin.value.areaCode}) ${adminDetailController.admin.value.phoneNumber}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(
                                  text: adminDetailController
                                      .admin.value.phoneNumber ?? ""));
                              SahaAlert.showSuccess(message: 'Copy thành công');
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.email_outlined),
                          title: Text(adminDetailController.admin.value.email ??
                              'Chưa có thông tin'),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        child: ListTile(
                          leading: const Icon(FontAwesomeIcons.cakeCandles),
                          title: Text(adminDetailController
                                      .admin.value.dateOfBirth ==
                                  null
                              ? 'Chưa có thông tin'
                              : DateFormat('dd-MM-yyyy').format(adminDetailController.admin.value.dateOfBirth!)),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        child: ListTile(
                          leading: const Icon(FontAwesomeIcons.marsAndVenus),
                          title: Text(adminDetailController.admin.value.sex == 0
                              ? 'Không xác định'
                              : adminDetailController.admin.value.sex == 1
                                  ? "Nam"
                                  : "Nữ"),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          onTap: () {
                            Get.to(() => ChooseDecentralizationScreen(
                                  decentralizationChoose: adminDetailController
                                      .decentralizationChoose.value,
                                  onChoose:
                                      (Decentralization decentralization) {
                                    adminDetailController.decentralizationChoose
                                        .value = decentralization;
                                    print(adminDetailController
                                        .decentralizationChoose.value.name);
                                    adminDetailController.decentralizationChoose
                                        .refresh();
                                  },
                                ));
                          },
                          leading: const Icon(FontAwesomeIcons.solidDriversLicense),
                          title: Text(
                              adminDetailController.decentralizationChoose.value.name ?? 'Chọn phân quyền'),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Cài đặt tài khoản này là admin"),
                            Obx(
                              () => CupertinoSwitch(
                                  value: adminDetailController
                                          .admin.value.isAdmin ??
                                      false,
                                  onChanged: (bool value) {
                                    adminDetailController.admin.value.isAdmin =
                                        value;
                                    adminDetailController.admin.refresh();
                                  }),
                            ),
                          ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SahaButtonFullParent(
                  color: Colors.deepOrange,
                  text: 'Cập nhật phân quyền',
                  onPressed: () {
                    adminDetailController.decentralizationAdmin();
                  },
                ),
                SahaButtonFullParent(
                  color: Colors.deepOrange,
                  text: 'Cập nhật admin',
                  onPressed: () {
                    adminDetailController.updateUser(id: id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
