import 'package:flutter/material.dart';

import 'package:gohomy/components/text_field/sahashopTextField.dart';
import 'package:gohomy/const/admin_notification.dart';
import 'package:gohomy/screen/admin/notification_admin/notification_controller.dart';

import '../../../components/button/saha_button.dart';
import '../../../components/text_field/text_field_no_border.dart';

enum Role { user, host, admin, all }

class AdminNotification extends StatefulWidget {
  const AdminNotification({Key? key}) : super(key: key);

  @override
  State<AdminNotification> createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
  AdminNotificationController adminNotificationController =
      AdminNotificationController();
  Role? role = Role.user;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          title: const Text('Thông báo'),
        ),
        body: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SahaTextField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Không được để trống';
                }
                return null;
              },
              labelText: 'Tiêu đề thông báo',
              hintText: 'Nhập tiêu đề thông báo',
              controller: adminNotificationController.title,
              onChanged: (v) {
                adminNotificationController.adminNoti.title = v;
              },
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
                    offset: const Offset(1, 3), // changes position of shadow
                  ),
                ],
              ),
              child: SahaTextFieldNoBorder(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Không được để trống';
                  }
                  return null;
                },
                enabled: true,
                controller: adminNotificationController.content,
                onChanged: (v) {
                  adminNotificationController.adminNoti.content = v;
                },
                textInputType: TextInputType.multiline,
                maxLine: 5,
                labelText: "Nội dung thông báo",
                hintText: "Nhập nội dung thông báo",
              ),
            ),
            InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Chọn đối tượng gửi đến'),
                          actions: [
                            Column(
                              children: [
                                ListTile(
                                  title: const Text('Người thuê'),
                                  leading: Radio<Role>(
                                    value: Role.user,
                                    groupValue: role,
                                    onChanged: (Role? value) {
                                      setState(() {
                                        role = value;
                                        adminNotificationController.role.text =
                                            'Người thuê';
                                        adminNotificationController
                                            .adminNoti.role = USER_NORMAL;
                                      });

                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Chủ nhà'),
                                  leading: Radio<Role>(
                                    value: Role.host,
                                    groupValue: role,
                                    onChanged: (Role? value) {
                                      setState(() {
                                        role = value;
                                        adminNotificationController.role.text =
                                            'Chủ nhà';
                                        adminNotificationController
                                            .adminNoti.role = USER_IS_HOST;
                                      });

                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Admin'),
                                  leading: Radio<Role>(
                                    value: Role.admin,
                                    groupValue: role,
                                    onChanged: (Role? value) {
                                      setState(() {
                                        role = value;
                                        adminNotificationController.role.text =
                                            'Admin';
                                        adminNotificationController
                                            .adminNoti.role = USER_IS_ADMIN;
                                      });

                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Tất cả'),
                                  leading: Radio<Role>(
                                    value: Role.all,
                                    groupValue: role,
                                    onChanged: (Role? value) {
                                      setState(() {
                                        role = value;
                                        adminNotificationController.role.text =
                                            'Tất cả';
                                        adminNotificationController
                                            .adminNoti.role = 3;
                                      });

                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gửi đến :',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Row(
                        children: [
                          Text(
                            adminNotificationController.role.text,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          const Icon(Icons.navigate_next_rounded),
                        ],
                      )
                    ],
                  ),
                )),
          ]),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: 'Đăng thông báo',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    adminNotificationController.sendAdminNotification();
                  }
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
