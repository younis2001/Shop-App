


import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState)
        {
if(!state.model.status!){
  Fluttertoast.showToast(
      msg: state.model.message!,
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
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null&&ShopCubit.get(context).categoriesModel!=null,
          builder: (context) => HomeBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget HomeBuilder(HomeModel? model,CategoriesModel? categoriesModel,context) => SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data!.banners!
                    .map(
                      (e) => Image(
                        image: NetworkImage('${e.image}'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 6),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal)),
            SizedBox(
              height: 11,
            ),
            Text('Categories',
            style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold) ,),
Container(height: 100,

  child:   ListView.separated(

    scrollDirection: Axis.horizontal,

      itemBuilder: (context,index)=>buildCategoryItem(categoriesModel!.data!.data![index]),

      separatorBuilder: (context,index)=>SizedBox(width: 10,),

      itemCount: categoriesModel!.data!.data!.length

  ),
),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                  childAspectRatio: 1 / 1.52,
                  children: List.generate(
                      model.data!.products!.length,
                      (index) =>
                          buildGridProduct(model.data!.products![index],context)),),
            )
          ],
        ),
      );

  Widget buildGridProduct(ProductsModel model,context) => Container(
        color: Colors.white,
        child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: TextStyle(fontSize: 14, height: 1.3),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text('${model.price.round()}',
                        style: TextStyle(
                            fontSize: 15,
                            height: 1.3,
                            color: Colors.blueAccent),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(
                      width: 10,
                    ),
                    if (model.discount != 0)
                      Text('${model.old_price.round()}',
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
                           backgroundColor:ShopCubit.get(context).favorites[model.id]! ? Colors.blueAccent :Colors.grey,
                         radius: 15,
                       child:Icon(
                          Icons.favorite_border,
                          size: 15,
                         color: Colors.white,
                        )),
                      onPressed: () {
                        ShopCubit.get(context).ChangeFavourites(model.id);
                         print(model.id);
                      },),
                  ],
                ),
              ],
            ),
          ),
        ]),
      );
  Widget buildCategoryItem(DataModel model)=>Stack(alignment: Alignment.bottomCenter,
    children: [
      Image(
        image: NetworkImage(
            "${model.image}"),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(color: Colors.red,
          width: 100,
          child: Text(
            '${model.name}',
            textAlign:TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ))
    ],
  );
}
