import 'package:flutter_test_app/models/product.dart';

class CategoriesModel {
  var id;
  var name;
  var createdAt;
  var updatedAt;
  List<ProductModel> products;
  CategoriesModel(
      {this.createdAt, this.updatedAt, this.id, this.name, this.products});

  factory CategoriesModel.fromJson(json) => CategoriesModel(
        id: json['id'],
        name: json['name'],
        products: json['products']
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList(),
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );
}
