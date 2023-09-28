import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/appbar/saha_appbar.dart';
import '../../../components/widget/check_customer_login/check_customer_login_screen.dart';
import 'list_post_management_screen.dart';


class HostPostLockScreen extends StatelessWidget {
 

   HostPostLockScreen({
    Key? key,
    
  });
  
  @override
  Widget build(BuildContext context) {
    return CheckCustomerLogin(child: HostPostScreen());
  }
}

class HostPostScreen extends StatelessWidget {
   HostPostScreen({super.key});
 

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
              assetIcon: 'assets/icon_host/giu-cho.png',
              title: 'Cho thuê phòng',
              onTap: () {
                Get.to(() => ListPostManagementScreen());
              }),
       
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