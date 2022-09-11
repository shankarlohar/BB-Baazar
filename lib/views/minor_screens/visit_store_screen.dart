import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../widget/product_model.dart';

class VisitStoreScreen extends StatelessWidget {
  final sellerUid;

  const VisitStoreScreen({super.key, required this.sellerUid});
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
        .collection('products')
        .where("sellerUid", isEqualTo: sellerUid)
        .snapshots();
    CollectionReference seller =
        FirebaseFirestore.instance.collection('Sellers');

    return FutureBuilder<DocumentSnapshot>(
      future: seller.doc(sellerUid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              toolbarHeight: 100,
              title: Text(
                data['storeName'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 6,
                ),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: productStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "This Store\n\nhas no items to display yet",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  crossAxisCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductModel(
                      products: snapshot.data!.docs[index],
                    );
                  },
                  staggeredTileBuilder: (context) => StaggeredTile.fit(1),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {},
              child: Icon(
                FontAwesomeIcons.whatsapp,
              ),
            ),
          );
        }

        return Material(
            child: Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        ));
      },
    );
  }
}
