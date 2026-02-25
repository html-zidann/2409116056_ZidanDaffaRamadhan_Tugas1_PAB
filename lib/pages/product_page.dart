import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product.dart';
import 'cart_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CartController cartController = Get.put(CartController());

  String search = "";
  String selectedCategory = "All";

  final List<Product> products = [
    Product(id: 1, name: "Mobil Polisi", price: 50000, category: "Mobil"),
    Product(id: 2, name: "Mobil Balap", price: 75000, category: "Mobil"),
    Product(id: 3, name: "Truk Mainan", price: 65000, category: "Truk"),
    Product(id: 4, name: "Bus Mini", price: 55000, category: "Bus"),
  ];

  @override
  Widget build(BuildContext context) {
    var filtered = products.where((p) {
      final matchSearch =
          p.name.toLowerCase().contains(search.toLowerCase());
      final matchCategory =
          selectedCategory == "All" || p.category == selectedCategory;
      return matchSearch && matchCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Toko Mobil Mobilan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.to(() => const CartPage()),
          )
        ],
      ),
      body: Column(
        children: [
          // 🔍 SEARCH
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search mobil...",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => search = value),
            ),
          ),

          // 🏷 CATEGORY
          DropdownButton<String>(
            value: selectedCategory,
            items: ["All", "Mobil", "Truk", "Bus"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) =>
                setState(() => selectedCategory = val!),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final product = filtered[index];

                return ListTile(
                  title: Text(product.name),
                  subtitle: Text("Rp ${product.price}"),
                  trailing: ElevatedButton(
                    child: const Text("Add"),
                    onPressed: () => cartController.addToCart(product),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}