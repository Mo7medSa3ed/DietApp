import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:http/http.dart' as http;

class API {
  static const String _BaseUrl = 'https://clean.forever-affiliate.com/api/v1';

  // Functions For User

  static Future<http.Response> signupUser(user) async {
    final res = await http.post(Uri.parse('$_BaseUrl/users/auth/register'),
        encoding: Encoding.getByName("utf-8"),
        headers: await getHeader(),
        body: json.encode(user));

    return res;
  }

  static Future<http.Response> loginUser(user) async {
    final res = await http.post(Uri.parse('$_BaseUrl/users/auth/login'),
        encoding: Encoding.getByName("utf-8"),
        headers: await getHeader(),
        body: json.encode(user));
    return res;
  }

  static Future<http.Response> forgetPassword(mobile) async {
    final res = await http.post(
        Uri.parse('$_BaseUrl/users/auth/forget_password'),
        encoding: Encoding.getByName("utf-8"),
        headers: await getHeader(),
        body: json.encode({"mobile": mobile}));
    return res;
  }

  static Future<http.Response> resetPassword(body) async {
    final res = await http.post(Uri.parse('$_BaseUrl/users/auth/reset'),
        encoding: Encoding.getByName("utf-8"),
        headers: await getHeader(),
        body: json.encode(body));
    return res;
  }

  static Future<http.Response> logout() async {
    final res = await http.post(Uri.parse('$_BaseUrl/users/auth/logout'),
        encoding: Encoding.getByName("utf-8"), headers: await getHeader());
    return res;
  }

  static Future<dynamic> getAllCourses() async {
    final res = await http.get(Uri.parse('$_BaseUrl/users/courses'),
        headers: await getHeader());
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body);

    if ((res.statusCode == 200 || res.statusCode == 201) && parsed['success']) {
      return parsed;
    }
    return null;
  }

  static Future<dynamic> getAllProducts() async {
    final res = await http.get(Uri.parse('$_BaseUrl/users/products'),
        headers: await getHeader());
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body);
    if ((res.statusCode == 200 || res.statusCode == 201) && parsed['success']) {
      return parsed;
    }
    return null;
  }

  static Future<dynamic> getCart() async {
    final res = await http.get(Uri.parse('$_BaseUrl/users/cart'),
        headers: await getHeader());
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body);

    if ((res.statusCode == 200 || res.statusCode == 201) && parsed['success']) {
      return parsed;
    }
    return null;
  }

  static Future<dynamic> increaseQtyCart(id) async {
    final res = await http.get(
        Uri.parse('$_BaseUrl/users/cart/increaseQty/$id'),
        headers: await getHeader());
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body);
    print(parsed);
    if ((res.statusCode == 200 || res.statusCode == 201) && parsed['success']) {
      final item = parsed['data']['items'].firstWhere((e) => e["id"] == id);
      return item['quantity'];
    }
    return null;
  }

  static Future<dynamic> addToCart(id) async {
    final res = await http.get(Uri.parse('$_BaseUrl/users/cart/addProduct/$id'),
        headers: await getHeader());
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body);

    if ((res.statusCode == 200 || res.statusCode == 201) && parsed['success']) {
      return {"success": true, "amount": parsed['data']['items_count']};
    }
    return false;
  }

  static Future<dynamic> decreaseQtyCart(id) async {
    final res = await http.get(
        Uri.parse('$_BaseUrl/users/cart/decreaseQty/$id'),
        headers: await getHeader());
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body);
    if ((res.statusCode == 200 || res.statusCode == 201) && parsed['success']) {
      final item = parsed['data']['items'].firstWhere((e) => e["id"] == id);
      return item['quantity'];
    }
    return null;
  }

  static Future<dynamic> removeProductFromCart(id) async {
    final res = await http.get(
        Uri.parse('$_BaseUrl/users/cart/removeProduct/$id'),
        headers: await getHeader());
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body);
    if ((res.statusCode == 200 || res.statusCode == 201) && parsed['success']) {
      return parsed;
    }
    return null;
  }

  static Future<dynamic> getOneCourse(id) async {
    final res = await http.get(Uri.parse('$_BaseUrl/users/courses/$id'),
        headers: await getHeader());
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body);
    if ((res.statusCode == 200 || res.statusCode == 201) && parsed['success']) {
      return parsed;
    }
    return null;
  }

  static Future<dynamic> getOneCourseDays(id) async {
    final res = await http.get(
        Uri.parse('$_BaseUrl/users/courses/courses_days/$id'),
        headers: await getHeader());
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body);
    if ((res.statusCode == 200 || res.statusCode == 201) && parsed['success']) {
      return parsed;
    }
    return null;
  }

  static Future<dynamic> getOneOrders(id) async {
    final res = await http.get(Uri.parse('$_BaseUrl/users/orders/$id'),
        headers: await getHeader());
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body);
    if ((res.statusCode == 200 || res.statusCode == 201) && parsed['success']) {
      return parsed;
    }
    return null;
  }

  static Future<Response> updateProfile(userUpdated) async {
    final formData = FormData.fromMap(userUpdated);
    final dio = Dio();
    dio.options = BaseOptions(headers: await getHeader());
    final res =
        await dio.post('$_BaseUrl/users/account/updateProfile', data: formData);
    return res;
  }

  static Future<Response> makeOrder(body) async {
    final formData = FormData.fromMap(body);
    final dio = Dio();
    dio.options = BaseOptions(headers: await getHeader());
    final res = await dio.post('$_BaseUrl/users/orders', data: formData);
    return res;
  }
}
/*

  static Future<http.Response> loginUser(User user) async {
    final res = await http.post('$_BaseUrl/users/auth/login',
        encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: json.encode(user.toJsonForLogin()));
    return res;
  }

  static Future<http.Response> signupUser(User user) async {
    final res = await http.post('$_BaseUrl/users/',
        encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: json.encode(user.toJsonForSignup()));

    return res;
  }

  static updateImage(File image, String id) async {
    String name = image.path.split('/').last;
    FormData form = FormData.fromMap(
        {'avatar': await MultipartFile.fromFile(image.path, filename: name)});
    Dio dio = new Dio();
    await dio.post('$_BaseUrl/users/change/avatar/$id', data: form);
  }

  static Future<http.Response> updateUser(User user, id) async {
    final res = await http.patch('$_BaseUrl/users/$id',
        encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: json.encode(user.toJsonForUpdate()));
    return res;
  }

  static Future<User> getOneUser(String id) async {
    final response = await http.get('$_BaseUrl/users/$id');
    final body = utf8.decode(response.bodyBytes);
    final parsed = json.decode(body);
    return User.fromJson(parsed);
  }

  static Future<List<User>> getAllUser() async {
    final response = await http.get('$_BaseUrl/users/');
    final body = utf8.decode(response.bodyBytes);
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed.map<User>((dish) => User.fromJson2(dish)).toList();
  }

  // Function For Dish

  static Future<List<Dish>> getAllDishes() async {
    final res = await http.get(
      '$_BaseUrl/dishes/',
    );
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed.map<Dish>((dish) => Dish.fromJson(dish)).toList();
  }

  static Future<Dish> getOneDish(String id) async {
    final res = await http.get(
      '$_BaseUrl/dishes/$id',
    );
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body);
    return Dish.fromOneJson(parsed);
  }

  static Future<http.Response> deleteDish(String dishId) async {
    print(dishId);
    final res = await http.delete(
      '$_BaseUrl/dishes/$dishId',
    );
    return res;
  }

  static updateImageForDish(File image, String id) async {
    String name = image.path.split('/').last;
    FormData form = FormData.fromMap(
        {'img': await MultipartFile.fromFile(image.path, filename: name)});
    Dio dio = new Dio();
    await dio.patch('$_BaseUrl/dishes/change-img/$id', data: form);
  }

  static Future<http.Response> updateDish(
      String id, Map<String, dynamic> updatedDish) async {
    final res = await http.patch('$_BaseUrl/dishes/$id',
        encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: json.encode(updatedDish));

    return res;
  }

  // Function For reviews
  static Future<http.Response> addReview(Review review, String id) async {
    final res = await http.post('$_BaseUrl/dishes/reviews/add/$id',
        encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: json.encode(review.toJson()));

    return res;
  }

  static Future<http.Response> deleteReview(
      String dishId, String reviewid) async {
    final res = await http.delete(
      '$_BaseUrl/reviews?dishId=$dishId&reviewId=$reviewid',
    );
    return res;
  }

  static Future<http.Response> updateReview(
      Review review, String dishId, String reviewid) async {
    print(dishId);
    print(reviewid);
    final res = await http.patch(
        '$_BaseUrl/reviews/1?dishId=$dishId&reviewId=$reviewid',
        encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: json.encode(review.toJson()));
    return res;
  }

  // function For favourite

  static Future<http.Response> addanddelteFav(
      String userid, String dishid) async {
    final res = await http.post('$_BaseUrl/users/fav/$userid',
        encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: json.encode({"dishId": dishid}));
    return res;
  }

  // function for orders

  static Future<http.Response> makeOrder(Map<String, dynamic> order) async {
    final res = await http.post('$_BaseUrl/orders/',
        encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: json.encode(order));

    return res;
  }

  // function for categories
  static Future<List<Categorys>> getAllCategories() async {
    final res = await http.get(
      '$_BaseUrl/categories',
    );
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    print(parsed);
    return parsed.map<Categorys>((dish) => Categorys.fromJson(dish)).toList();
  }

  static Future<http.Response> deleteCategory(String name) async {
    final res = await http.delete(
      '$_BaseUrl/categories/$name',
    );
    return res;
  }

  static Future<http.Response> addCategory(
      Map<String, dynamic> categories) async {
    final res = await http.post('$_BaseUrl/categories/',
        encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: json.encode(categories));

    return res;
  }

  static Future<http.Response> updateCategory(
      Map<String, dynamic> categories, id) async {
    final res = await http.patch('$_BaseUrl/categories/$id',
        encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: json.encode(categories));

    return res;
  }

  static Future<http.Response> patchOrder(
      Map<String, dynamic> order, id) async {
    final res = await http.patch('$_BaseUrl/orders/$id',
        encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: json.encode(order));

    return res;
  }

  static Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyBMD6TqYt-Y0dc4grEFzBmCkHOqsKncgAo";
    http.Response response = await http.get(url);
    print(response);
    Map values = jsonDecode(response.body);
    return values.toString(); //;
  }

  static Future<dynamic> getAllOrders() async {
    final res = await http.get(
      '$_BaseUrl/orders/',
    );
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    parsed.sort((a, b) =>
        b['updatedAt'].toString().compareTo(a['updatedAt'].toString()));
    return parsed;
  }

  static Future<dynamic> getOneOrder(id) async {
    final res = await http.get(
      '$_BaseUrl/orders/$id',
    );
    final body = utf8.decode(res.bodyBytes);
    final parsed = json.decode(body);
    return parsed;
  }


  
}
 */