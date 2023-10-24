import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/button/saha_button.dart';
import '../../../components/text_field/sahashopTextField.dart';
import '../../../components/widget/image_picker_single/image_picker_single.dart';
import '../../../const/type_image.dart';
import '../../../model/user.dart';
import '../../../utils/date_utils.dart';
import '../../../utils/keyboard.dart';
import '../change_password/change_password_screen.dart';
import 'edit_profile_controller.dart';
import 'widget/select_avatar_image.dart';

class EditProfileUser extends StatefulWidget {
  final User user;
  TextEditingController textEditingControllerName = TextEditingController();

  TextEditingController emailController = TextEditingController();

  EditProfileUser({required this.user}) {
    textEditingControllerName.text = user.name ?? "";
    emailController.text = user.email ?? "";

    editProfileController = EditProfileController(
      users: user,
      sexIndexInput: user.sex,
    );
    editProfileController.referralCode.text = user.referralCode ?? '';
  }

  late EditProfileController editProfileController;

  @override
  State<EditProfileUser> createState() => _EditProfileUserState();
}

class _EditProfileUserState extends State<EditProfileUser> {
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    Get.delete<EditProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chỉnh sửa tài khoản"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Obx(
                    () => SelectAvatarImage(
                      type: ANOTHER_FILES_FOLDER,
                      linkLogo:
                          widget.editProfileController.user.value.avatarImage ??
                              '',
                      onChange: (link) {
                        print(link);
                        widget.editProfileController.user.value.avatarImage =
                            link;
                      },
                    ),
                  ),
                ),
                SahaTextField(
                  controller: widget.textEditingControllerName,
                  onChanged: (value) {
                    widget.editProfileController.user.value.name = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Chưa nhập Họ và tên';
                    }
                    return null;
                  },
                  autoFocus: false,
                  textInputType: TextInputType.name,
                  obscureText: false,
                  labelText: "Họ và tên",
                  hintText: "Mời nhập Họ và tên",
                  withAsterisk: true,
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Giới tính"),
                      InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xffffffff),
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(0xff999999),
                                          width: 0.0,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CupertinoButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 5.0,
                                          ),
                                          child: const Text('Thoát'),
                                        ),
                                        CupertinoButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 5.0,
                                          ),
                                          child: const Text('Xong'),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 200,
                                    color: const Color(0xfff7f7f7),
                                    child: CupertinoPicker(
                                      scrollController:
                                          FixedExtentScrollController(
                                              initialItem: widget
                                                  .editProfileController
                                                  .sexIndex),
                                      itemExtent: 32.0,
                                      backgroundColor: Colors.white,
                                      onSelectedItemChanged: (value) {
                                        widget.editProfileController
                                            .onChangeSexPicker(value);
                                      },
                                      children: const [
                                        Text('Khác'),
                                        Text('Nam'),
                                        Text('Nữ'),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: SizedBox(
                          height: 30,
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Obx(
                                () => Text(
                                  "${widget.editProfileController.sex.value} ",
                                  style: const TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/icons/right_arrow.svg",
                                color: Colors.black,
                                height: 10,
                                width: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    children: [
                      Text(
                        "Ngày sinh: ",
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                      const Spacer(),
                      Obx(
                        () => TextButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(1900, 1, 1),
                                maxTime: DateTime(2021, 1, 1),
                                theme: const DatePickerTheme(
                                    headerColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    itemStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    doneStyle: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                onConfirm: (date) {
                              widget.editProfileController.user.value
                                  .dateOfBirth = date;
                              widget.editProfileController.user.refresh();
                            },
                                currentTime: widget.editProfileController.user
                                    .value.dateOfBirth,
                                locale: LocaleType.vi);
                          },
                          child: Text(
                            SahaDateUtils().getDDMMYY(widget
                                    .editProfileController
                                    .user
                                    .value
                                    .dateOfBirth ??
                                DateTime.now()),
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SahaTextField(
                  controller: widget.emailController,
                  onChanged: (value) {
                    widget.editProfileController.user.value.email = value;
                  },
                  // validator: (value) {
                  //   if (value!.length <= 0) {
                  //     return 'Chưa nhập Email';
                  //   }
                  //   return null;
                  // },
                  autoFocus: false,
                  obscureText: false,
                  labelText: "Email",
                  hintText: "Mời nhập email",
                  withAsterisk: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Số điện thoại : ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        widget.user.phoneNumber ?? 'Chưa có số điện thoại',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SahaTextField(
                  enabled: widget.user.hasReferralCode == true ? false : true,
                  hintText: 'Nhập mã giới thiệu',
                  labelText: 'Mã giới thiệu',
                  controller: widget.editProfileController.referralCode,
                  onChanged: (v) {
                    widget.editProfileController.user.value.referralCode = v;
                  },
                ),
                SahaTextField(
                  hintText: 'Nhập số chứng minh nhân dân',
                  labelText: 'Số chứng minh nhân dân',
                  controller: widget.editProfileController.cmndNumber,
                  onChanged: (v) {
                    widget.editProfileController.user.value.cmndNumber = v;
                  },
                ),
                Card(
                  color: Colors.grey[200],
                  child: Obx(
                    () => ListTile(
                        onTap: () {
                          widget.editProfileController.onTapInfoBank.value =
                              !widget.editProfileController.onTapInfoBank.value;
                        },
                        title: const Text('Taì khoản ngân hàng'),
                        trailing:
                            widget.editProfileController.onTapInfoBank.value ==
                                    true
                                ? const Icon(Icons.keyboard_arrow_down_outlined)
                                : const Icon(Icons.keyboard_arrow_right)),
                  ),
                ),
                Obx(() => widget.editProfileController.onTapInfoBank.value ==
                        true
                    ? Column(
                        children: [
                          SahaTextField(
                            onChanged: (v) {
                              widget.editProfileController.user.value
                                  .bankAccountName = v;
                            },
                            controller:
                                widget.editProfileController.nameAccount,
                            labelText: 'Người thụ hưởng',
                            hintText: 'Nhập tên người thụ hưởng',
                          ),
                          SahaTextField(
                            onChanged: (v) {
                              widget.editProfileController.user.value
                                  .bankAccountNumber = v;
                            },
                            controller:
                                widget.editProfileController.bankAccount,
                            labelText: 'Số tài khoản',
                            hintText: 'Nhập số tài khoản',
                          ),
                          SahaTextField(
                            onChanged: (v) {
                              widget.editProfileController.user.value.bankName =
                                  v;
                            },
                            controller: widget.editProfileController.bankName,
                            labelText: 'Tên ngân hàng',
                            hintText: 'Nhập tên ngân hàng',
                          ),
                        ],
                      )
                    : const SizedBox()),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text("CMND/CCCD mặt trước"),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Obx(
                            () => ImagePickerSingle(
                              type: RENTER_FILES_FOLDER,
                              width: Get.width / 3,
                              height: Get.width / 4,
                              linkLogo: widget.editProfileController.user.value
                                  .cmndFrontImageUrl,
                              onChange: (link) {
                                widget.editProfileController.user.value
                                    .cmndFrontImageUrl = link;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("CMND/CCCD mặt sau"),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Obx(
                            () => ImagePickerSingle(
                              type: RENTER_FILES_FOLDER,
                              width: Get.width / 3,
                              height: Get.width / 4,
                              linkLogo: widget.editProfileController.user.value
                                  .cmndBackImageUrl,
                              onChange: (link) {
                                widget.editProfileController.user.value
                                    .cmndBackImageUrl = link;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Get.to(() => ChangePassword());
                    },
                    child: const Text(
                      "Thay đổi mật khẩu",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () {
            SelectLogoImageController selectLogoImageController = Get.find();

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SahaButtonFullParent(
                    text: "Cập nhật",
                    onPressed: selectLogoImageController.onUpload.value == true
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              KeyboardUtil.hideKeyboard(context);
                              widget.editProfileController.updateProfile();
                            }
                          }),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
