





import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../layout/shop_app/shop_layout/shop_home_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  BlocProvider(
  create: (context) => ShopRegisterCubit(),
  child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
  listener: (context, state) {
    if(state is ShopRegisterSuccessState){
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
        Fluttertoast.showToast(
            msg: state.loginModel.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

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
                    Text('REGISTER',style:Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),),

                    SizedBox(height: 10,),
                    Text('REGISTER Now To Hot Offers',style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey),),
                    SizedBox(height: 30,),
                    defualtTextfiled(
                        controller: nameController,
                        label: 'name',
                        type: TextInputType.name,
                        prefix :Icons.person,
                        validate: (value){
                          if(value!.isEmpty){
                            return 'please enter your name';
                          }
                        }
                    ),
                    SizedBox(height: 20,),
                    defualtTextfiled(
                        isPassword: ShopRegisterCubit.get(context).isPassword,

                        validate: (value){
                          if(value!.isEmpty){
                            return 'please enter your password';
                          }
                        },
                        controller: passwordController,
                        type: TextInputType.phone,
                        label: 'Password',
                        prefix: Icons.lock,
                        suffix:ShopRegisterCubit.get(context).suffix ,
                        suffixPress: (){
                          ShopRegisterCubit.get(context).ChangePasswordVisibility();
                        }


                    ), SizedBox(height: 30,),
                    defualtTextfiled(
                        controller: emailController,
                        label: 'email',
                        type: TextInputType.emailAddress,
                        prefix :Icons.email,
                        validate: (value){
                          if(value!.isEmpty){
                            return 'please enter your email';
                          }
                        }
                    ), SizedBox(height: 30,),
                    defualtTextfiled(
                        controller: phoneController,
                        label: 'phone',
                        type: TextInputType.phone,
                        prefix :Icons.phone,
                        validate: (value){
                          if(value!.isEmpty){
                            return 'please enter your phone';
                          }
                        }
                    ),
                    SizedBox(height: 20,),
                    ConditionalBuilder(
                      condition: state is! ShopRegisterLoadingState ,
                      builder: ( context) { return defultButton(
                        text: 'register',
                        function: () {
                          if(formKey.currentState!.validate()){
                            ShopRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                              phone: phoneController.text,
                            );
                          }


                        },
                      ); },
                      fallback: (context)=>Center(child: CircularProgressIndicator()),

                    ),SizedBox(height: 15,),

                  ],
                ),
              ),
            ),
          ),
        ),
      );
  },
),
));

  }
}
