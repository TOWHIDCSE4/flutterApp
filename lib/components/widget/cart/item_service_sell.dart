import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gohomy/model/cart_item.dart';
import 'package:gohomy/model/service_sell.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../../empty/saha_empty_image.dart';

class ItemServiceSellInCartWidget extends StatelessWidget {
  final CartItem? cartItem;
  final int? quantity;
  final Function? onDismissed;
  final Function? onDecreaseItem;
  final Function? onIncreaseItem;
  final Function? onRemoveItem;
  final Function(int quantity, ServiceSell serviceSell)? onUpdateServiceSell;

  ItemServiceSellInCartWidget(
      {Key? key,
      required this.cartItem,
      this.onDismissed,
      this.onDecreaseItem,
      this.onIncreaseItem,
      this.quantity,
      this.onRemoveItem,
      this.onUpdateServiceSell})
      : super(key: key);

  bool canDecrease = true;
  bool canIncrease = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          onDismissed!();
        },
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE6E6),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: const [
              Spacer(),
              Icon(
                Icons.delete,
                color: Colors.red,
              )
            ],
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 88,
                  height: 88,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: (cartItem?.serviceSell?.images ?? []).isEmpty
                        ? const Icon(
                            Icons.image,
                            color: Colors.grey,
                          )
                        : CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: cartItem!.serviceSell!.images![0],
                            errorWidget: (context, url, error) =>
                                const SahaEmptyImage(),
                          ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                             
                              cartItem?.serviceSell?.name ?? "Không tên",
                              style:
                                  const TextStyle(color: Colors.black, fontSize: 14),
                              maxLines: 2,
                            ),
                            Text(
                              "${SahaStringUtils().convertToMoney(cartItem?.itemPrice ?? 0)} VNĐ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14),
                              maxLines: 2,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      IconButton(onPressed: (){
                        onRemoveItem!();
                      }, icon: Icon(FontAwesomeIcons.trashCan,color: Theme.of(context).primaryColor,))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Số lượng',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        onDecreaseItem!();
                      },
                      child: Container(
                        height: 25,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 13,
                          color: canDecrease ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // ModalBottomOptionBuyProduct.showModelOption(
                        //     product: lineItem.product!,
                        //     lineItemId: lineItem.id,
                        //     distributesSelectedParam:
                        //     lineItem.distributesSelected,
                        //     quantity: lineItem.quantity,
                        //     onSubmit: (int quantity,
                        //         Product product,
                        //         List<DistributesSelected>
                        //         distributesSelected) {
                        //       onUpdateProduct!(
                        //           quantity, distributesSelected);
                        //       Get.back();
                        //     });
                      },
                      child: Container(
                        height: 25,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Center(
                          child: Text(
                            '$quantity',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        onIncreaseItem!();
                      },
                      child: Container(
                        height: 25,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 13,
                          color: canIncrease ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
