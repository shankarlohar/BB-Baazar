import 'package:bb_baazar/views/dashboard_screen/delivered_screen.dart';
import 'package:bb_baazar/views/dashboard_screen/prepareing_screen.dart';
import 'package:bb_baazar/views/dashboard_screen/shipping_screen.dart';
import 'package:flutter/material.dart';

class SellerOrderScreen extends StatelessWidget {
  const SellerOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Seller Order Screen",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(
              child: Text(
                "Prepareing",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            Tab(
              child: Text(
                "Shipping",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            Tab(
              child: Text(
                "Delivered",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            PrepareingScreen(),
            ShippingScreen(),
            DeliveredScreen(),
          ],
        ),
      ),
    );
  }
}
