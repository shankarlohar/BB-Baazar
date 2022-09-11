import 'package:bb_baazar/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
            onPressed: () {
              context.read<CartProvider>().clearCart();
            },
            icon: Icon(
              Icons.delete_forever,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: context.watch<CartProvider>().getItems.isNotEmpty
          ? Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return ListView.builder(
                    itemCount: cartProvider.count,
                    itemBuilder: (context, index) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 120,
                                child: Image.network(
                                  cartProvider.getItems[index].imagesUrl[0]
                                      .toString(),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      cartProvider.getItems[index].name,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '₹' +
                                              cartProvider.getItems[index].price
                                                  .toStringAsFixed(2),
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            color: Colors.grey.shade200,
                                          ),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: cartProvider
                                                            .getItems[index]
                                                            .quantity ==
                                                        1
                                                    ? null
                                                    : () {
                                                        cartProvider.decrement(
                                                            cartProvider
                                                                    .getItems[
                                                                index]);
                                                      },
                                                icon: Icon(
                                                  FontAwesomeIcons.minus,
                                                ),
                                              ),
                                              Text(
                                                cartProvider
                                                    .getItems[index].quantity
                                                    .toString(),
                                              ),
                                              IconButton(
                                                onPressed: cartProvider
                                                            .getItems[index]
                                                            .quantity ==
                                                        cartProvider
                                                            .getItems[index]
                                                            .instock
                                                    ? null
                                                    : () {
                                                        cartProvider.increment(
                                                            cartProvider
                                                                    .getItems[
                                                                index]);
                                                      },
                                                icon: Icon(
                                                  FontAwesomeIcons.plus,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "     Your Cart is Empty! \n       Made With ❤ by \n         Shankar Lohar",
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
              "Total: ₹",
              style: TextStyle(
                fontSize: 17,
                letterSpacing: 3,
              ),
            ),
            Text(
              context.watch<CartProvider>().totalPrice.toStringAsFixed(2),
              style: TextStyle(
                color: Colors.red,
                fontSize: 17,
                letterSpacing: 1,
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
