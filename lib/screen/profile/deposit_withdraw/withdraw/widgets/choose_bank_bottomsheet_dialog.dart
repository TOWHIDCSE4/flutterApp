import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/withdraw/manage_account_page.dart';

import 'choose_bank_tile.dart';
import '../withdraw_controller.dart';

class ChooseBankBottomSheetDialog extends StatefulWidget {
  const ChooseBankBottomSheetDialog({
    super.key,
  });

  @override
  State<ChooseBankBottomSheetDialog> createState() => _ChooseBankBottomSheetDialogState();
}

class _ChooseBankBottomSheetDialogState extends State<ChooseBankBottomSheetDialog> {
  WithdrawController withdrawController = Get.find<WithdrawController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Container(
                height: 4,
                width: 60,
                decoration: BoxDecoration(
                  color: AppColor.dark0,
                  borderRadius: BorderRadius.circular(112),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  'Chọn tài khoản liên kết',
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChooseBankTile(
                    imageUrl: ImageAssets.icBank1,
                    title: 'Vietcombank',
                    subTitle: 'Ngân hàng TMCP Ngoại thương Việt Nam',
                    onTap: () {
                      // withdrawController.bankCode.text = withdrawController.listBank[index].bankCode ?? "";
                      withdrawController.bankCode.text = "VCB";
                      Get.to(() => ManageAccountPage());
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
