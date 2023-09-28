import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../components/button/saha_button.dart';
import '../../const/app_font.dart';
import '../../const/color.dart';
import 'component/info_card/card_content.dart';
import 'component/info_card/info_card.dart';
import 'widgets/title_widget.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading:  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
        title: const AppTitle(
          text: 'Hồ sơ cá nhân',
          type: AppFontSize.title,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 54,
                  width: 54,
                  child: CircleAvatar(
                    child: Image.asset(
                      'assets/images/profile.png',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    height: 14,
                    width: 14,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: SvgPicture.asset(
                          'assets/images/cam.svg',
                          width: 8,
                          height: 8,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
             Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppTitle(
                    text: 'Hồ sơ cá nhân',
                    type: AppFontSize.title,
                  ),
                  const SizedBox(width: 10.0),
                  const Icon(
                    Icons.edit,
                    size: 16,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const InfoCard(headTitle: 'Hồ sơ', headSubtitle: 'Xác thực', rows: [
              ContentRow(text: 'Ngày sinh'),
              ContentRow(text: 'Số CMND/CCCD'),
              ContentRow(text: 'Ngày cấp'),
              ContentRow(text: 'Nơi cấp'),
              ContentRow(text: 'Giới tính'),
            ]),
            const SizedBox(height: 16.0),
            const InfoCard(
                headTitle: 'Thông tin cá nhân',
                headSubtitle: 'Chỉnh sửa',
                rows: [
                  ContentRow(text: 'Địa chỉ'),
                  ContentRow(text: 'Số điện thoại'),
                  ContentRow(text: 'Email'),
                  ContentRow(text: 'Nghề nghiệp'),
                ]),
            // const SizedBox(height: 20.0),
            const Spacer(),
            SahaButtonFullParent(
              text: 'Kích hoạt ví Renren',
              color: AppColor.diabled,
              onPressed: () {
                showSheet(context);
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

void showSheet(context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (
        BuildContext bc,
      ) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          child: Wrap(
            children: <Widget>[
              const Center(
                child: AppTitle(
                    text: 'Thay ảnh đại diện', type: AppFontSize.title),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Máy ảnh',
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 1,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Thư viện ảnh',
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 1,
              ),
              InkWell(
                onTap: () {
                  // Get.to(NIDFront());
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    'Đóng',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
