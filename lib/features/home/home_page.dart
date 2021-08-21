import 'package:e_comm_app/features/_common/app_state.dart';
import 'package:e_comm_app/features/_model/product.dart';
import 'package:e_comm_app/features/home/widget/category_selector.dart';
import 'package:e_comm_app/features/home/widget/list_item_counter.dart';
import 'package:e_comm_app/features/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppState get _appState => Get.find<AppState>();

  var arrayOfCategory = <String>["All", "Marvel", "DC", "Others"];

  List<Product> get products => Get.find<AppState>().filteredProducts;

  @override
  Widget build(BuildContext context) {
    debugPrint("Building...");
    return Scaffold(
      appBar: AppBar(
        title: Text("Hey!"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _appState.clearCart();
                });
              },
              icon: Icon(Icons.delete_forever)),
          IconButton(
              onPressed: () {
                setState(() {
                  _appState.logoutUser();
                });
              },
              icon: Icon(Icons.verified_user))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CategorySelector(),
          Expanded(
            flex: 6,
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                // physics: BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  var product = products[index];
                  return Card(
                    child: ListTile(
                      // leading: Image.asset('images/products/placeholder.png'),
                      onTap: () {
                        Get.to(ProductDetailsScreen(prod: product));
                      },
                      leading: Hero(
                        tag: product.id,
                        child: Image.network(
                          product.imageUrl,
                          height: 70,
                          width: 70,
                          fit: BoxFit.contain,
                          errorBuilder: (_, o, s) => Image.asset(
                            'images/products/placeholder.png',
                            height: 70,
                            width: 70,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            product.name,
                            style: Get.textTheme.subtitle1,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'INR ${product.rate.toStringAsFixed(2)}',
                            style: Get.textTheme.caption,
                          ),
                          ListItemCounter(product)
                        ],
                      ),
                    ),
                  );
                },
                // separatorBuilder: (_, index) => Divider(),
                itemCount: products.length,
              );
            }),
          ),
          SizedBox(height: 8),
          Obx(() {
            return Offstage(
              offstage: _appState.productsCart.isEmpty,
              child: InkWell(
                onTap: () {
                  debugPrint("Clicked");
                },
                child: Container(
                  height: 60,
                  color: Colors.teal,
                  child: Center(
                      child: Text(
                          "${_appState.productsCart.length} items in cart: INR ${_appState.cartTotal().toStringAsFixed(2)}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
