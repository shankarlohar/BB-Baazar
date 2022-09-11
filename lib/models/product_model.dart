class Product {
  String name, documentId, sellerUid;
  List imagesUrl;
  double price;
  int quantity, instock;

  Product({
    required this.name,
    required this.price,
    required this.quantity,
    required this.instock,
    required this.imagesUrl,
    required this.documentId,
    required this.sellerUid,
  });

  void increase() {
    quantity++;
  }

  void decrease() {
    quantity--;
  }
}
