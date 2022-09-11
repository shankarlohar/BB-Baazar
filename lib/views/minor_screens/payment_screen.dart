import 'package:bb_baazar/controllers/snack_bar_controller.dart';
import 'package:bb_baazar/provider/cart_provider.dart';
import 'package:bb_baazar/views/customer_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

class PaymentScreen extends StatefulWidget {
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
// const PaymentScreen({ Key? key }) : super(key: key);
  int selectedItem = 0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String orderId;
  void showProgress() {
    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(
      max: 100,
      msg: 'ORDER PLACING...',
      barrierColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = context.read<CartProvider>().totalPrice;
    double totalPaid = context.read<CartProvider>().totalPrice +
        context.read<CartProvider>().totalPrice * 0.18;
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
                  centerTitle: true,
                  title: Text(
                    "BB Bazaar Payment Screen",
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total :",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '₹' + totalPrice.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Paid (Inc. GST) :",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '₹' + totalPaid.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade800,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Additonal Shipping :",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '+ ₹200',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade800,
                                    ),
                                  ),
                                ],
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
                          child: Column(
                            children: [
                              RadioListTile(
                                value: 1,
                                groupValue: selectedItem,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                                title: Text("Cash on Delivery"),
                                subtitle: Text(
                                    "This option is only for selected cities"),
                              ),
                              RadioListTile(
                                value: 2,
                                groupValue: selectedItem,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                                title: Text("Pay with Debit Card"),
                                subtitle: Text(
                                    "Get additional discount of 5% on this payment"),
                              ),
                              RadioListTile(
                                value: 3,
                                groupValue: selectedItem,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                                title: Text("Pay with Credit Card"),
                                subtitle: Text(
                                    "Get free scratch coupon on this payment"),
                              ),
                              RadioListTile(
                                value: 4,
                                groupValue: selectedItem,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                                title: Text("Pay with Internet Banking"),
                                subtitle: Text(
                                    "Get free delivery on selected items on this payment"),
                              ),
                              RadioListTile(
                                value: 5,
                                groupValue: selectedItem,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                                title: Text("Pay with UPI"),
                                subtitle: Text(
                                    "Get additonal ₹100 off on this payment"),
                              ),
                            ],
                          ),
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
                          onPressed: () {
                            if (selectedItem == 1) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Payment From Anywhere",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Container(
                                            height: 35,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: MaterialButton(
                                              onPressed: () async {
                                                try {
                                                  showProgress();
                                                  for (var item in context
                                                      .read<CartProvider>()
                                                      .getItems) {
                                                    CollectionReference
                                                        orderRef =
                                                        firestore.collection(
                                                            "orders");
                                                    orderId = Uuid().v4();
                                                    await orderRef
                                                        .doc(orderId)
                                                        .set(
                                                      {
                                                        'cid': data['cid'],
                                                        'customerName':
                                                            data['fullName'],
                                                        'email': data['email'],
                                                        'address':
                                                            data['address'],
                                                        'phone': data['phone'],
                                                        'profileImage':
                                                            data['image'],
                                                        'sellerUid':
                                                            item.sellerUid,
                                                        'productId':
                                                            item.documentId,
                                                        'orderName': item.name,
                                                        'orderId': orderId,
                                                        'orderImage': item
                                                            .imagesUrl.first,
                                                        'orderQuantity':
                                                            item.quantity,
                                                        'orderPrice':
                                                            item.quantity *
                                                                item.price,
                                                        'deliveryStatus':
                                                            'Prepareing to dispatch',
                                                        'delhiveryDate': '',
                                                        'orderDate':
                                                            DateTime.now(),
                                                        'paymentStatus':
                                                            'Cash on delhivery',
                                                        'orderReview': false,
                                                      },
                                                    );
                                                  }
                                                  context
                                                      .read<CartProvider>()
                                                      .clearCart();
                                                  Navigator.of(context)
                                                      .pushNamedAndRemoveUntil(
                                                          CustomerHomeScreen
                                                              .routeName,
                                                          (route) => false);
                                                } on Exception catch (e) {
                                                  return snackBar(
                                                      e.toString(), context);
                                                }
                                              },
                                              child: Center(
                                                child: Text(
                                                  "Confirm Payment of ₹${(totalPaid + 200).toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }
                          },
                          child: Center(
                            child: Text(
                              "Pay Now ₹${(totalPaid + 200).toStringAsFixed(2)}",
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
