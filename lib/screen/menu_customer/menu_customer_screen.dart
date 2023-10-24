import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../owner/customer_home_screen.dart';


class MenuCustomerScreen extends StatefulWidget {
  const MenuCustomerScreen({Key? key}) : super(key: key);

  @override
  State<MenuCustomerScreen> createState() => _MenuCustomerScreenState();
}

class _MenuCustomerScreenState extends State<MenuCustomerScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const CustomerHomeScreen(),
    Container(),
    Container(),
    Container(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF49652),
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        selectedLabelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.houseChimney,
            ),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.message,
            ),
            label: 'Tin nhắn',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.heart),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.bell,
            ),
            label: 'THông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.ellipsis,
            ),
            label: 'Thêm',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
