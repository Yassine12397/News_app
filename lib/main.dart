import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layout/news_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
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
          )

        ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepOrange,
            elevation: 20,
      )
      ),
      home: NewsLayout()
    );
  }
}

