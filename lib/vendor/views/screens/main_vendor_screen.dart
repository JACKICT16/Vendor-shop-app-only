import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app_only/vendor/views/screens/account_screen.dart';
import 'package:vendor_app_only/vendor/views/screens/status_screen.dart';
import 'package:vendor_app_only/vendor/views/screens/edit_screen.dart';
import 'package:vendor_app_only/vendor/views/screens/logout_screen.dart';
import 'package:vendor_app_only/vendor/views/screens/upload_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;
  List<Widget> _pages = [
    StatusScreen(),
    UploadScreen(),
    EditProductScreen(),
    AccountScreen(),
    LogoutScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue[700],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy_sharp),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.upload,
            ),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.edit,
            ),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance,
            ),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
            ),
            label: 'Logout',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
