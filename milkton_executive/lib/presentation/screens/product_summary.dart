import 'package:flutter/material.dart';

class ProductSummaryScreen extends StatelessWidget {
  const ProductSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Product Summary"),
      ),
      body: const Center(
        child: Text("Product Summary Screen"),
      ),
    );
  }
}
