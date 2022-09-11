import 'package:badges/badges.dart';
import 'package:bb_baazar/views/detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../../provider/wishlist_provider.dart';

class ProductModel extends StatefulWidget {
  final dynamic products;

  const ProductModel({
    required this.products,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(
            productList: widget.products,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
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
                      child: Image.network(widget.products['productImages'][0]),
                    ),
                  ),
                  Text(
                    widget.products['productName'],
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
                          ' ₹' + widget.products['price'].toString(),
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Provider.of<WishlistProvider>(context,
                                            listen: false)
                                        .getWishItems
                                        .firstWhereOrNull((cart) =>
                                            cart.documentId ==
                                            widget.products['productId']) !=
                                    null
                                ? context
                                    .read<WishlistProvider>()
                                    .removeWhishlist(
                                        widget.products['productId'])
                                : Provider.of<WishlistProvider>(context,
                                        listen: false)
                                    .addWishItem(
                                        widget.products['productName'],
                                        widget.products['price'],
                                        1,
                                        widget.products['productImages'],
                                        widget.products['productId'],
                                        widget.products['sellerUid'],
                                        widget.products['instock']);
                          },
                          icon: context
                                      .watch<WishlistProvider>()
                                      .getWishItems
                                      .firstWhereOrNull((wishlistItem) =>
                                          wishlistItem.documentId ==
                                          widget.products['productId']) !=
                                  null
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.red,
                                  size: 30,
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: Badge(
                toAnimate: true,
                shape: BadgeShape.square,
                badgeColor: Colors.red,
                borderRadius: BorderRadius.circular(8),
                badgeContent:
                    Text('New Arrivals', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
