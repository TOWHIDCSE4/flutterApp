import 'package:flutter/material.dart';

class Paginator extends StatelessWidget {
  const Paginator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Trang', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 20),
          Container(
            width: 30,
            height: 30,
            clipBehavior: Clip.antiAlias,
            decoration: const ShapeDecoration(
              color: Color(0xFFE4E4E4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
              ),
            ),
            child: const Icon(Icons.arrow_left),
          ),
          Container(
            height: 30,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFFE4E4E4)),
              ),
            ),
            child: Row(
              children: const [
                SizedBox(width: 15),
                Text(
                  '01',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    height: 1.57,
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
          Container(
            width: 30,
            height: 30,
            clipBehavior: Clip.antiAlias,
            decoration: const ShapeDecoration(
              color: Color(0xFFE4E4E4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            ),
            child: const Icon(Icons.arrow_right),
          ),
          const SizedBox(width: 20),
          const Text('--  200', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
