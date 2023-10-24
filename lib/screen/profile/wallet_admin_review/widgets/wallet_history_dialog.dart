import 'package:flutter/material.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

class WalletHistoryDialog extends StatelessWidget {
  const WalletHistoryDialog({
    super.key,
    this.transactionId,
    required this.amountStr,
    required this.recipientAccount,
    required this.nameOfBank,
    required this.accountNumber,
    required this.content,
    required this.creationTime,
    required this.paymentTime,
    this.completed = false,
  });

  final bool completed;
  final String amountStr;
  final String recipientAccount;
  final String nameOfBank;
  final String accountNumber;
  final String content;
  final String creationTime;
  final String paymentTime;
  final int? transactionId;

  Future<void> confirmPayment() async {
    try {
      var res = await RepositoryManager.adminManageRepository.confirmPaymentStatus(transactionId);
      if(res != null) {
        SahaAlert.showSuccess(message: 'Thành công');
      }
    } catch(err) {
      SahaAlert.showError(message: err.toString());
    }

  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'Thông tin rút tiền',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 20, top: 10),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            if(!completed) {
              confirmPayment();
            }
            Navigator.pop(context);
          },
          child: Text(
            completed ? 'Đóng' : 'Thanh toán',
            textScaleFactor: 1.25,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                amountStr,
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
                style: const TextStyle(
                  color: Color(0xFFF73131),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContentText(title: 'Tài khoản nhận', content: accountNumber),
                if (!completed) CopyButton(onPressed: () {})
              ],
            ),
            if (completed) const SizedBox(height: 15),
            if (nameOfBank.isNotEmpty) ...[
              ContentText(title: 'Ngân hàng', content: nameOfBank),
              const SizedBox(height: 15),
            ],
            ContentText(title: 'Chủ tài khoản', content: recipientAccount),
            if (completed) const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContentText(title: 'ND', content: content),
                if (!completed) CopyButton(onPressed: () {})
              ],
            ),
            if (completed) const SizedBox(height: 15),
            ContentText(title: 'Thời gian tạo lệnh rút', content: creationTime),
            if (completed) ...[
              const SizedBox(height: 15),
              ContentText(title: 'Thời gian thanh toán', content: paymentTime),
            ],
          ],
        ),
      ),
    );
  }
}

class CopyButton extends StatelessWidget {
  const CopyButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFEFF3F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      icon: const Icon(
        Icons.copy,
        size: 17.5,
        color: Color(0xFF8B999E),
      ),
      label: const Text(
        'Sao chép',
        textScaleFactor: 1,
        style: TextStyle(
          color: Color(0xFF8B999E),
          fontFamily: 'SF Pro',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ContentText extends StatelessWidget {
  const ContentText({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Text.rich(
        textAlign: TextAlign.start,
        // overflow: TextOverflow.ellipsis,
        TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: const TextStyle(
                color: Color(0xFF3F3F3F),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: content,
              style: const TextStyle(
                color: Color(0xFF3F3F3F),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}