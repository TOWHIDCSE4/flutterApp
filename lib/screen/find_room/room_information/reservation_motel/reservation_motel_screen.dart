import 'package:flutter/material.dart';
import 'package:gohomy/components/text_field/text_field_no_border.dart';
import '../../../../components/button/saha_button.dart';
import 'reservation_motel_controller.dart';

class ReservationMotelScreen extends StatelessWidget {
  int moPostId;
  int hostId;

  ReservationMotelScreen({required this.moPostId, required this.hostId}) {
    reservationMotelController =
        ReservationMotelController(moPostId: moPostId, hostId: hostId);
  }

  final _formKey = GlobalKey<FormState>();
  late ReservationMotelController reservationMotelController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Giữ chỗ",
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                text: 'Gửi thông tin',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    reservationMotelController.addReservationMotelMotel();
                  }
                },
              ),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Vui lòng để lại thông tin đặt phòng\nchủ phòng sẽ liên hệ lại cho bạn sớm nhất có thể',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  SahaTextFieldNoBorder(
                    withAsterisk: true,
                    controller: reservationMotelController.nameEdit,
                    onChanged: (value) {
                      reservationMotelController.reservationMotel.value.name =
                          value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Họ và tên",
                    hintText: "Nhập họ và tên",
                  ),
                  const Divider(),
                  SahaTextFieldNoBorder(
                    controller: reservationMotelController.phoneEdit,
                    textInputType: TextInputType.phone,
                    onChanged: (v) {
                      reservationMotelController
                          .reservationMotel.value.phoneNumber = v;
                    },
                    validator: (value) {
                      if (value!.length != 10) {
                        return 'Số điện thoại không hợp lệ';
                      }
                      return null;
                    },
                    withAsterisk: true,
                    labelText: 'Số điện thoại',
                    hintText: "Nhập số điện thoại",
                  ),
                  const Divider(),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(1, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SahaTextFieldNoBorder(
                      enabled: true,
                      controller: reservationMotelController.noteEdit,
                      onChanged: (v) {
                        reservationMotelController.reservationMotel.value.note =
                            v;
                      },
                      textInputType: TextInputType.multiline,
                      maxLine: 5,
                      labelText: "Ghi chú",
                      hintText: "Nhập ghi chú",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
