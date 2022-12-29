

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/favorites_model.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../modules/shop_app/categories/categories_screen.dart';
import '../../../modules/shop_app/favorites/favorites_screen.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../../modules/shop_app/setting_screen/setting_screen.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  HomeModel? homeModel;
  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen()
  ];

  void ChangeBottom(int index)
  {
    currentIndex = index;
    if (index == 3){
      getUserData();
    }
    else if (index == 2)
      getFavorites();
    else if (index == 1) getCategories();

    getHomeData();
    emit(ShopChangeBottomNavState());
  }
  Map<int?,bool?> favorites={};
  void getHomeData()
  {

    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url:'home',token: token).then((value) {
      homeModel=HomeModel.fromjson(value.data);
homeModel!.data!.products!.forEach((element) {
favorites.addAll({
  element.id:element.in_favorites
});
});
print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
  CategoriesModel? categoriesModel;
  void getCategories()
  {


    DioHelper.getData(url:'categories').then((value) {
      categoriesModel=CategoriesModel.fromjson(value.data);

      emit(ShopSuccessCategoriesState());

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;
  void ChangeFavourites(int? id )

  {
    favorites[id]= !favorites[id]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(url: "favorites", data: {
      "product_id":id
    },token: token).
    then((value)
    {

      changeFavoritesModel=ChangeFavoritesModel.fromjson(value.data);
      print(value.data);
      print(favorites.toString());
      if(!changeFavoritesModel!.status!){
        favorites[id]= !favorites[id]!;
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).
    catchError((error){
emit(ShopErrorChangeFavoritesState());
    });
  }
  FavoritesModel? favoritesModel;
  void getFavorites()
  {


    DioHelper.getData(url:'favorites',token: token).then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);
      print(value.data.toString());

      emit(ShopSuccessGetFavoritesState());

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }
  ShopLoginModel? userModel;
  void getUserData()
  {

emit(ShopLoadingUserDataState());
    DioHelper.getData(url:'profile',token: token).then((value) {
      userModel=ShopLoginModel.fromjson(value.data);
      print(value.data.toString());

      emit(ShopSuccessUserDataState(userModel!));

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }
}
