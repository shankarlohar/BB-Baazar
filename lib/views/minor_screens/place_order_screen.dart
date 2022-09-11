import 'package:bb_baazar/provider/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceOrderScreen extends StatelessWidget {
// const PlaceOrderScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference customer =
        FirebaseFirestore.instance.collection('customers');

    return FutureBuilder(
        future: customer.doc(auth.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong.");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist.");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.grey.shade200,
                appBar: AppBar(
                  title: Text(
                    "BB Bazaar Checkout Portal",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.grey.shade200,
                  elevation: 0,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name : ${data['fullName']}",
                              ),
                              Text(
                                "Address : ${data['address']}",
                              ),
                              Text(
                                "Phone : ${data['phone']}",
                              ),
                              Text(
                                "Total Checkout Value : ₹" +
                                    context
                                        .watch<CartProvider>()
                                        .totalPrice
                                        .toStringAsFixed(2),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Total Items : " +
                                    context
                                        .watch<CartProvider>()
                                        .count
                                        .toString(),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Consumer<CartProvider>(
                              builder: (context, cartProvider, child) {
                            return ListView.builder(
                              itemCount: cartProvider.count,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.3,
                                      ),
                                      color: Colors.red.shade100,
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Image.network(
                                              cartProvider
                                                  .getItems[index].imagesUrl[0],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cartProvider
                                                    .getItems[index].name,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '₹' +
                                                        cartProvider
                                                            .getItems[index]
                                                            .price
                                                            .toStringAsFixed(2),
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      letterSpacing: 1.9,
                                                    ),
                                                  ),
                                                  Text(
                                                    '    X' +
                                                        cartProvider
                                                            .getItems[index]
                                                            .quantity
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      letterSpacing: 1.9,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomSheet: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Material(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          );
        });
  }
}
