import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SahaLoadingiOSFullScreen extends StatelessWidget {
  String? title;
  SahaLoadingiOSFullScreen({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.black26,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const CupertinoActivityIndicator(),
          ),
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(title!, textAlign: TextAlign.center,style: const TextStyle(color: Colors.white),),
            ),
        ],
      ),
    );
  }
}
