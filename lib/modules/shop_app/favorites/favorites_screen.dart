import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shop_app/favorites_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
            itemBuilder: (context,index)=>buildFavItem(ShopCubit.get(context).favoritesModel!.data!.data![index],context),
            separatorBuilder: (context,index)=>SizedBox(height: 10,)
            , itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length);
      },
    );
  }
  Widget buildFavItem(FavoritesData model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(height: 120,
      child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(

                  image: NetworkImage('${model.product!.image}')
                  ,fit:BoxFit.cover ,
                  width: 100,
                  height: 100,
                ),
                if (model.product!.image!= 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
              ],
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.product!.name}',
                        style: TextStyle(fontSize: 14, height: 1.3),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text('${model.product!.price.toString()}',
                              style: TextStyle(
                                  fontSize: 15,
                                  height: 1.3,
                                  color: Colors.blueAccent),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          SizedBox(
                            width: 10,
                          ),
                          if (model.product!.oldPrice != 0)
                            Text('${model.product!.oldPrice.toString()}',
                                style: TextStyle(
                                    fontSize: 13,
                                    height: 1.3,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                          Spacer(),
                          IconButton(
                            icon: CircleAvatar(
                                backgroundColor:ShopCubit.get(context).favorites[model.product!.id]!? Colors.blueAccent :Colors.grey,
                                radius: 15,
                                child:Icon(
                                  Icons.favorite_border,
                                  size: 15,
                                  color: Colors.white,
                                )),
                            onPressed: () {
                               ShopCubit.get(context).ChangeFavourites(model.product!.id);

                            },),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
    ),
  );
}
