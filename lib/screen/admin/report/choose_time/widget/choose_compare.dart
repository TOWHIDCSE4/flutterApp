import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseCompare extends StatelessWidget {
  final Function? onReturn;
  final isCompare;

  const ChooseCompare({this.onReturn, this.isCompare = false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          color: Colors.grey[300],
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const Text(
                "So sánh với",
                style: TextStyle(fontSize: 15),
              ),
              const Spacer(),
              CupertinoSwitch( value: isCompare,onChanged: (v) {
                onReturn!(v);
              },)
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          height: 4,
        ),
      ],
    );
  }
}
