import 'package:e_comm_app/features/_model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product prod;

  const ProductDetailsScreen({Key? key, required this.prod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: prod.id,
            child: Image.network(
              prod.imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 16),
          Text(
            prod.name,
            style: Get.textTheme.headline6,
          )
        ],
      ),
    );
  }
}
