class CountriesModel {
  var id;
  var name;
  var code;
  var currency;
  var shipping;
  var isActive;
  var createdAt;
  var updatedAt;

  CountriesModel(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.name,
      this.code,
      this.currency,
      this.isActive,
      this.shipping});

  factory CountriesModel.fromJson(json) => CountriesModel(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        currency: json['currency'],
        shipping: json['shipping'],
        isActive: json['is_active'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['currency'] = currency;
    map['shipping'] = shipping;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
