import 'package:bb_baazar/models/product_model.dart';
import 'package:flutter/widgets.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> list = [];

  List<Product> get getItems {
    return list;
  }

  int get count {
    return list.length;
  }

  double get totalPrice {
    var total = 0.00;
    for (var item in list) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void addItem(
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

  void increment(Product product) {
    product.increase();
    notifyListeners();
  }

  void decrement(Product product) {
    product.decrease();
    notifyListeners();
  }

  void clearCart() {
    list.clear();
    notifyListeners();
  }
}
