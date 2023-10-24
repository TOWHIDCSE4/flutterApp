import 'package:flutter/material.dart';
import 'package:gohomy/components/text_field/sahashopTextField.dart';
import 'package:gohomy/screen/find_room/room_information/report_violation_post/report_violation_post_controller.dart';

import '../../../../components/button/saha_button.dart';
import '../../../../components/text_field/text_field_no_border.dart';

class ReportPostSCreen extends StatefulWidget {
  ReportPostSCreen({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  State<ReportPostSCreen> createState() => _ReportPostSCreenState();
}

class _ReportPostSCreenState extends State<ReportPostSCreen> {
  ReportViolationPostController reportViolationPostController =
      ReportViolationPostController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Báo cáo vi phạm'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              SahaTextField(
                withAsterisk: true,
                validator: (value) {
                  if ((value ??'').isEmpty) {
                    return 'Không được để trống';
                  }
                  return null;
                },
                labelText: 'Lý do',
                hintText: "Nhập lý do",
                controller: reportViolationPostController.reasonController,
                onChanged: (v) {
                  reportViolationPostController
                      .reportPostViolation.value.reason = v;
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
                    if ((value ??'').isEmpty) {
                      return 'Không được để trống';
                    }
                    return null;
                  },
                  enabled: true,
                  controller:
                      reportViolationPostController.descriptionController,
                  onChanged: (v) {
                    reportViolationPostController
                        .reportPostViolation.value.description = v;
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
                    reportViolationPostController
                        .reportPostViolation.value.moPostId = widget.id;
                    reportViolationPostController.addReportPostViolation();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
