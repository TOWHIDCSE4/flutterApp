import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/button/saha_button.dart';
import 'choose_type_user_controller.dart';

class ChooseTypeUserScreen extends StatelessWidget {
  ChooseTypeUserController chooseTypeUserController =
      ChooseTypeUserController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
        body: SingleChildScrollView(
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
                  'Bạn là ?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () {
                    chooseTypeUserController.isHost.value = false;
                  },
                  child: Obx(
                    () => Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: chooseTypeUserController.isHost.value == false
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.group,
                            color:
                                chooseTypeUserController.isHost.value == false
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Khách hàng muốn tìm trọ',
                            style: TextStyle(
                              color:
                                  chooseTypeUserController.isHost.value == false
                                      ? Colors.white
                                      : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    chooseTypeUserController.isHost.value = true;
                  },
                  child: Obx(
                    () => Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: chooseTypeUserController.isHost.value == true
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: chooseTypeUserController.isHost.value == true
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Chủ nhà muốn cho thuê',
                            style: TextStyle(
                              color:
                                  chooseTypeUserController.isHost.value == true
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
                  chooseTypeUserController.updateHost();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
