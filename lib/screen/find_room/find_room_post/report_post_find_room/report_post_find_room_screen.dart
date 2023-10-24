import 'package:flutter/material.dart';

import 'package:gohomy/components/appbar/saha_appbar.dart';
import 'package:gohomy/screen/find_room/find_room_post/report_post_find_room/report_post_find_room_controller.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../components/text_field/sahashopTextField.dart';
import '../../../../components/text_field/text_field_no_border.dart';

class ReportPostFindRoomScreen extends StatelessWidget {
  ReportPostFindRoomScreen({super.key, required this.idPostFindRoom});
  final int idPostFindRoom;
  ReportPostFindRoomController controller = ReportPostFindRoomController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Báo cáo vi phạm",
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SahaTextField(
              withAsterisk: true,
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return 'Không được để trống';
                }
                return null;
              },
              labelText: 'Lý do',
              hintText: "Nhập lý do",
              controller: controller.reasonController,
              onChanged: (v) {
                controller.report.reason = v;
              },
            ),
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
                withAsterisk: true,
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Không được để trống';
                  }
                  return null;
                },
                enabled: true,
                controller: controller.descriptionController,
                onChanged: (v) {
                  controller
                      .report.description = v;
                },
                textInputType: TextInputType.multiline,
                maxLine: 5,
                labelText: "Mô tả",
                hintText: "Nhập mô tả",
              ),
            ),
          ],
        ),
      ),
         bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(
            children: [
              SahaButtonFullParent(
                color: Theme.of(context).primaryColor,
                text: 'Báo cáo vi phạm',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller
                        .report.moPostFindMotelId = idPostFindRoom;
                    controller.reportPostFindRoom();
                  }
                },
              ),
            ],
          ),
        ),
    );
  }
}
