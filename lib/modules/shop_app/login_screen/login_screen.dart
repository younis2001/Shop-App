

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../layout/shop_app/shop_layout/shop_home_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../register/shop_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
var formKey=GlobalKey<FormState>();
var emailController=TextEditingController();
var passwordController=TextEditingController();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (BuildContext context) => ShopLoginCubit(),
  child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
  listener: (context, state) {
    if(state is ShopLoginSuccessState){
      if(state.loginModel.status!){


      Fluttertoast.showToast(
          msg: state.loginModel.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value)
{
  token=state.loginModel.data!.token!;
  navigateAndFinish(context,ShopLayout());
});

    }else{
        print(state.loginModel.message);

      }
    }
  },
  builder: (context, state) {


    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('LOGIN',style:Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),),

                  SizedBox(height: 10,),
                  Text('Login Now To Hot Offers',style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey),),
                  SizedBox(height: 30,),
                  defualtTextfiled(
                      controller: emailController,
                      label: 'Email Address',
                      type: TextInputType.emailAddress,
                      prefix :Icons.email_outlined,
                      validate: (value){
                        if(value!.isEmpty){
                          return 'please enter your email';
                        }
                      }
                  ),
                  SizedBox(height: 20,),
                  defualtTextfiled(isPassword: ShopLoginCubit.get(context).isPassword,

                    validate: (value){
                      if(value!.isEmpty){
                        return 'please enter your password';
                      }
                    },
                      controller: passwordController,
                      type: TextInputType.phone,
                      label: 'Password',
                      prefix: Icons.lock,
                      suffix:ShopLoginCubit.get(context).suffix ,
                      suffixPress: (){
                        ShopLoginCubit.get(context).ChangePasswordVisibility();
                      }


                  ),
                  SizedBox(height: 20,),
                  ConditionalBuilder(
                    condition: state is! ShopLoginLoadingState ,
                    builder: ( context) { return defultButton(
                      text: 'login',
                      function: () {
                        if(formKey.currentState!.validate()){
                          ShopLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        }


                      },
                    ); },
                    fallback: (context)=>Center(child: CircularProgressIndicator()),

                  ),SizedBox(height: 15,),
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(onPressed: (){

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShopRegisterScreen()));
                      }, child: Text('REGISTER'))
                    ],)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
),
);

  }
}
