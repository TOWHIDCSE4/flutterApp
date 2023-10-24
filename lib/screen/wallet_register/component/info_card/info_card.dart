import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../const/color.dart';


class InfoCard extends StatelessWidget {
  final String headTitle;
  final String headSubtitle;
  final List<Widget> rows;  ///Added later
  const InfoCard({
    Key? key,
    required this.headTitle,
    required this.headSubtitle,
    required this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(headTitle,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              GestureDetector(
                onTap: 
                  (){}
                ,
                child: Text(headSubtitle,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blue)),
              ),
            ],
          ),
          ...rows
        ],
      ),
    );
  }
}
