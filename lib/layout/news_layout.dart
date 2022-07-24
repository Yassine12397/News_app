import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/theme_cubit/themeCubit.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/compenents/compenent.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates> (
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit=NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',

            ),
              actions: [
                IconButton(
                    onPressed: ()
                    {
                      NavigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search),),
                IconButton(
                  onPressed: ()
                  {
                    ThemeCubit.get(context).changeAppMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined),),
              ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              DioHelper.getData(url: 'v2/top-headlines',
                  query: {
                    'country':'us',
                    'category':'business',
                    'apiKey':'4c8557bcb353468182dd28e25bdb589b',
                  }).then((value)
              {
                print(value.data['articles'][0]['title']);
              }).catchError((error)
              {
                print(error.toString());
              });
            },
            child: Icon(Icons.add),
          ),
          body: cubit.Screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
              items: cubit.bottomItems,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },

    );
  }
}
