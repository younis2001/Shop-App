

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/register/cubit/states.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel? loginModel;
void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone,
})
{
  emit(ShopRegisterLoadingState());
 DioHelper.postData(
     url: 'register',
     data:
     {
       "name":name,
       'phone':phone,
       'email':email,
       'password':password,
     }
 ).then((value) {
    print(value.data);
    loginModel=ShopLoginModel.fromjson(value.data);
    // print(loginModel!.status);
    // print(loginModel!.message);
    // print(loginModel!.data!.token);
    emit(ShopRegisterSuccessState(loginModel!));
  }).catchError((error){
    print(error.toString());
   emit(ShopRegisterErrorState(error.toString()));
 });}
  bool isPassword =true;
IconData suffix=Icons.visibility_outlined;
void ChangePasswordVisibility(){
isPassword = !isPassword;
suffix =isPassword ? Icons.visibility_outlined:Icons.visibility_off_outlined;
emit(ShopiconPasswordChangeState());
}

}