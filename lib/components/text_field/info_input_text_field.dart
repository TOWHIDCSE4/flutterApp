import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoInputTextField extends StatelessWidget {
  String? title;
  String? hintText;
  String? errorText;
  TextEditingController? textEditingController;
  TextInputType? keyboardType;
  Function? onTap;
  final Function(String?)? validator;
  Function(String)? onChanged;
  Widget? icon;

  InfoInputTextField({
    this.title,
    this.onChanged,
    this.hintText,
    this.errorText,
    this.keyboardType,
    this.textEditingController,
    this.onTap,
    this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Text(title!),
          if (title != null)
            const SizedBox(
              height: 5,
            ),
          Stack(
            children: [
              SizedBox(
                width: Get.width,
                height: 60,
                child: TextFormField(
                  autofocus: false,
                  keyboardType: keyboardType,
                  controller: textEditingController,
                  validator: validator as String? Function(String?)?,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    errorText: errorText,
                  ),
                  onChanged: onChanged,
                ),
              ),
              if (icon != null)
                Positioned(
                    bottom: 40, right: 20, height: 15, width: 15, child: icon!),
              if (onTap != null)
                InkWell(
                  onTap: onTap == null
                      ? null
                      : () {
                          onTap!();
                        },
                  child: Container(
                    width: Get.width,
                    height: 45,
                    color: Colors.transparent,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
