import 'package:bb_baazar/views/cart_screen.dart';
import 'package:bb_baazar/views/category_screen.dart';
import 'package:bb_baazar/views/home_screen.dart';
import 'package:bb_baazar/views/profile_screen.dart';
import 'package:bb_baazar/views/store_screen.dart';
import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatefulWidget {
  static const String routeName = "CustomerHomeScreen";
  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  // const CustomerHomeScreen({Key? key}) : super(key: key);
  int selectedItem = 0;

  final List<Widget> pages = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    CartScreen(),
    ProfileScreen(),
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
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: pages[selectedItem],
    );
  }
}
