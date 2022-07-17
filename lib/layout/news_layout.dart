import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context)=>NewsCubit(),
      child: BlocConsumer<NewsCubit,NewsStates> (
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
                      onPressed: (){},
                      icon: Icon(Icons.search),)
                ],
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

      ),
    );
  }
}
