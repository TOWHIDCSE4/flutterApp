import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';

import 'profile_accuracy/profile_accuracy_page.dart';
import 'widget/body_text_tile.dart';
import 'widget/custom_button.dart';
import 'widget/header_text_tile.dart';
import 'widget/image_picker_tile.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({
    super.key,
    this.name,
    this.dateOfBirth,
    this.nid,
    this.creationDay,
    this.creationlocate,
    this.sex,
    this.address,
    this.phone,
    this.email,
    this.job,
    this.imagePath,
    this.isEnabled = false,
    this.btnText,
    this.onTapContinue,
  });

  final String? name;
  final String? dateOfBirth;
  final String? nid;
  final String? creationDay;
  final String? creationlocate;
  final String? sex;
  final String? address;
  final String? phone;
  final String? email;
  final String? job;
  final String? imagePath;
  final bool isEnabled;
  final String? btnText;
  final VoidCallback? onTapContinue;

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  bool isVisibleEditIcon = true;
  TextEditingController nameController = TextEditingController(text: 'Ngô Thị Khánh Chi');
  String name = 'Ngô Thị Khánh Chi';

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: Get.back,
        ),
        title: const Text(
          'Hồ sơ cá nhân',
          style: TextStyle(color: Color(0xFF1A1A1A)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                widget.imagePath == null
                // ? ImagePickerTile(
                //     child: SvgPicture.asset(
                //       ImageAssets.profileCamera,
                //       height: 60,
                //       width: 60,
                //     ),
                //     onSelectImage: (imagePath) {
                //       log(imagePath.toString());
                //     },
                //   )
                ? const SizedBox.shrink()
                : CircleAvatar(
                    radius: 48,
                    backgroundImage: FileImage(
                      File(widget.imagePath!),
                    ),
                  ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.name == null
                      ? const SizedBox.shrink()
                      : Text(
                          widget.name ?? '',
                          style: const TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // : SizedBox(
                        //     width: 150,
                        //     child: TextField(
                        //       controller: nameController,
                        //       autofocus: true,
                        //       decoration: const InputDecoration(
                        //         border: InputBorder.none,
                        //         hintText: "Ngô Thị Khánh Chi",
                        //       ),
                        //       onSubmitted: (newValue) {
                        //         setState(() {
                        //           isVisibleEditIcon = true;
                        //           name = newValue;
                        //         });
                        //       },
                        //     ),
                        //   ),
                    // const SizedBox(width: 8),
                    // isVisibleEditIcon && !widget.isEnabled
                    //     ? InkWell(
                    //         onTap: () {
                    //           setState(() {
                    //             isVisibleEditIcon = false;
                    //           });
                    //         },
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: SvgPicture.asset(
                    //             ImageAssets.editIcon,
                    //             height: 13,
                    //           ),
                    //         ),
                    //       )
                    //     : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Column(
                      children: [
                        HeadingTextTile(
                          title: 'Hồ sơ',
                          subTitle: 'Xác thực',
                          isVisibleButton: !widget.isEnabled,
                          onTap: () => Get.to(() => const ProfileAccuracyPage()),
                        ),
                        BodyTextTile(
                          title: 'Ngày sinh',
                          data: widget.dateOfBirth,
                        ),
                        BodyTextTile(
                          title: 'Số CMND/CCCD',
                          data: widget.nid,
                        ),
                        BodyTextTile(
                          title: 'Ngày cấp',
                          data: widget.creationDay,
                        ),
                        BodyTextTile(
                          title: 'Nơi cấp',
                          data: widget.creationlocate,
                        ),
                        widget.sex.toString().toLowerCase().contains('not found')
                        ? Container() : BodyTextTile(
                          title: 'Giới tính',
                          data: widget.sex,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Column(
                      children: [
                        HeadingTextTile(
                          title: 'Thông tin cá nhân',
                          subTitle: '',
                          isVisibleButton: !widget.isEnabled,
                          onTap: () {},
                        ),
                        BodyTextTile(
                          title: 'Địa chỉ',
                          data: widget.address,
                        ),
                        BodyTextTile(
                          title: 'Số điện thoại',
                          data: widget.phone,
                        ),
                        BodyTextTile(
                          title: 'Email',
                          data: widget.email,
                        ),
                        BodyTextTile(
                          title: 'Nghề nghiệp',
                          data: widget.job,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  title: widget.btnText ?? 'Kích hoạt ví Renren',
                  bgColor: widget.isEnabled
                      ? AppColor.primaryColor
                      : AppColor.diabled,
                  width: size.width * 0.85,
                  onTap: widget.isEnabled ? widget.onTapContinue! : () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}