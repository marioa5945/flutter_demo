import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('这是产品详情页面')),
      body: const Center(child: Text('这是一个产品详情页面')),
    );
  }
}
