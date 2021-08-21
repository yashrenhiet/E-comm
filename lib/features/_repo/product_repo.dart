import 'package:dio/dio.dart';
import 'package:e_comm_app/features/_common/constants.dart';
import 'package:e_comm_app/features/_model/product.dart';
import 'package:e_comm_app/features/_repo/db_helper.dart';

class ProductRepo {
  Dio? _dio;

  Dio get client {
    if (_dio == null)
      _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: {
        "X-Parse-Application-Id": APP_ID,
        "X-Parse-REST-API-Key": API_KEY
      }));
    return _dio!;
  }

  Future<List<Product>> fetchProducts() async {
    try {
      var response = await client.get('classes/Product');

      var productsMap = response.data["results"];

      var products = (productsMap as List)
          .map<Product>((e) => Product.fromMap(e))
          .toList();

      // TODO add to db
      // products.forEach((p) {
      //   DbHelper.addProduct(p);
      // });

      return products;
    } catch (e) {
      throw e;
    }
  }
}
