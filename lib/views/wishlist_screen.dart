import 'package:bb_baazar/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Wishlist",
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<WishlistProvider>().clearWishlist();
            },
            icon: Icon(
              Icons.delete_forever,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: context.watch<WishlistProvider>().getWishItems.isNotEmpty
          ? Consumer<WishlistProvider>(
              builder: (context, wishlistProvider, child) {
                return ListView.builder(
                    itemCount: wishlistProvider.count,
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
                                  wishlistProvider
                                      .getWishItems[index].imagesUrl[0]
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
                                      wishlistProvider.getWishItems[index].name,
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
                                              wishlistProvider
                                                  .getWishItems[index].price
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
                                                onPressed: () {
                                                  context
                                                      .read<WishlistProvider>()
                                                      .removeWishlistItem(
                                                          wishlistProvider
                                                                  .getWishItems[
                                                              index]);
                                                },
                                                icon: Icon(FontAwesomeIcons
                                                    .deleteLeft),
                                              )
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
                    "     Your Wishlist is Empty! \n       Made With ❤ by \n         Shankar Lohar",
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
    );
  }
}
