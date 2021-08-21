import 'dart:math';

import 'package:e_comm_app/features/_common/preference_utils.dart';
import 'package:e_comm_app/features/_model/product.dart';
import 'package:e_comm_app/features/_model/user.dart';
import 'package:e_comm_app/features/_repo/product_repo.dart';
import 'package:get/get.dart';

enum AppStateEnum { INITIAL, AUTHENTICATED, NOT_AUTHENTICATED }

class AppState extends GetxController {
  var state = AppStateEnum.INITIAL.obs;

  ProductRepo get _productRepo => Get.find<ProductRepo>();

  var loggedInUser = Rxn<User?>();

  bool get isLoggedIn => loggedInUser.value != null;

  var products = <Product>[].obs;

  var categories = <String>{}.obs;

  var selectedCategory = "".obs;

  var productsCart = <String, int>{}.obs;

  get filteredProducts => selectedCategory.isEmpty
      ? products
      : products.where((p) => p.category == selectedCategory.value).toList();

  Future initializeData() async {
    products.value = await _productRepo.fetchProducts();

    categories.clear();
    products.forEach((element) {
      categories.add(element.category);
    });

    var curUser = await PreferenceUtils.getUser();
    if (curUser != null) {
      logInUser(curUser);
    } else {
      logoutUser();
    }
  }

  logoutUser() async {
    loggedInUser.value = null;
    await PreferenceUtils.saveUse(null);
    state.value = AppStateEnum.NOT_AUTHENTICATED;
  }

  logInUser(User user) async {
    loggedInUser.value = user;
    await PreferenceUtils.saveUse(user);
    state.value = AppStateEnum.AUTHENTICATED;
  }

  addItemToCart(String productId) {
    var cartItem = productsCart[productId];
    productsCart[productId] = cartItem == null ? 1 : ++cartItem;
  }

  removeItemToCart(String productId) {
    var cartItemCheck = productsCart[productId];
    if (cartItemCheck == null) return;

    int cartItem = cartItemCheck - 1;

    if (cartItem <= 0) {
      productsCart.remove(productId);
    } else {
      productsCart[productId] = max(cartItem, 0);
    }
  }

  clearCart() {
    productsCart.clear();
  }

  cartTotal() {
    double price = 0;
    productsCart.forEach((key, value) {
      Product product = products.firstWhere((p) => p.id == key);
      price += value * product.rate;
    });
    return price;
  }
}
