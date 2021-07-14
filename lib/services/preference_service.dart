import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pon/core/models/products.dart';
import 'package:pon/locator.dart';
import 'package:pon/services/cart_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static const String bearerToken = "BEARERTOKEN";
  static const String userName = "USERNAME";
  static const String phoneNo = "PHONE_NUMBER";
  static const String userId = "USER_ID";
  static const String companyId = "COMPANY_ID";
  static const String is_authed = "ISAUTHED";
  static const String product = "PRODUCT";

  SharedPreferences pref;

  init() async {
    pref = await SharedPreferences.getInstance();
  }

  setBearerToken(String value) {
    pref.setString(bearerToken, value);
    debugPrint("Bearer Token stored successfully");
  }

  setUserName(String value) async {
    pref.setString(userName, value);
    debugPrint("Name  stored successfully");
  }

  setAuthenticated(bool value) async {
    pref.setBool(is_authed, value);
    debugPrint("Is Authed stored successfully");
  }

  String getBearerToken() {
    return pref.getString(bearerToken) ?? "";
  }

  String getName() {
    return pref.getString(userName) ?? "";
  }

  bool isAuthenticated() {
    return pref.getBool(is_authed) ?? false;
  }

  String getUserId() {
    return pref.getString(userId) ?? "";
  }

  setUserId(String value) async {
    pref.setString(userId, value);
    debugPrint("User Id stored successfully");
  }

  String getPhoneNo() {
    return pref.getString(phoneNo) ?? "";
  }

  setPhoneNo(String value) async {
    pref.setString(phoneNo, value);
    debugPrint("Phone No stored successfully");
  }

  String getCompanyId() {
    return pref.getString(companyId) ?? "";
  }

  setCompanyId(String value) async {
    pref.setString(companyId, value);
    debugPrint("Company Id stored successfully");
  }

  List<Products> addProductToWishList(Products value) {
    List<Products> productsList = getWishListProduct();
    if (productsList
            .where((element) => element.prodid == value.prodid)
            .toList()
            .length >
        0) {
      productsList.removeWhere((element) => element.prodid == value.prodid);
    } else {
      productsList.add(value);
    }
    List<String> data = new List();
    productsList.forEach((element) {
      data.add(json.encode(element.toJson()).toString());
    });
    pref.setStringList(product, data);

    return productsList;
  }

  List<Products> getWishListProduct() {
    return pref.getStringList(product) == null
        ? new List()
        : pref
            .getStringList(product)
            .map((e) => Products.fromJson(json.decode(e)))
            .toList();
  }

  clearData() async {
    locator<CartService>().refreshCart();
    //locator<UserService>().clear();
    pref.clear();
  }
}
