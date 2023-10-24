import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/service_sell.dart';

import '../../../utils/string_utils.dart';
import '../../button/saha_button.dart';
import '../../empty/saha_empty_image.dart';

class ModalBottomOptionBuyProduct {
  static Future<void> showModelOption(
      {required ServiceSell serviceSell,
      String? textButton,
      int? quantity,
      Function(
        int quantity,
        ServiceSell serviceSell,
      )?
          onSubmit}) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return OptionBuyServiceSell(
          textButton: textButton,
          serviceSell: serviceSell,
          onSubmit: onSubmit,
          quantity: quantity,
        );
      },
    );
  }
}

class OptionBuyServiceSell extends StatefulWidget {
  ServiceSell serviceSell;
  String? textButton;
  int? quantity;
  Function(int quantity, ServiceSell serviceSell)? onSubmit;

  OptionBuyServiceSell(
      {Key? key,
      required this.serviceSell,
      this.onSubmit,
      this.quantity,
      this.textButton})
      : super(key: key);

  @override
  _OptionBuyServiceSellState createState() => _OptionBuyServiceSellState();
}

class _OptionBuyServiceSellState extends State<OptionBuyServiceSell> {
  int quantity = 1;

  bool isLoading = false;

  bool canDecrease = true;
  bool canIncrease = true;

  var quantityInStock;

  TextEditingController textEditingController =
      TextEditingController(text: "1");

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                          width: 110,
                          height: 110,
                          imageUrl: (widget.serviceSell.images ?? []).isEmpty
                              ? ''
                              : widget.serviceSell.images![0],
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const SahaEmptyImage()),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.serviceSell.name ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      Text(
                        "${SahaStringUtils().convertToMoney(widget.serviceSell.price ?? 0)} VNĐ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  }),
            ],
          ),
          const Divider(
            height: 1,
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Số lượng",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (quantity == 1) return;
                          quantity--;
                          textEditingController.text = "$quantity";
                          textEditingController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: textEditingController.text.length));
                        });
                      },
                      child: Container(
                        height: 25,
                        width: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!)),
                        child: Icon(
                          Icons.remove,
                          color: canDecrease ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!)),
                      child: Center(
                        child: TextField(
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          onChanged: (v) {
                            textEditingController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: textEditingController.text.length));
                            print(v);
                            quantity = int.tryParse(v) ?? 0;
                            if (quantity == 0) {
                              quantity = 1;
                              textEditingController.text = "1";
                              textEditingController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset:
                                          textEditingController.text.length));
                            }
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (canIncrease) {
                            quantity++;
                            textEditingController.text = "$quantity";
                            textEditingController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: textEditingController.text.length));
                          }
                        });
                      },
                      child: Container(
                        height: 25,
                        width: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!)),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width/1.5,
                child: SahaButtonFullParent(
                  text: "Mua ngay",
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (isLoading == false) {
                      widget.onSubmit!(quantity, widget.serviceSell);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
