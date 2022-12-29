
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';

class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit
              .get(context)
              .userModel != null,
          builder: (BuildContext context) {
            var model = ShopCubit
                .get(context)
                .userModel;
            nameController.text = model!.data!.name!;
            emailController.text = model.data!.email!;
            phoneController.text = model.data!.phone!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defualtTextfiled(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'name must be not empty';
                        }
                        return null;
                      },
                      label: 'name',
                      prefix: Icons.person
                  ),
                  SizedBox(height: 20,),
                  defualtTextfiled(
                      controller: emailController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'email must be not empty';
                        }
                        return null;
                      },
                      label: 'email',
                      prefix: Icons.email_outlined
                  ),
                  SizedBox(height: 20,),
                  defualtTextfiled(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'phone must be not empty';
                        }
                        return null;
                      },
                      label: 'phone',
                      prefix: Icons.phone
                  ),
                  SizedBox(height: 20,),
                  defultButton(text: "SignOut", function: () {
                    SignOut(context);
                  })

                ],
              )
              ,
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),


        );
      },
    );
  }
}
