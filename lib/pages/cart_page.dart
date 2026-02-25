import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang")),
      body: Obx(() => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartController.cartItems[index];

                    return ListTile(
                      title: Text(item.product.name),
                      subtitle:
                          Text("Qty: ${item.quantity}"),
                      leading: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () =>
                            cartController.decreaseQty(index),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () =>
                            cartController.increaseQty(index),
                      ),
                    );
                  },
                ),
              ),
              Text(
                "Total: Rp ${cartController.totalPrice}",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutPage()),
                child: const Text("Checkout"),
              ),
            ],
          )),
    );
  }
}