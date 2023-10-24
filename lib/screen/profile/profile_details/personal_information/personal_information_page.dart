import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/profile/profile_details/profile_details_page.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';

import '../controller/registration_controller.dart';
import 'success_profile_page.dart';
import 'widgets/custom_textfiield.dart';
import 'widgets/text_field_title.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RegistrationController registrationController = Get.put(RegistrationController());
    DataAppController dataAppController = Get.find();
    String number = dataAppController.badge.value.user?.phoneNumber ?? '0123456789';
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
          'Chỉnh sửa thông tin cá nhân',
          style: TextStyle(color: Color(0xFF1A1A1A)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextFieldTextTitle(title: 'Địa chỉ'),
                CustomTextFiled(
                  textEditingController: addressController,
                  hintText: '00/00/00',
                ),
                const TextFieldTextTitle(title: 'Số điện thoại'),
                CustomTextFiled(
                  textEditingController: phoneController,
                  hintText: number,
                  backgroungColor: AppColor.light2,
                  keyboardType: TextInputType.number,
                  enabled: false,
                ),
                const TextFieldTextTitle(title: 'Email'),
                CustomTextFiled(
                  textEditingController: emailController,
                  hintText: 'abc@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                const TextFieldTextTitle(title: 'Nghề nghiệp'),
                CustomTextFiled(
                  textEditingController: jobController,
                  hintText: 'Tự do',
                ),
                SizedBox(height: size.height * 0.25),
                CustomButton(
                  title: 'Xác thực',
                  bgColor: AppColor.primaryColor,
                  // width: size.width * 0.85,
                  onTap: () {
                    if (addressController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        jobController.text.isNotEmpty
                    ) {
                      registrationController.address.value = addressController.text;
                      registrationController.phone.value = number;
                      registrationController.email.value = emailController.text;
                      registrationController.job.value = jobController.text;
                      Get.to(ProfileDetailsPage(
                        name: registrationController.name.value,
                        dateOfBirth: registrationController.dateOfBirth.value,
                        nid: registrationController.idNumber.value,
                        creationDay: registrationController.createdDate.value,
                        creationlocate: registrationController.createdLocation.value,
                        sex: registrationController.sex.value,
                        address: registrationController.address.value,
                        phone: registrationController.phone.value,
                        email: registrationController.email.value,
                        job: registrationController.job.value,
                        imagePath: registrationController.profileImagePath.value,
                        isEnabled: true,
                        onTapContinue: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const SuccessProfilePage(),
                          //   ),
                          // );
                          var isHost = dataAppController.badge.value.user?.isHost;
                          if (isHost == false || isHost == null) {
                            //renter
                            registrationController.renterOrMasterRegistration(
                              isRenter: true,
                            ); 
                          } else {
                            registrationController.renterOrMasterRegistration(
                              isRenter: false,
                            ); 
                          }
                        },
                      ));
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
