import 'package:e_comm_app/features/_common/app_state.dart';
import 'package:e_comm_app/features/_model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListItemCounter extends StatelessWidget {
  AppState get _appState => Get.find<AppState>();

  final Product product;

  ListItemCounter(this.product);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            _appState.addItemToCart(product.id);
            // addItemToCart(product.id);
          },
          icon: Icon(Icons.add),
        ),
        Obx(() {
          return Text('${Get.find<AppState>().productsCart[product.id] ?? 0}');
        }),
        IconButton(
          onPressed: () {
            _appState.removeItemToCart(product.id);
            //  removeItemToCart(product.id);
          },
          icon: Icon(Icons.delete),
        ),
      ],
    );
  }
}
