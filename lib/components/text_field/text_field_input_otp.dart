import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../data/repository/repository_manager.dart';
import '../../utils/user_info.dart';
import '../arlert/saha_alert.dart';

class TextFieldInputOtp extends StatefulWidget {
  final String? numberPhone;
  final String? email;
  final bool isCustomer;
  final bool isPhoneValidate;
  final bool? autoFocus;
  final Function? onSubmit;
  final Function? onChanged;
  final bool? isNotSendOtp;

  const TextFieldInputOtp(
      {Key? key,
      this.numberPhone,
      this.email,
      required this.isPhoneValidate,
      required this.isCustomer,
      this.autoFocus = false,
      this.onSubmit,
      this.onChanged,this.isNotSendOtp})
      : super(key: key);

  @override
  _TextFieldInputOtpState createState() => _TextFieldInputOtpState();
}

class _TextFieldInputOtpState extends State<TextFieldInputOtp> {
  late Timer _timer;
  int _start = 30;
  bool sent = false;

  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isNotSendOtp != true && UserInfo().getIsRelease() != false){
      sendSms();
    }else{
      print("not send not send");
    }
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _start = 30;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            child: PinCodeTextField(
              appContext: context,
              controller: textEditingController,
              pastedTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.white,
              length: 6,
              obscuringCharacter: '*',
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (v) {
                if (v!.length < 6) {
                  return "Hãy điền đủ 6 mã số";
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                inactiveColor: Theme.of(context).primaryColor,
                activeColor: Theme.of(context).primaryColor,
                activeFillColor: Colors.white,
                disabledColor: Colors.white,
                inactiveFillColor: Colors.white,
                selectedColor: Theme.of(context).primaryColor,
                selectedFillColor: Colors.white,
                fieldWidth: 40,
              ),
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              autoFocus: widget.autoFocus!,
              keyboardType: TextInputType.number,
              boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              onCompleted: (v) {
                print("Completed");
                if (widget.onSubmit != null) widget.onSubmit!(v);
              },
              onChanged: (value) {
                if (widget.onChanged != null) widget.onChanged!(value);
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                return true;
              },
            )),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text:
                  'Mã xác thực (OTP) đã được gửi tới ${widget.isPhoneValidate == false ? "Email" : "SĐT"} ',
              style: const TextStyle(
                color: Colors.grey,
              ),
              children: const <TextSpan>[],
            ),
          ),
        ),
        Center(
          child: Text(
              widget.isPhoneValidate == false
                  ? "Email: ${widget.email}"
                  : "SĐT: ${widget.numberPhone}",
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        const SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Text(
              "Bạn có thể yêu cầu mã mới ${_start > 0 ? "sau ${_start}s" : ""}",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                sent = false;
                if (_start == 0) {
                  sendSms();
                }
              },
              child: Text(
                "Gửi lại mã",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: _start == 0
                        ? Theme.of(context).primaryColor
                        : Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> sendSms() async {
    startTimer();
    try {
      if (sent == false) {
        var data = await RepositoryManager.accountRepository
            .sendOtp(numberPhone: widget.numberPhone!);
        if (data == true) {
          SahaAlert.showSuccess(message: "Đã gửi mã OTP");
        }
        sent = true;
      }
    } catch (error) {
      SahaAlert.showError(message: error.toString());
    }
  }
  //
  // Future<void> sendEmailCus() async {
  //   startTimer();
  //   try {
  //     if (sent == false) {
  //       var data = await RepositoryManager.otpRepository
  //           .sendEmailOtpCus(email: widget.email!);
  //       if (data == true) {
  //         SahaAlert.showSuccess(message: "Đã gửi mã OTP");
  //       }
  //       sent = true;
  //     }
  //   } catch (error) {
  //     SahaAlert.showError(message:error.toString());
  //   }
  // }
  //
  // Future<void> sendEmail() async {
  //   startTimer();
  //   try {
  //     if (sent == false) {
  //       var data = await RepositoryManager.otpRepository
  //           .sendEmailOtp(email: widget.email!);
  //       if (data == true) {
  //         SahaAlert.showSuccess(message: "Đã gửi mã OTP");
  //       }
  //       sent = true;
  //     }
  //   } catch (error) {
  //     SahaAlert.showError(message:error.toString());
  //   }
  // }
}
