import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SahaTextFieldNoBorder extends StatefulWidget {
  final String labelText;
  final bool withAsterisk;
  final String? suffix;
  final Icon? icon;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;
  final Function(String?)? validator;
  final bool? obscureText;
  final Function? onSuggest;
  final Function? onTap;
  final bool enabled;
  final TextInputType? textInputType;
  final String? hintText;
  final String? helperText;
  final String? suffixText;
  final int? maxLength;
  final int? maxLine;
  final bool? readOnly;
  final TextStyle? hintStyle;

  const SahaTextFieldNoBorder({
    Key? key,
    required this.labelText,
    this.withAsterisk = false,
    this.suffix,
    this.icon,
    this.inputFormatters,
    this.controller,
    this.onChanged,
    this.onSuggest,
    this.onTap,
    this.enabled = true,
    this.onSubmitted,
    this.validator,
    this.obscureText,
    this.helperText,
    this.textInputType,
    this.hintText,
    this.suffixText,
    this.maxLength,
    this.maxLine,
    this.hintStyle,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _SahaTextFieldNoBorderState createState() => _SahaTextFieldNoBorderState();
}

class _SahaTextFieldNoBorderState extends State<SahaTextFieldNoBorder> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
        child: TextFormField(
          onTap: widget.onTap as Void? Function()?,
          readOnly: widget.readOnly ??false,
          enabled: widget.enabled,
          autofocus: false,
          validator: widget.validator as String? Function(String?)?,
          keyboardType: widget.textInputType,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          controller: widget.controller,
          maxLength: widget.maxLength,
          maxLines: widget.maxLine,
          //textCapitalization: TextCapitalization.sentences,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(top: 15, bottom: 3),
            helperText: widget.helperText,
            border: InputBorder.none,
            suffixText: widget.suffixText,
            suffixStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            helperStyle: const TextStyle(fontSize: 11),
            hintText: widget.hintText,
            hintStyle:  widget.hintStyle,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 14, top: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: ' ${widget.labelText}',
                        style: const TextStyle(
                            color: Colors.black,
                            backgroundColor: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12)),
                    TextSpan(
                      text: widget.withAsterisk ? '* ' : ' ',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        backgroundColor: Colors.white,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.onSuggest != null)
              InkWell(
                onTap: () {
                  widget.onSuggest!();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: const [
                    Icon(
                      Icons.circle,
                      color: Colors.blue,
                      size: 20,
                    ),
                    Text(
                      'i',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    ]);
  }
}
