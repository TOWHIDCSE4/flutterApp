import 'package:flutter/material.dart';

import '../../../components/button/saha_button.dart';
import 'update_phone_controller.dart';

class UpdatePhoneScreen extends StatelessWidget {
  UpdatePhoneController updatePhoneController = UpdatePhoneController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppBar().preferredSize.height,
                  ),
                  const Text(
                    'Cập nhật thông tin',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    controller: updatePhoneController.phoneEdit,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      if (value!.length < 10) {
                        return 'Số điện thoại không hợp lệ';
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
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
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
                  if (formKey.currentState!.validate()) {
                    updatePhoneController.updatePhoneProfile();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
