import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/webview_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 15,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required Function validate,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onChanged: onChange != null ? (s) => onChange(s) : null,
      onFieldSubmitted: onSubmit != null ? (s) => onSubmit(s) : null,
      validator: (value) => validate(value),
      onTap: () {
        onTap!();
      },
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: Icon(suffix),
                )
              : null,
          border: OutlineInputBorder()),
    );

/*Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40,

          child: Text(

            '${model['time']}',

          ),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded  (

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${model['title']}',

                style: TextStyle(

                  fontSize: 18,

                  fontWeight: FontWeight.bold,

                ),

              ),

              Text(

                '${model['date']}',

                style: TextStyle(

                    fontSize: 18,

                    fontWeight: FontWeight.bold,

                    color: Colors.grey),

              ),

            ],

          ),

        ),

        SizedBox(

          width: 20,

        ),

        IconButton(onPressed: ()

        {

          AppCubit.get(context).updateData(status: 'done', id: model['id']);

        },

            icon: Icon(Icons.check_box_sharp,color: Colors.teal,)),

        IconButton(onPressed: ()

        {

          AppCubit.get(context).updateData(status: 'archive', id: model['id']);

        },

            icon: Icon(Icons.archive_outlined,color: Colors.black87,)),



      ],

    ),

  ),
  onDismissed: (direction)
  {
    AppCubit.get(context).DeleteData(id: model['id']);
  },
);*/

/*Widget TasksBuilder(
    {
      required List<Map> tasks,
    }
    )=>ConditionalBuilder(
  condition:tasks.length>0 ,
  builder: (context)=>ListView.separated(
      itemBuilder: (context,index)=>buildTaskItem(tasks[index],context),
      separatorBuilder: (context,index)=>Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 20,
        ),
        child: Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],

        ),
      ),
      itemCount: tasks.length),
  fallback: (context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.menu,
          size:100 ,
          color: Colors.grey,

        ),
        Text('No tasks yet, Please add some tasks !',
          style: TextStyle(
              fontSize:16,
              color: Colors.grey,
              fontWeight: FontWeight.bold
          ),

        )
      ],
    ),
  ),
);*/
Widget buildArticleItem(article,context)=>InkWell(
  onTap: ()
  {
    NavigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),

            image: DecorationImage(

              image: NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                    style: Theme.of(context).textTheme.bodyText1,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                    color: Colors.grey,

                  ),

                ),

              ],

            ),

          ),

        )



      ],

    ),

  ),
) ;
Widget Mydivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],

  ),
);
Widget articleBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
  condition:list.length>0,
  builder: (context) =>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder:(context,index)=> buildArticleItem(list[index],context),
      separatorBuilder: (context,index)=>Mydivider(),
      itemCount: list.length),
  fallback: (context) =>isSearch?Container(): Center(child: CircularProgressIndicator()),
);

void NavigateTo(context,widget)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>widget),);
