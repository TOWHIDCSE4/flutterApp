import 'package:flutter/material.dart';
import 'package:gohomy/screen/profile/wallet_admin_review/wallet_admin_review.dart';

class WalletHistoryCard extends StatelessWidget {
  WalletHistoryCard({
    super.key,
    required this.amountStr,
    this.bankName,
    required this.fromOrTo,
    required this.content,
    required this.dateTimeStr,
    this.isDeposit = true,
    this.completed = false,
    this.bankAccountNumber,
    this.status,
    this.transactionId
  });

  final String amountStr;
  final String? bankName;
  final String fromOrTo;
  final String content;
  final String dateTimeStr;
  final bool isDeposit;
  final bool completed;
  String? bankAccountNumber;
  String? status;
  final int? transactionId;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final amountStr_ = (isDeposit ? '+ ' : '- ') + amountStr;
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 7.5,
            offset: Offset(0, 0),
            spreadRadius: 1.75,
          )
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            onTap: isDeposit
                ? null
                : () => showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => WalletHistoryDialog(
                          transactionId: transactionId,
                          completed: completed,
                          amountStr: amountStr_,
                          recipientAccount: fromOrTo,
                          nameOfBank: bankName ?? '',
                          accountNumber: bankAccountNumber ?? "",
                          content: content,
                          creationTime: dateTimeStr,
                          paymentTime: '20:00 05/07/2023'),
                    ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  amountStr_,
                  style: TextStyle(
                    color: Color(isDeposit ? 0xFF009247 : 0xFFF73131),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                Image.asset(
                  'assets/images/gold_coin.png',
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text((isDeposit ? 'Từ: ' : 'Đến: ${bankName ?? ''} - ') +
                    fromOrTo),
                RichText(
                  text: TextSpan(
                      text: 'ND: $content',
                      style: bodyMedium?.copyWith(
                          color: bodyMedium.color?.withOpacity(.5)),
                      children: [
                        TextSpan(
                          text: isDeposit ? '  $fromOrTo' : '',
                          style: const TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ]),
                ),
                Text(dateTimeStr),
              ],
            ),
          ),
          if (!isDeposit && completed)
            const Padding(
              padding: EdgeInsets.only(top: 7.5),
              child: CompleteBadge(),
            ),
        ],
      ),
    );
  }
}