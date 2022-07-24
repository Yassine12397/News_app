import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/layout/theme_cubit/themeCubit.dart';
import 'package:news_app/layout/theme_cubit/themeState.dart';
import 'package:news_app/shared/compenents/blocObserver.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() {
  BlocOverrides.runZoned(
    () async{
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      bool? isDark=CacheHelper.getData(key: 'isDark');
      runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=> NewsCubit()..getBusiness()..getScience()..getSport(),),
        BlocProvider( create: (context) => ThemeCubit()..changeAppMode(
          fromShared: isDark,
        ),)
      ],
      child: BlocConsumer<ThemeCubit, ThemeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )),
                  primarySwatch: Colors.deepOrange,
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrange),
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      titleSpacing: 20,
                      iconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      )),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    backgroundColor: Colors.white,
                    unselectedItemColor: Colors.black,
                    elevation: 20,
                  )),
              darkTheme: ThemeData(
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                )),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey,
                  elevation: 20,
                ),
                appBarTheme: AppBarTheme(
                    backgroundColor: HexColor('333739'),
                    elevation: 0,
                    titleSpacing: 20,
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light,
                    )),
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: HexColor('333739'),
              ),
              themeMode: ThemeCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: NewsLayout());
        },
      ),
    );
  }
}
