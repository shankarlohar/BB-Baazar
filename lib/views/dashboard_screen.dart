import 'package:bb_baazar/views/auth/seller_login_screen.dart';
import 'package:bb_baazar/views/dashboard_screen/balance_screen.dart';
import 'package:bb_baazar/views/dashboard_screen/edit_profile_screen.dart';
import 'package:bb_baazar/views/dashboard_screen/manage_product_screen.dart';
import 'package:bb_baazar/views/dashboard_screen/seller_order_screen.dart';
import 'package:bb_baazar/views/dashboard_screen/seller_store_screen.dart';
import 'package:bb_baazar/views/dashboard_screen/statics_screen.dart';
import 'package:bb_baazar/views/minor_screens/visit_store_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // const DashboardScreen({Key? key}) : super(key: key);
  List<String> title = [
    "My Store",
    "Orders",
    "Edit Profile",
    "Manage Products",
    "Balance",
    "Statistics",
  ];
  List<Widget> pages = [
    VisitStoreScreen(
      sellerUid: FirebaseAuth.instance.currentUser!.uid,
    ),
    SellerOrderScreen(),
    EditProfileScreen(),
    ManageProductScreen(),
    BalanceScreen(),
    StaticsScreen(),
  ];
  List<IconData> icon = [
    Icons.store,
    Icons.shop_2_outlined,
    Icons.edit,
    Icons.settings,
    Icons.attach_money,
    Icons.show_chart,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SellerLoginScreen();
              }));
            },
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 30,
          crossAxisSpacing: 30,
          children: List.generate(
            6,
            (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => pages[index]));
                },
                child: Card(
                  elevation: 0,
                  color: Colors.blueGrey.withOpacity(0.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        icon[index],
                        size: 50,
                        color: Colors.red,
                      ),
                      Text(
                        title[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
