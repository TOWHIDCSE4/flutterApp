import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/appbar/saha_appbar.dart';

import '../../../components/widget/check_customer_login/check_customer_login_screen.dart';
import 'customer_post_find_room/customer_post_find_room_screen.dart';
import 'customer_post_roommate/customer_post_roommate_controller.dart';
import 'customer_post_roommate/customer_post_roommate_screen.dart';


class CustomerPostLockScreen extends StatelessWidget {
 

  const CustomerPostLockScreen({
    Key? key,
   
  });
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(child: CustomerPostScreen());
  }
}

class CustomerPostScreen extends StatelessWidget {
  const CustomerPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.bottomLeft,
                // end: Alignment.topRight,
                colors: <Color>[Colors.deepOrange, Colors.orange]),
          ),
        ),
        title: Text("Quản lý bài đăng"),
      ),
      body: Column(
        children: [
          item(
              assetIcon: 'assets/images/bai_dang_tim_phong.png',
              title: 'Tìm phòng',
              onTap: () {
                Get.to(() => CustomerPostFindRoomScreen());
              }),
          item(
              assetIcon: 'assets/images/tim_nguoi_o_ghep.png',
              title: 'Tìm người ở ghép',
              onTap: () {
                Get.to(() => CustomerPostRoommateScreen());
              })
        ],
      ),
    );
  }

  Widget item(
      {required String assetIcon,
      required String title,
      required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Image.asset(
              assetIcon,
              fit: BoxFit.cover,
              height: 40,
              width: 40,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Theme.of(Get.context!).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
