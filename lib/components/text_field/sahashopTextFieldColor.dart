import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SahaTextFieldColor extends StatefulWidget {
  final String labelText;
  final bool withAsterisk;
  final String? suffixText;
  final Widget? suffix;
  final Icon? icon;
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;
  final Function(String?)? validator;
  final TextCapitalization? textCapitalization;
  final bool? obscureText;
  final bool? autoFocus;
  final TextInputType? textInputType;
  final String? hintText;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final bool? enabled;

  const SahaTextFieldColor(
      {Key? key,
      required this.labelText,
      this.withAsterisk = false,
      this.suffix,
      this.suffixText,
      this.icon,
      this.controller,
      this.onChanged,
      this.onSubmitted,
      this.validator,
      this.obscureText = false,
      this.textInputType,
      this.hintText,
      this.maxLength,
      this.maxLines,
      this.autoFocus = false,
      this.textCapitalization,
      this.inputFormatters,
      this.readOnly,
      this.enabled})
      : super(key: key);

  @override
  _SahaTextFieldColorState createState() => _SahaTextFieldColorState();
}

class _SahaTextFieldColorState extends State<SahaTextFieldColor> {
  var _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: widget.labelText,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
            TextSpan(
                text: widget.withAsterisk ? '* ' : ' ',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    color: Colors.red)),
          ],
        ),
      ),
      TextFormField(
        enabled: widget.enabled ?? true,
        readOnly: widget.readOnly ?? false,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator as String? Function(String?)?,
        keyboardType: widget.textInputType,
        onChanged: widget.onChanged,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        onFieldSubmitted: widget.onSubmitted,
        obscureText: widget.obscureText == false ? false : !_passwordVisible,
        controller: widget.controller,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        autofocus: widget.autoFocus!,
        decoration: InputDecoration(
            suffixIcon: widget.obscureText == true
                ? IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: widget.hintText,
            suffix: widget.suffix),
      ),
      Container(
        height: 1,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
      )
    ]);
  }
}
