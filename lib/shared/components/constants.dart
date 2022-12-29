//

// https://newsapi.org//v2/top-headlines?country=eg&category=business&apiKey=05d4aa8f2fa44933912a8195644e8a83

//"https://www.youm7.com/story/2022/12/4/سعر-الدولار-اليوم-الأحد-4-12-2022-أمام-الجنيه-المصرى/5998784"



import 'package:flutter/material.dart';

import '../../layout/shop_app/shop_layout/shop_home_layout.dart';
import '../../modules/shop_app/login_screen/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void SignOut(context){

CacheHelper.removeData(key: 'token').then((value) {
if (value)
  navigateAndFinish(context,LoginScreen());


}
);
}
String token ='';
//
// import 'package:flutter/material.dart';

// class HomeModel
// {
//   bool? status;
//   HomeDataModel? data ;
//   HomeModel.fromjson(Map<String , dynamic> json)
//   {
//     status=json["status"];
//     data=HomeDataModel.fromjson(json["data"]);
//   }
// }
// class HomeDataModel
// {
//   List<BannersModel>banners=[];
//   List<ProductsModel>products=[];
//   HomeDataModel.fromjson(Map<String,dynamic>json)
//   {
//     json["banners"].forEach((element)
//     {
//       banners.add(element);
//     });
//     json["products"].forEach((element)
//     {
//       products.add(element);
//     });
//
//   }
// }
// class BannersModel
// {
//   int? id;
//   String? image;
//
//   BannersModel.fromjson(Map<String,dynamic> json)
//   {
//     id=json["id"];
//     image=json["image"];
//   }
// }
// class ProductsModel
// {
//   int? id;
//   dynamic price;
//   dynamic old_price;
//   dynamic discount;
//   String? image;
//   String? name;
//   bool? in_favorites;
//   bool? in_cart;
//   ProductsModel.fromjson(Map<String,dynamic>json)
//   {
//     id=json["id"];
//     price=json["price"];
//     old_price=json["old_price"];
//     discount=json["discount"];
//     image=json["image"];
//     name=json["name"];
//     in_favorites=json["in_favorites"];
//     in_cart=json["in_cart"];
//   }
// }
//
//
//
//
//
//
// class HomeModel {
//   bool? status;
//   String? message;
//   Data? data;
//
//
//
//   HomeModel.fromJson(Map<String, dynamic> json)
//   {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
// }
//
// class Data {
//   List<Banners>? banners;
//   List<Products>? products;
//
//
//
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['banners'] != null) {
//       banners = [];
//       json['banners'].forEach((v) {
//         banners!.add(Banners.fromJson(v));
//       });
//     }
//     if (json['products'] != null) {
//       products = <Products>[];
//       json['products'].forEach((v) {
//         products!.add(Products.fromJson(v));
//       });
//     }
//
//   }
//
//
// }
//
// class Banners {
//   int? id;
//   String? image;
//   Null category;
//   Null product;
//
//
//
//   Banners.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//     category = json['category'];
//     product = json['product'];
//   }
//
//
// }
//
// class Products {
//   int? id;
//   dynamic price;
//   dynamic oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;
//   List<String>? images;
//   bool? inFavorites;
//   bool? inCart;
//
//
//
//   Products.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//     images = json['images'].cast<String>();
//     inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//   }
//
//
// }

