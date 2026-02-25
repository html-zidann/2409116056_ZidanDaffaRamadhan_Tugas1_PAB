import 'package:get/get.dart';
import '../models/product.dart';

class CartItem {
  Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(Product product) {
    int index =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      cartItems[index].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }
  }

  void increaseQty(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decreaseQty(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      cartItems.removeAt(index);
    }
    cartItems.refresh();
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  double get totalPrice {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }
}