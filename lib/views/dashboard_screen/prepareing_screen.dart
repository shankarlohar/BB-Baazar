import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrepareingScreen extends StatefulWidget {
  @override
  _PrepareingScreenState createState() => _PrepareingScreenState();
}

class _PrepareingScreenState extends State<PrepareingScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('deliveryStatus', isEqualTo: "Prepareing to dispatch")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Material(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          );
        }

        return Scaffold(
          body: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var order = snapshot.data!.docs[index];
              return ExpansionTile(
                title: Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        order['orderImage'],
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order['orderName'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '₹' + order['orderPrice'].toStringAsFixed(2),
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  "X ${order['orderQuantity'].toString()}",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "See More...",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      order['deliveryStatus'],
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name : ${order['customerName']}",
                          ),
                          Text(
                            "Email Address : ${order['email']}",
                          ),
                          Text(
                            "Phone Number : ${order['phone']}",
                          ),
                          Text(
                            "Address : ${order['address']}",
                          ),
                          Text(
                            "Payment Status : ${order['paymentStatus']}",
                          ),
                          Text(
                            "Delivery Status : ${order['deliveryStatus']}",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            "Estimated Delhivery Date : ${order['delhiveryDate']}",
                          ),
                          order['deliveryStatus'] == 'delivered' &&
                                  order['orderReview'] == false
                              ? TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Write Review",
                                    style: TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                )
                              : Text(
                                  '',
                                ),
                          order['deliveryStatus'] == 'delivered' &&
                                  order['orderReview'] == true
                              ? Row(
                                  children: [
                                    Text(
                                      "Review Added",
                                    ),
                                    Icon(
                                      FontAwesomeIcons.check,
                                      color: Colors.green,
                                    ),
                                  ],
                                )
                              : Text(
                                  '',
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
