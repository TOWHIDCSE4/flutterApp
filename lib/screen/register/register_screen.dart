import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  RegisterController registerController = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            child: Stack(
              children: [
                Container(
                  height: 300,
                  width: Get.width,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/logo_tran.png",
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: AppBar().preferredSize.height,
                  left: 10,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 250,
                      bottom: 10,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller:
                              registerController.textEditingControllerName,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Họ và tên',
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
                        TextFormField(
                          controller:
                              registerController.textEditingControllerPhone,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Không được để trống';
                            }
                            // if (value.length != 10) {
                            //   return 'Nhập đúng 10 số điện thoại';
                            // }
                            if (isValidPhone(value) == false) {
                              return 'Số diện thoại không hợp lệ';
                            }
                            return null;
                          },
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

                        // Obx(
                        //   () => Stack(
                        //     alignment: Alignment.centerRight,
                        //     children: [
                        //       TextFormField(
                        //         controller: registerController
                        //             .textEditingControllerPass,
                        //         textAlign: TextAlign.center,
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'Không được để trống';
                        //           }

                        //           return null;
                        //         },
                        //         obscureText: registerController.isObscure.value,
                        //         decoration: InputDecoration(
                        //           // suffixIcon: IconButton(
                        //           //   onPressed: () {
                        //           //     registerController.isObscure.value =
                        //           //         !registerController.isObscure.value;
                        //           //   },
                        //           //   icon: Icon(
                        //           //     registerController.isObscure.value
                        //           //         ? Icons.visibility
                        //           //         : Icons.visibility_off,
                        //           //   ),
                        //           // ),
                        //           isDense: true,
                        //           fillColor: Colors.white,
                        //           filled: true,
                        //           hintText: 'Mật Khẩu',
                        //           hintStyle: const TextStyle(
                        //             color: Colors.grey,
                        //           ),
                        //           border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(30),
                        //           ),
                        //           enabledBorder: OutlineInputBorder(
                        //             borderSide:
                        //                 BorderSide(color: Colors.grey.shade400),
                        //             borderRadius: BorderRadius.circular(30),
                        //           ),
                        //           focusedBorder: OutlineInputBorder(
                        //             borderSide:
                        //                 BorderSide(color: Colors.grey.shade400),
                        //             borderRadius: BorderRadius.circular(30),
                        //           ),
                        //           contentPadding: const EdgeInsets.only(
                        //             left: 15,
                        //             right: 15,
                        //             top: 15,
                        //             bottom: 15,
                        //           ),
                        //         ),
                        //       ),
                        //       Positioned(
                        //         child: IconButton(
                        //           onPressed: () {
                        //             registerController.isObscure.value =
                        //                 !registerController.isObscure.value;
                        //           },
                        //           icon: Icon(
                        //             registerController.isObscure.value
                        //                 ? Icons.visibility
                        //                 : Icons.visibility_off,
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // TextFormField(
                        //   controller: registerController.referralCode,
                        //   keyboardType: TextInputType.number,
                        //   textAlign: TextAlign.center,
                        //   decoration: InputDecoration(
                        //     isDense: true,
                        //     fillColor: Colors.white,
                        //     filled: true,
                        //     hintText: 'Mã giới thiệu (Nếu có)',
                        //     hintStyle: const TextStyle(
                        //       color: Colors.grey,
                        //     ),
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(30),
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide:
                        //           BorderSide(color: Colors.grey.shade400),
                        //       borderRadius: BorderRadius.circular(30),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide:
                        //           BorderSide(color: Colors.grey.shade400),
                        //       borderRadius: BorderRadius.circular(30),
                        //     ),
                        //     contentPadding: const EdgeInsets.only(
                        //       left: 15,
                        //       right: 15,
                        //       top: 15,
                        //       bottom: 15,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              registerController.checkHasPhoneNumber();
                            }
                          },
                          child: Container(
                            width: Get.width,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFF49652),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(30),
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
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidPhone(String value) {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{9}$");
    return phoneRegExp.hasMatch(value);
  }
}
