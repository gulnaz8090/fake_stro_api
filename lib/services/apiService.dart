import 'dart:convert';

import 'package:fake_store/models/product.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:http/http.dart';

class ApiService{
  Future <List<Product>> getAllPosts()async{
    final allProductUrl = Uri.parse("https://fakestoreapi.com/products");
    final response = await http.get(allProductUrl);
    List<Product> allProducts = [];
    List body = json.decode(response.body);
    body.forEach((Product) {
      allProducts.add(Product.fromJson(Product));
     });
    return allProducts;
  }

  Future getSingleProduct(int id)async{
    final singleProductUrl = Uri.parse("https://fakestoreapi.com/products/$id");
    final response  = await http.get(singleProductUrl);
    print(response.statusCode);
    print(response.body);
    var body  = json.decode(response.body);
    return Product.fromJson(body);
    
  }

  Future getAllCategory()async{
    final allCategoryUrl = Uri.parse("https://fakestoreapi.com/products/categories");
    final response = await http.get(allCategoryUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getProductByCategory(String catName)async{
    final fetchProductCategoryUrl = Uri.parse("https://fakestoreapi.com/products/category/$catName");
    final response = await http.get(fetchProductCategoryUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getCart(String userId)async{
    final fetchCartProducts = Uri.parse("https://fakestoreapi.com/carts/$userId");
    final response = await http.get(fetchCartProducts);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  // POST REQUEST 

  Future userLogin(String username,String Password)async{
    final loginUrl =  Uri.parse('https://fakestoreapi.com/auth/login');
    final response = await http.post(loginUrl,body: {
      'username' : username,
      'password':Password
    });

    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  deleteCart(String s) {}
}