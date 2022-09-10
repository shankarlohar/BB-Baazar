import 'package:bb_baazar/views/cart_screen.dart';
import 'package:bb_baazar/views/category_screen.dart';
import 'package:bb_baazar/views/dashboard_screen.dart';
import 'package:bb_baazar/views/home_screen.dart';
import 'package:bb_baazar/views/profile_screen.dart';
import 'package:bb_baazar/views/store_screen.dart';
import 'package:bb_baazar/views/upload_product_screen.dart';
import 'package:flutter/material.dart';

class SellerHomeScreen extends StatefulWidget {
  static const String routeName = "SellerHomeScreen";
  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  // const SellerHomeScreen({Key? key}) : super(key: key);
  int selectedItem = 0;

  final List<Widget> pages = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    DashboardScreen(),
    UploadProductScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.red,
        currentIndex: selectedItem,
        onTap: (index) {
          setState(() {
            selectedItem = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: "Shop",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: "Upload",
          ),
        ],
      ),
      body: pages[selectedItem],
    );
  }
}
