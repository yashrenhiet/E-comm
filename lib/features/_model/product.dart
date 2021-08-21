class Product {
  late String id;
  late String name;
  String? description;
  late String category;
  late String imageUrl;
  late double rate;

  Product(
      {required this.id,
      required this.name,
      required this.category,
      this.description,
      required this.imageUrl,
      required this.rate});

  Product.fromMap(Map<String, dynamic> map) {
    this.id = map["objectId"];
    this.name = map["name"];
    this.description = map["description"];
    this.category = map["type"];
    this.imageUrl = map["image"];
    this.rate = double.parse((map["price"] ?? "0").toString());
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "objectId": id,
      "name": name,
      "description": description,
      "type": category,
      "image": imageUrl,
      "price": rate
    };
    return map;
  }

  // static List<Product> GetProducts() {
  //   return List.generate(
  //       50,
  //       (index) => Product(
  //           id: index,
  //           name: 'Item $index',
  //           category: 'Category $index',
  //           imageUrl:
  //               'https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-product-6_large.png?format=jpg&quality=90&v=1530129477',
  //           rate: 5,
  //           description: index % 2 == 0
  //               ? null
  //               : 'This is the description of item $index'));
  // }
}
