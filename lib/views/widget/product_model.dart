import 'package:bb_baazar/views/detail/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductModel extends StatelessWidget {
  final dynamic products;

  const ProductModel({
    required this.products,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(
            productList: products,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: 250,
                  ),
                  child: Image.network(products['productImages'][0]),
                ),
              ),
              Text(
                products['productName'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      products['price'].toString(),
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
