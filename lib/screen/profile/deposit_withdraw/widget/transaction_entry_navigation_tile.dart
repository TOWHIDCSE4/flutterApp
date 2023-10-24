import 'package:flutter/material.dart';
import 'package:gohomy/const/image_assets.dart';

class TransactionEntryNavigationTile extends StatelessWidget {
  const TransactionEntryNavigationTile({
    super.key,
    required this.onTapDeposit,
    required this.onTapWithdraw,
  });

  final VoidCallback onTapDeposit;
  final VoidCallback onTapWithdraw;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: onTapDeposit,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImageAssets.imgDeposit),
                const Text('Nạp tiền')
              ],
            ),
          ),
          GestureDetector(
            onTap: onTapWithdraw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImageAssets.imgWithdraw),
                const Text('Rút tiền')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
