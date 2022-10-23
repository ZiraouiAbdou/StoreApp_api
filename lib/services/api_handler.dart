import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:store_api_flutter_course/models/discounted_products%20.dart';
import 'package:store_api_flutter_course/models/users_model.dart';

import '../models/products_model.dart';
import 'package:http/http.dart' as http;

class ApiHandler extends ChangeNotifier {
  Future<List<OurProducts>> getProducts() async {
    List<OurProducts> myProducts;
    var response =
        await http.get(Uri.parse("https://fakestoreapi.com/products/"));
    var body = jsonDecode(response.body);

    myProducts = List<OurProducts>.from(
        body.map((model) => OurProducts.fromJson(model)));
    return myProducts;
  }

  Future<List<UserModel>> getUsers() async {
    List<UserModel> myUsers;
    var response =
        await http.get(Uri.parse("https://api.escuelajs.co/api/v1/users"));
    var body = jsonDecode(response.body);
    myUsers =
        List<UserModel>.from(body.map((model) => UserModel.fromJson(model)));
    return myUsers;
  }

  Future<List<DiscountedProducts>> getDiscounts() async {
    List<DiscountedProducts> myDiscounts;
    var response =
        await http.get(Uri.parse("http://api.escuelajs.co/api/v1/products"));
    var body = jsonDecode(response.body);
    myDiscounts = List<DiscountedProducts>.from(
        body.map((model) => DiscountedProducts.fromJson(model)));
    return myDiscounts;
  }
}
