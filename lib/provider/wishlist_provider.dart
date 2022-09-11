import 'package:bb_baazar/models/product_model.dart';
import 'package:flutter/widgets.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Product> list = [];

  List<Product> get getWishItems {
    return list;
  }

  int get count {
    return list.length;
  }

  void addWishItem(
    String name,
    double price,
    int quantity,
    List imagesUrl,
    String documentId,
    String sellerUid,
    int instock,
  ) {
    final product = Product(
        name: name,
        price: price,
        quantity: quantity,
        instock: instock,
        imagesUrl: imagesUrl,
        documentId: documentId,
        sellerUid: sellerUid);

    list.add(product);

    notifyListeners();
  }

  void clearWishlist() {
    list.clear();
    notifyListeners();
  }

  void removeWhishlist(String id) {
    list.removeWhere((element) => element.documentId == id);
    notifyListeners();
  }

  void removeWishlistItem(Product product) {
    list.remove(product);
    notifyListeners();
  }
}
