import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';
import 'package:gohomy/screen/profile/profile_details/controller/registration_controller.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../widget/body_text_tile.dart';
import '../widget/custom_button.dart';
import 'fill_profile_accuracy_page.dart';
import 'widgets/custom_textfield_kyc.dart';

class CaptureDataPage extends StatefulWidget {
  const CaptureDataPage({super.key});

  @override
  State<CaptureDataPage> createState() => _CaptureDataPageState();
}

class _CaptureDataPageState extends State<CaptureDataPage> {
  bool isEnableEdit = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     RegistrationController registrationController = Get.put(RegistrationController());
     bool isPeopleId = registrationController.idType.value == IdCardType.peopleID;
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
          'Cập nhật thông tin định danh',
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
                const SizedBox(height: 16),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Hồ sơ',
                              style: TextStyle(
                                color: AppColor.dark1,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isEnableEdit = true;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  ImageAssets.editIcon,
                                  height: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomTextFieldKYC(
                          title: 'Họ tên',
                          hintText: registrationController.name.value,
                          enabled: isEnableEdit,
                          onChanged: (data) {
                            registrationController.name.value = data;
                          },
                        ),
                        CustomTextFieldKYC(
                          title: 'Ngày sinh',
                          hintText: registrationController.dateOfBirth.value,
                          enabled: isEnableEdit,
                          onChanged: (data) {
                            registrationController.dateOfBirth.value = data;
                          },
                        ),
                        CustomTextFieldKYC(
                          title: 'Số CMND/CCCD',
                          hintText: registrationController.idNumber.value,
                          enabled: isEnableEdit,
                          onChanged: (data) {
                            registrationController.idNumber.value = data;
                          },
                        ),
                        CustomTextFieldKYC(
                          title: 'Ngày cấp',
                          hintText: registrationController.createdDate.value,
                          enabled: isEnableEdit,
                          onChanged: (data) {
                            registrationController.createdDate.value = data;
                          },
                        ),
                        CustomTextFieldKYC(
                          title: 'Nơi cấp',
                          hintText: registrationController.createdLocation.value,
                          enabled: isEnableEdit,
                          onChanged: (data) {
                            registrationController.createdLocation.value = data;
                          },
                        ),
                        isPeopleId ? const SizedBox.shrink() : CustomTextFieldKYC(
                          title: 'Giới tính',
                          hintText: registrationController.sex.value,
                          enabled: isEnableEdit,
                          onChanged: (data) {
                            registrationController.sex.value = data;
                          },
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
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Thông tin cá nhân',
                          style: TextStyle(
                            color: AppColor.dark1,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        BodyTextTile(
                          title: 'Địa chỉ',
                        ),
                        BodyTextTile(
                          title: 'Số điện thoại',
                        ),
                        BodyTextTile(
                          title: 'Email',
                        ),
                        BodyTextTile(
                          title: 'Nghề nghiệp',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.15),
                CustomButton(
                  title: 'Xác thực',
                  bgColor: AppColor.primaryColor,
                  width: size.width * 0.85,
                  onTap: () {
                    if (registrationController.name.value.toLowerCase().contains('not found') ||
                    registrationController.dateOfBirth.value.toLowerCase().contains('not found')||
                    registrationController.idNumber.value.toLowerCase().contains('not found')||
                    registrationController.createdDate.value.toLowerCase().contains('not found')||
                    registrationController.createdLocation.value.toLowerCase().contains('not found')) {
                      SahaAlert.showError(message: 'Thẻ id của bạn không chính xác. Vui lòng chụp lại hình ảnh của bạn.');
                    } else {
                      Get.to(const FillProfileAccuracyPage());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}