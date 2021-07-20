class ProductModel {
  var id;
  var name;
  var description;
  var price;
  var photo;
  var isActive;
  var createdAt;
  var updatedAt;
  var amount =1;

  ProductModel(
      {this.createdAt,
      this.description,
      this.id,
      this.isActive,
      this.name,
      this.photo,
      this.price,
      this.updatedAt,
      this.amount
      });

  factory ProductModel.fromJson(json) => ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        photo: json['photo'],
        isActive: json['is_active'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );
  factory ProductModel.fromJsonForCart(json,amount) => ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        photo: json['photo'],
        isActive: json['is_active'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        amount: amount,
      );
}