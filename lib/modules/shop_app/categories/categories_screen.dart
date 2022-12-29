

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
        builder: (context,state){
        return ListView.separated(
            itemBuilder: (context,index)=>buildCateo(ShopCubit.get(context).categoriesModel!.data!.data![index]),
            separatorBuilder: (context,index)=>SizedBox(height: 10,)
            , itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length);
        },
        );
  }
  Widget buildCateo(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage("${model.image}"),width: 80,height: 80,fit: BoxFit.cover,),
        SizedBox(width: 15,),
        Text(
          '${model.name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        Spacer(),
        Icon(Icons.arrow_forward_ios)


      ],
    ),
  );
}
