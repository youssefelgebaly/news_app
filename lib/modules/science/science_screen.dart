import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
class ScienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var list=NewsCubit.get(context).science;

        return list.length>0  ?
        ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context ,index)=>buildArticleItem(list[index],context),
          separatorBuilder: (context, index)=> Padding(
            padding: const EdgeInsetsDirectional.only(start: 20,),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: list.length):
        Center(child: CircularProgressIndicator());
      },
    );

  }
}
