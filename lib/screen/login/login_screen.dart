import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_widget.dart';
import 'package:gohomy/screen/register/register_screen.dart';
import '../../data/remote/saha_service_manager.dart';
import '../../utils/login.dart';
import '../../utils/user_info.dart';
import '../data_app_controller.dart';
import 'forgot/forgot_screen.dart';
import 'login_controller.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

class LoginScreen extends StatefulWidget {
  final bool? hasBack;

  const LoginScreen({Key? key, this.hasBack = false}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  DataAppController dataAppController = Get.find();

  double height = AppBar().preferredSize.height;

  final _formKey = GlobalKey<FormState>();

  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    height: Get.height / 2.5,
                    width: Get.width,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    child: Image.asset(
                      "assets/anh-nen-dang-nhap.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  widget.hasBack == true
                      ? Positioned(
                          top: height,
                          left: 10,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white38),
                              child: const Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: Get.height / 3,
                        bottom: 10,
                      ),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Obx(
                        () => Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == '') {
                                    return 'Chưa nhập số điện thoại';
                                  }
                                  return null;
                                },
                                controller: loginController
                                    .phoneOrEmailEditingController,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Số điện thoại',
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 15,
                                    bottom: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // Stack(
                              //   alignment: Alignment.centerRight,
                              //   children: [
                              //     TextFormField(
                              //       obscureText:
                              //           loginController.isObscure.value,
                              //       controller: loginController
                              //           .passwordEditingController,
                              //       textAlign: TextAlign.center,
                              //       decoration: InputDecoration(
                              //         isDense: true,
                              //         fillColor: Colors.white,
                              //         filled: true,
                              //         hintText: 'Mật Khẩu',
                              //         hintStyle: const TextStyle(
                              //           color: Colors.grey,
                              //         ),
                              //         border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.circular(30),
                              //         ),
                              //         enabledBorder: OutlineInputBorder(
                              //           borderSide: BorderSide(
                              //               color: Colors.grey.shade400),
                              //           borderRadius: BorderRadius.circular(30),
                              //         ),
                              //         focusedBorder: OutlineInputBorder(
                              //           borderSide: BorderSide(
                              //               color: Colors.grey.shade400),
                              //           borderRadius: BorderRadius.circular(30),
                              //         ),
                              //         contentPadding: const EdgeInsets.only(
                              //           left: 15,
                              //           right: 15,
                              //           top: 15,
                              //           bottom: 15,
                              //         ),
                              //       ),
                              //     ),
                              //     Positioned(
                              //       child: IconButton(
                              //         onPressed: () {
                              //           loginController.isObscure.value =
                              //               !loginController.isObscure.value;
                              //         },
                              //         icon: Icon(
                              //           loginController.isObscure.value
                              //               ? Icons.visibility
                              //               : Icons.visibility_off,
                              //           color: Theme.of(context).primaryColor,
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // ),

                              loginController.loadingLogin.value == true
                                  ? SahaLoadingWidget()
                                  : GestureDetector(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          //await loginController.loginAccount();
                                          loginController.checkHasPhoneNumber();
                                        }

                                        //  Get.to(() => AddInformationScreen());
                                      },
                                      child: Container(
                                        width: Get.width,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Color(0xFFFF964E),
                                              Color(0xFFEF4355),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const Text(
                                          "Đăng nhập",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                              // TextButton(
                              //     onPressed: () {
                              //       Get.to(() => ForgotScreen())!.then((value) {
                              //         if (value != null) {
                              //           loginController
                              //               .phoneOrEmailEditingController
                              //               .text = value['phone'];
                              //           loginController
                              //               .passwordEditingController
                              //               .text = value['pass'];
                              //         }
                              //       });
                              //     },
                              //     child: const Text('Quên mật khẩu')),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Bạn đã tài khoản chưa? ",
                                      style: TextStyle(),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => RegisterScreen());
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: const Text(
                                          "Đăng ký",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFFF49652),
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // Obx(
                              //   () => Column(
                              //     children: [
                              //       if (dataAppController.checkApple.value ==
                              //           true)
                              //         const Text(
                              //           "Hoặc bạn có thể đăng nhập bằng",
                              //           style: TextStyle(
                              //             color: Colors.grey,
                              //           ),
                              //         ),
                              //       if (dataAppController.checkApple.value ==
                              //           true)
                              //         Container(
                              //           margin: const EdgeInsets.only(
                              //             top: 20,
                              //           ),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceAround,
                              //             children: [
                              //               GestureDetector(
                              //                 onTap: () async {
                              //                   final result = await FlutterWebAuth
                              //                       .authenticate(
                              //                           preferEphemeral: true,
                              //                           url:
                              //                               'https://rencity-api.ikitech.vn/api/user/redirect/facebook',
                              //                           callbackUrlScheme:
                              //                               "foobar");

                              //                   final token = Uri.parse(result)
                              //                       .queryParameters['token'];

                              //                   LoginUtil.login(token);
                              //                 },
                              //                 child: Container(
                              //                   clipBehavior: Clip.hardEdge,
                              //                   decoration: BoxDecoration(
                              //                     borderRadius:
                              //                         BorderRadius.circular(15),
                              //                   ),
                              //                   child: SvgPicture.asset(
                              //                     "assets/facebook.svg",
                              //                     width: 50,
                              //                     height: 50,
                              //                   ),
                              //                 ),
                              //               ),
                              //               GestureDetector(
                              //                 onTap: () async {
                              //                   final result = await FlutterWebAuth
                              //                       .authenticate(
                              //                           preferEphemeral: true,
                              //                           url:
                              //                               'https://rencity-api.ikitech.vn/api/user/redirect/google',
                              //                           callbackUrlScheme:
                              //                               "foobar");
                              //                   print(result);
                              //                   final token = Uri.parse(result)
                              //                       .queryParameters['token'];
                              //                   LoginUtil.login(token);
                              //                 },
                              //                 child: Container(
                              //                   clipBehavior: Clip.hardEdge,
                              //                   decoration: BoxDecoration(
                              //                     borderRadius:
                              //                         BorderRadius.circular(15),
                              //                   ),
                              //                   child: SvgPicture.asset(
                              //                     "assets/google.svg",
                              //                     width: 45,
                              //                     height: 45,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () async {
                print(count);
                var isRelease = UserInfo().getIsRelease();
                if (count == 9) {
                  if (isRelease == null) {
                    await UserInfo().setRelease(false);
                    SahaServiceManager.initialize();
                  } else {
                    await UserInfo().setRelease(null);
                    SahaServiceManager.initialize();
                  }
                  count = 0;
                  setState(() {});
                }
                count = count + 1;
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "© 2022 RENCITY JSC ${UserInfo().getIsRelease() == null ? "" : "(DEV)"}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
