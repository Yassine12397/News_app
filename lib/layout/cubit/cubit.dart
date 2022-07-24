import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sport_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_handball_rounded),
      label: 'Sport',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];
  List<Widget> Screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentindex = index;
    if (index == 1) getScience();
    if (index == 2) getSport();
    emit(NewsInitialState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': '4c8557bcb353468182dd28e25bdb589b',
    }).then((value) {
      // print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': '4c8557bcb353468182dd28e25bdb589b',
      }).then((value) {
        // print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      NewsGetScienceSuccessState();
    }
  }

  List<dynamic> sport = [];

  void getSport() {
    emit(NewsGetScienceLoadingState());
    if(sport.length==0)
      {
        DioHelper.getData(url: 'v2/top-headlines', query: {
          'country': 'us',
          'category': 'sports',
          'apiKey': '4c8557bcb353468182dd28e25bdb589b',
        }).then((value) {
          // print(value.data['articles'][0]['title']);
          sport = value.data['articles'];
          print(sport[0]['title']);
          emit(NewsGetSportSuccessState());
        }).catchError((error) {
          print(error.toString());
          emit(NewsGetSportErrorState(error.toString()));
        });
      }
    else
      {
        emit(NewsGetSportSuccessState());
      }

  }
  bool isDark=true;
  void changeAppMode()
  {
    isDark = !isDark;
    print(isDark);
    emit(NewsAppChangeModeState());
  }

  List<dynamic> search = [];

  void getSearch (String value) {


    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything',
        query: {
      'q': '$value',
      'apiKey': '4c8557bcb353468182dd28e25bdb589b',
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
