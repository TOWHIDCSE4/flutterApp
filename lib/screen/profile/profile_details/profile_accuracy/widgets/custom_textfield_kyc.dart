import 'package:flutter/material.dart';
import 'package:gohomy/const/color.dart';

class CustomTextFieldKYC extends StatelessWidget {
  const CustomTextFieldKYC({
    super.key,
    this.textEditingController,
    required this.title,
    required this.hintText,
    required this.enabled,
    this.onSubmitted,
    required this.onChanged,
  });
  final TextEditingController? textEditingController;
  final String title;
  final String hintText;
  final bool enabled;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
        title,
        style: const TextStyle(
          color: AppColor.textColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
        Expanded(
          child: SizedBox(
            // width: 150,
            height: 30,
            child: TextField(
              controller: textEditingController,
              autofocus: true,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColor.dark2,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: AppColor.dark2,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              enabled: enabled,
              onSubmitted: onSubmitted,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
