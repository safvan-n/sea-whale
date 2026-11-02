import 'product.dart';

class CartItem {
  final Product product;
  final String selectedWeight;
  int quantity;

  CartItem({
    required this.product,
    required this.selectedWeight,
    this.quantity = 1,
  });

  double get unitPrice => product.priceForWeight(selectedWeight);
  double get totalPrice => unitPrice * quantity;
}
