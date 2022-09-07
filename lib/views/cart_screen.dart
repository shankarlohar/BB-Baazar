import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Cart",
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete_forever,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Cart is Empty!",
              style: TextStyle(
                fontSize: 30,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Material(
              color: Colors.red,
              borderRadius: BorderRadius.circular(
                15,
              ),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width * 0.6,
                onPressed: () {},
                child: Text(
                  "Continue Shopping",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: \$",
              style: TextStyle(
                fontSize: 17,
                letterSpacing: 3,
              ),
            ),
            Text(
              "0.00",
              style: TextStyle(
                color: Colors.red,
                fontSize: 17,
                letterSpacing: 4,
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(
                  25,
                ),
              ),
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  "Check Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
