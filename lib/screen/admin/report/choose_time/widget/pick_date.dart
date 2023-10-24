import 'package:flutter/material.dart';

import '../../../../../utils/date_utils.dart';

class PickDate extends StatelessWidget {
  final String? text;
  final DateTime? fromDate;
  final DateTime? toDay;
  final bool? isChoose;
  final Function? onReturn;

  const PickDate(
      {this.text,
      this.fromDate,
      this.toDay,
      this.isChoose = false,
      this.onReturn});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        InkWell(
          onTap: () {
            onReturn!(fromDate, toDay);
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$text",
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(fromDate!.isAtSameMomentAs(toDay!)
                        ? SahaDateUtils().getDDMMYY(fromDate!)
                        : "${SahaDateUtils().getDDMMYY(fromDate!)} đến ${SahaDateUtils().getDDMMYY(toDay!)}"),
                  ],
                ),
                const Spacer(),
                isChoose!
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }
}
