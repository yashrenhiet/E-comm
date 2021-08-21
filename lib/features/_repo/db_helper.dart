import 'package:e_comm_app/features/_model/product.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database _db;

  Database get db => _db;

  init() async {
    // try {
    //   await Directory(dirname(path)).create(recursive: true);
    //
    //   _db = await openDatabase(path, version: 1,
    //       onCreate: (Database db, int version) async {
    //     // When creating the db, create the table
    //     await db.execute(
    //         'CREATE TABLE Product (objectId TEXT, name TEXT, type TEXT, price REAL, description TEXT, image TEXT)');
    //   });
    // } catch (e) {
    //   print(e);
    // }
  }

  static addProduct(Product prod) {
    var dbHelper = Get.find<DbHelper>();
    dbHelper.db.insert("Product", prod.toMap());
  }

  static Future<List<Product>> getProducts() async {
    var db = Get.find<DbHelper>().db;
    var prodMap = await db.query("Product");
    return prodMap.map((element) {
      return Product.fromMap(element);
    }).toList();
  }
}
