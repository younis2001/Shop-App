

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/login_screen/cubit/states.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel? loginModel;
void userLogin({
  required String email,
  required String password,
})
{
  emit(ShopLoginLoadingState());
 DioHelper.postData(
     url: 'login',
     data:
     {
'email':email,
'password':password,
     }
 ).then((value) {
    print(value.data);
    loginModel=ShopLoginModel.fromjson(value.data);
    print(loginModel!.status);
    print(loginModel!.message);
    print(loginModel!.data!.token);
    emit(ShopLoginSuccessState(loginModel!));
  }).catchError((error){
    print(error.toString());
   emit(ShopLoginErrorState(error.toString()));
 });}
  bool isPassword =true;
IconData suffix=Icons.visibility_outlined;
void ChangePasswordVisibility(){
isPassword = !isPassword;
suffix =isPassword ? Icons.visibility_outlined:Icons.visibility_off_outlined;
emit(ShopIconPasswordChangeState());
}

}