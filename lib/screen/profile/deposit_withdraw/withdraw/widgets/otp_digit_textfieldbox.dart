import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gohomy/const/color.dart';

class OTPDigitTextFieldBox extends StatelessWidget {
  const OTPDigitTextFieldBox({
    super.key,
    required this.first,
    required this.last,
    required this.forward,
    required this.backward,
  });

  final bool first;
  final bool last;
  final Function(String) forward;
  final Function(String) backward;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
              log('Forward: $value');
              forward(value);
            }
            if (!first && last) {
              log('Forward: $value');
              forward(value);
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
              log('Backward: $value');
              backward(value);
            }
            // if (first && !last) {
            //   log('Backward: $value');
            //   backward(value);
            // }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
          ],
          maxLength: 1,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.all(0),
            counter: const Offstage(),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(
                width: 3.5,
                color: AppColor.light3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(
                width: 3.5,
                color: AppColor.light3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "",
          ),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
