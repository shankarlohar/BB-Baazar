import 'package:bb_baazar/views/home_screen.dart';
import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatefulWidget {
  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  // const CustomerHomeScreen({Key? key}) : super(key: key);
  int selectedItem = 0;

  final List<Widget> pages = [
    HomeScreen(),
    Center(
      child: Text("Category Screen"),
    ),
    Center(
      child: Text("Shop Screen"),
    ),
    Center(
      child: Text("Cart Screen"),
    ),
    Center(
      child: Text("Profile Screen"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
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
