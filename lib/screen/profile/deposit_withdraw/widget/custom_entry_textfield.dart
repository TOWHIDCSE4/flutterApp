import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/widget/tranaction_type.dart';

class CustomEntryTextField extends StatelessWidget {
  const CustomEntryTextField({
    super.key,
    required this.controller,
    this.isTyping = false,
    this.hintText = 'Tối thiểu 50.000',
    this.transactionType = TransactionType.deposit,
    this.onChanged,
    this.onRemove
  });

  final TextEditingController controller;
  final bool isTyping;
  final String hintText;
  final TransactionType transactionType;
  final Function(String)? onChanged;
  final Function? onRemove;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
      ],
      textAlign: isTyping ? TextAlign.start : TextAlign.center,
      style: const TextStyle(
        color: AppColor.primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(
                  Icons.highlight_remove,
                  color: Theme.of(Get.context!).primaryColor,
                ),
                onPressed: () {
                  onRemove!();
                },
              )
            : null,
        enabledBorder: transactionType == TransactionType.deposit
            ? const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.dark5),
              )
            : const UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColor.light3)),
        focusedBorder: transactionType == TransactionType.deposit
            ? const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.dark5,
                ),
              )
            : const UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColor.light3)),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColor.dark5,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
