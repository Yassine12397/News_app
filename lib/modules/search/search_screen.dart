  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/compenents/compenent.dart';

class SearchScreen extends StatelessWidget {

  var searchController=TextEditingController();
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
     listener:(context,state) {},
      builder: (context,state)
      {
         var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(

          ),
          body:Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  onChange: (value)
                  {
                  NewsCubit.get(context).getSearch(value);
                  },
                  type: TextInputType.text,
                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true))
            ],
          ),

        );
      },
    );
  }
}
