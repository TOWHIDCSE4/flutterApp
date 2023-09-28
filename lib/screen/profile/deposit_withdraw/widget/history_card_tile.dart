import 'package:flutter/material.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';

class HistoryCardTile extends StatelessWidget {
  const HistoryCardTile({
    super.key,
    required this.amount,
    this.amountColor = AppColor.green,
    this.amountIcon,
    required this.from,
    required this.content,
    this.subContent = '',
    this.subContentColor = AppColor.dark0,
    required this.dateTime,
  });

  final String amount;
  final Color amountColor;
  final String? amountIcon;
  final String from;
  final String content;
  final String subContent;
  final Color subContentColor;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.dark5.withOpacity(0.5),
            blurRadius: 10.0,
            spreadRadius: 2,
          ),
        ],
      ),
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: amountColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Image.asset(
                    amountIcon ?? ImageAssets.goldCoin,
                    height: 12,
                    width: 12,
                  ),
                ],
              ),
              Text(
                from,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: content,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.grey,
                        ),
                      ),
                      TextSpan(
                        text: subContent,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: subContentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                dateTime,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
