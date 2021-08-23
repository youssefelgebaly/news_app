import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){},
      builder:(context,state)
      {
        var list=NewsCubit.get(context).search;

        return  Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: searchController ,
                  keyboardType:TextInputType.text ,
                  onChanged:(value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  } ,
                  validator: (value){
                    if (value!.isEmpty){
                      return 'search must not be emptu';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
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
                    itemCount: list.length),
              ),

            ],
          ),
        );
      },
    );
  }
}
