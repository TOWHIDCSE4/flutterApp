import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/screen/admin/users/user_details/user_details_controller.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/admin/users/users_controller.dart';
import 'package:intl/intl.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../components/dialog/dialog.dart';
import '../../../../components/empty/saha_empty_avatar.dart';
import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_full_screen.dart';
import '../../../../components/loading/loading_widget.dart';
import '../../../../components/widget/image/show_image.dart';
import '../../../chat/chat_list/chat_list_screen.dart';

List<String> list = <String>['Thường', 'Uy tín', 'Vip'];
List<String> list2 = <String>['Thường', 'Thân thiết'];

class UserDetailsScreen extends StatefulWidget {
  UserDetailsScreen({Key? key, required this.userId, this.isHost})
      : super(key: key);
  int userId;
  bool? isHost;
  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  UserDetailsController userDetailsController = UserDetailsController();
  UserController userController = UserController();
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    userDetailsController.getUser(widget.userId);
  }

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
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => ChatListScreen(
                        toUser: userDetailsController.user.value,
                        isBackAll: true,
                      ));
                },
                icon: const Icon(Icons.chat)),
            GestureDetector(
              onTap: () {
                SahaDialogApp.showDialogYesNo(
                    mess: "Bạn có chắc muốn xoá user này",
                    onClose: () {},
                    onOK: () async {
                      await userDetailsController.deleteUser(id: widget.userId);
                      Get.back();
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
          () => userDetailsController.isLoading.value
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
                              imageUrl: userDetailsController
                                          .user.value.avatarImage ==
                                      null
                                  ? ''
                                  : userDetailsController
                                      .user.value.avatarImage!,
                              placeholder: (context, url) =>
                                  SahaLoadingWidget(),
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
                            title: Text(userDetailsController.user.value.name ??
                                'Chưa có thông tin'),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.phone),
                            title: Text(userDetailsController
                                        .user.value.phoneNumber ==
                                    null
                                ? "Chưa có thông tin"
                                : '(${userDetailsController.user.value.areaCode}) ${userDetailsController.user.value.phoneNumber}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () async {
                                await Clipboard.setData(ClipboardData(
                                    text: userDetailsController
                                        .user.value.phoneNumber ?? ""));
                                SahaAlert.showSuccess(
                                    message: 'Copy thành công');
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
                            title: Text(
                                userDetailsController.user.value.email ??
                                    'Chưa có thông tin'),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(FontAwesomeIcons.cakeCandles),
                            title: Text(
                                userDetailsController.user.value.dateOfBirth ==
                                        null
                                    ? 'Chưa có thông tin'
                                    : DateFormat('dd-MM-yyyy').format(
                                        userDetailsController
                                            .user.value.dateOfBirth!)),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(FontAwesomeIcons.marsAndVenus),
                            title:
                                Text(userDetailsController.user.value.sex == 0
                                    ? 'Không xác định'
                                    : userDetailsController.user.value.sex == 1
                                        ? "Nam"
                                        : "Nữ"),
                          ),
                        ),
                        if (widget.isHost == true)
                          Card(
                            child: ListTile(
                              leading: const Icon(
                                  FontAwesomeIcons.triangleExclamation),
                              title: const Text(
                                  'Thời gian trung bình giải quyết sự cố (phút):'),
                              trailing: Text(
                                  '${userDetailsController.user.value.avgMinutesResolvedProblem ?? 'Chưa có'}'),
                            ),
                          ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (widget.isHost == true)
                          Card(
                            child: ListTile(
                              leading: const Icon(FontAwesomeIcons.rankingStar),
                              title: Text(userDetailsController
                                          .user.value.hostRankName ==
                                      null
                                  ? 'Chưa có thông tin'
                                  : userDetailsController
                                      .user.value.hostRankName!),
                              trailing: DropdownButton(
                                value: dropdownValue ??
                                    list[userDetailsController
                                            .user.value.hostRank ??
                                        0],
                                onChanged: (String? v) {
                                  setState(() {
                                    dropdownValue = v;
                                  });
                                  if (v == 'Thường') {
                                    userDetailsController.user.value.hostRank =
                                        0;
                                  } else if (v == 'Uy tín') {
                                    userDetailsController.user.value.hostRank =
                                        1;
                                  } else {
                                    userDetailsController.user.value.hostRank =
                                        2;
                                  }
                                },
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        if (widget.isHost != true)
                          Card(
                            child: ListTile(
                              leading: const Icon(FontAwesomeIcons.rankingStar),
                              title: Text(userDetailsController
                                          .user.value.accountRankName ==
                                      null
                                  ? 'Chưa có thông tin'
                                  : userDetailsController
                                      .user.value.accountRankName!),
                              trailing: DropdownButton(
                                value: dropdownValue ??
                                    list2[userDetailsController
                                            .user.value.accountRank ??
                                        0],
                                onChanged: (String? v) {
                                  setState(() {
                                    dropdownValue = v;
                                  });
                                  if (v == 'Thường') {
                                    userDetailsController
                                        .user.value.accountRank = 0;
                                  } else if (v == 'Thân thiết') {
                                    userDetailsController
                                        .user.value.accountRank = 1;
                                  }
                                  // else {
                                  //   userDetailsController.user.value.accountRank =
                                  //       2;
                                  // }
                                },
                                items: list2.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
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
                                    value: userDetailsController
                                            .user.value.isAdmin ??
                                        false,
                                    onChanged: (bool value) {
                                      userDetailsController.user.value.isAdmin =
                                          value;
                                      userDetailsController.user.refresh();
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.grey[200],
                          child: Obx(
                            () => ListTile(
                                onTap: () {
                                  userDetailsController.onTapInfoBank.value =
                                      !userDetailsController
                                          .onTapInfoBank.value;
                                },
                                title: const Text('Taì khoản ngân hàng'),
                                trailing: userDetailsController
                                            .onTapInfoBank.value ==
                                        true
                                    ? const Icon(
                                        Icons.keyboard_arrow_down_outlined)
                                    : const Icon(Icons.keyboard_arrow_right)),
                          ),
                        ),
                        Obx(() =>
                            userDetailsController.onTapInfoBank.value == true
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Số tài khoản :'),
                                            Text(userDetailsController.user
                                                    .value.bankAccountNumber ??
                                                'Chưa có thông tin'),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Tên người thụ hưởng :'),
                                            Text(userDetailsController.user
                                                    .value.bankAccountName ??
                                                'Chưa có thông tin'),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Tên ngân hàng :'),
                                            Text(userDetailsController
                                                    .user.value.bankName ??
                                                'Chưa có thông tin'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox()),
                        const SizedBox(
                          height: 16,
                        ),
                        Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text('CMND mặt trước'),
                                  images(userDetailsController
                                          .user.value.cmndFrontImageUrl ??
                                      ''),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'CMND mặt sau',
                                    style: TextStyle(),
                                  ),
                                  images(userDetailsController
                                          .user.value.cmndBackImageUrl ??
                                      ''),
                                ],
                              )
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
              SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                text: 'Cập nhật',
                onPressed: () {
                  userDetailsController.updateUser(id: widget.userId).then(
                      (value) => userDetailsController.getUser(widget.userId));
                },
              ),
            ],
          ),
        ));
  }

  Widget images(String images) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          ShowImage.seeImage(listImageUrl: [images], index: 0);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: CachedNetworkImage(
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            imageUrl: images,
            //placeholder: (context, url) => SahaLoadingWidget(),
            errorWidget: (context, url, error) => const SahaEmptyImage(),
          ),
        ),
      ),
    );
  }
}
