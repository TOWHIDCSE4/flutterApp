import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';

class BankInfoCardTile extends StatelessWidget {
  const BankInfoCardTile({
    super.key,
    this.imgPath,
    this.bankName,
    this.bankFullName,
    this.accountNumber,
    this.accountHolder,
    this.onTapBank,
    this.onTapEdit,
  });

  final String? imgPath;
  final String? bankName;
  final String? bankFullName;
  final String? accountNumber;
  final String? accountHolder;
  final VoidCallback? onTapBank;
  final VoidCallback? onTapEdit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: onTapBank,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(imgPath!),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bankName ?? "",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: AppColor.dark1,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          bankFullName ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColor.grey,
                            overflow: TextOverflow.ellipsis,

                          ),
                        ),
                        Text(
                          accountNumber ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          accountHolder ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onTapEdit,
                  icon: SvgPicture.asset(ImageAssets.editIcon),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
