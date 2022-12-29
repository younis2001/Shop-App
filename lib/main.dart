

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc%20observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'layout/shop_app/cubit/cubit.dart';
import 'layout/shop_app/shop_layout/shop_home_layout.dart';
import 'modules/shop_app/login_screen/login_screen.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');
bool onBoarding=CacheHelper.getData(key: 'onBoarding');
token =CacheHelper.getData(key: 'token');

print(token);
Widget widget;

if(onBoarding !=null)
  {
   if(token !=null ) widget=ShopLayout();
   else widget =LoginScreen();
  }
else widget = OnBoardingScreen();

  runApp(myApp(isDark,widget));

}

class myApp extends StatelessWidget {
  bool? isDark;
Widget? startWidget;
   myApp(this.isDark,this.startWidget);



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider (
      providers:[
        BlocProvider(
        create: (context) => AppCubit()..AppModeChange(shared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()
        ),
      ],

        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                theme:lightTheme ,
                darkTheme:darkTheme ,
                themeMode: AppCubit.get(context).isDark
                    ? ThemeMode.light
                    :ThemeMode.dark ,
                debugShowCheckedModeBanner: false,
                home:startWidget,
            );


          },
        ));
  }
}
