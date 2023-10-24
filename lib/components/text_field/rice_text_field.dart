import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RiceTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? suffixText;
  final Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool? readOnly;
  final TextAlign? textAlign;

  RiceTextField(
      {this.controller,
      this.hintText,
      this.suffixText,
      this.validator,
      this.inputFormatters,
      this.onChanged,
      this.onSubmitted,
      this.textInputType,
      this.enabled,
      this.readOnly,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      readOnly: readOnly ?? false,
      enabled: enabled,
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        hintText: hintText,
        suffixText: suffixText,
      ),
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      validator: validator as String? Function(String?)?,
      controller: controller,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      maxLines: null,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
