import 'package:flutter/material.dart';

class HomeModel
{
  bool? status;
  HomeDataModel? data ;
  HomeModel.fromjson(Map<String , dynamic> json)
  {
    status=json["status"];
    data=json["data"]!=null?HomeDataModel.fromjson(json['data']):null;
  }
}
class HomeDataModel
{
  List<BannersModel>?banners;
  List<ProductsModel>?products;
  HomeDataModel.fromjson(Map<String,dynamic>json)
  {
if(json['banners']!=null) {
  banners = [];
  json['banners'].forEach((element) {
    banners!.add(BannersModel.fromjson(element));
  });
  if(json['products']!=null){
    products=<ProductsModel>[];
    json['products'].forEach((element){
      products!.add(ProductsModel.fromjson(element));
    });
  }
}
  }
}
class BannersModel
{
  int? id;
  String? image;

  BannersModel.fromjson(Map<String,dynamic> json)
  {
    id=json["id"];
    image=json["image"];
  }
}
class ProductsModel
{
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;
  ProductsModel.fromjson(Map<String,dynamic>json)
  {
    id=json["id"];
    price=json["price"];
    old_price=json["old_price"];
    discount=json["discount"];
    image=json["image"];
    name=json["name"];
    in_favorites=json["in_favorites"];
    in_cart=json["in_cart"];
  }
}