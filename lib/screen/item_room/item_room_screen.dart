import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemRoomScreen extends StatelessWidget {
  const ItemRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      width: Get.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            room(
              name: "Chỉ còn 1 phòng Studio ngay sau ĐH Thăng Long",
              image:
                  "https://images.pexels.com/photos/2631746/pexels-photo-2631746.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              location: "28 Thanh Nhàn, Quỳnh Lôi, Hoàng Mai",
              cost: "3.000.000",
              promotional_price: "2.500.000",
            ),
            room(
              name: "Chỉ còn 1 phòng Studio ngay sau ĐH Thăng Long",
              image:
                  "https://images.pexels.com/photos/2631746/pexels-photo-2631746.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              location: "28 Thanh Nhàn, Quỳnh Lôi, Hoàng Mai",
              cost: "3.000.000",
              promotional_price: "2.500.000",
            ),
            room(
              name: "Chỉ còn 1 phòng Studio ngay sau ĐH Thăng Long",
              image:
                  "https://images.pexels.com/photos/2631746/pexels-photo-2631746.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              location: "28 Thanh Nhàn, Quỳnh Lôi, Hoàng Mai",
              cost: "3.000.000",
              promotional_price: "2.500.000",
            ),
            room(
              name: "Chỉ còn 1 phòng Studio ngay sau ĐH Thăng Long",
              image:
                  "https://images.pexels.com/photos/2631746/pexels-photo-2631746.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              location: "28 Thanh Nhàn, Quỳnh Lôi, Hoàng Mai",
              cost: "3.000.000",
              promotional_price: "2.500.000",
            ),
          ],
        ),
      ),
    );
  }

  Widget room({
    required String image,
    required String cost,
    required String promotional_price,
    required String name,
    required String location,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
      ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: Get.width / 1.5,
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                image,
                fit: BoxFit.fill,
                width: Get.width,
                height: 150,
              ),
              Positioned.fill(
                bottom: 10,
                left: 10,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Text(
                        "$promotional_priceđ",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 10,
                        ),
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF49652),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "$costđ/tháng",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Column(
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Icon(
                      Icons.verified_user_outlined,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Địa chỉ: $location",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
