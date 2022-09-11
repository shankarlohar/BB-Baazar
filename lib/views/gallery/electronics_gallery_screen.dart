import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../widget/product_model.dart';

class ElectronicsGalleryScreen extends StatefulWidget {
  // const ElectronicsGalleryScreen({ Key? key }) : super(key: key);

  @override
  _ElectronicsGalleryScreenState createState() =>
      _ElectronicsGalleryScreenState();
}

class _ElectronicsGalleryScreenState extends State<ElectronicsGalleryScreen> {
  final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
      .collection('products')
      .where("mainCategory", isEqualTo: "Electronics")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              "This category\n\nhas no items to display ye",
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
    );
  }
}
