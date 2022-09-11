import 'package:flutter/material.dart';

class SellerStoreScreen extends StatelessWidget {
  const SellerStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Seller Store Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
