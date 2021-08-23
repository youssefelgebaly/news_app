import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/netwwork/local/cache_helper.dart';
import 'package:news_app/netwwork/remote/dio_helper.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/modules/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context)=> BlocProvider.of(context);

  int currentIndex=0;

  List<BottomNavigationBarItem> bottomItems=[
    BottomNavigationBarItem(
      icon:Icon(
        Icons.business,
      ),
      label:'Business',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.sports_soccer,
      ),
      label:'Sports',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.science,
      ),
      label:'Science',
    ),

  ];

  List<Widget> screens=
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),

  ];
  void changeBottomNavBar(int index){
    currentIndex= index;
    if(index==0)
      getBusiness();
    if(index==1)
      getSports();
    if(index==2)
      getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business=[];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    if(sports.length==0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'ffe7c5991c8d410a8546f4a0dc142f72',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        business=value.data['articles'];
        print(business[0]['title']);

        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }else
    {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sports=[];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.length==0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'ffe7c5991c8d410a8546f4a0dc142f72',
          },
        ).then((value)
        {
          //print(value.data['articles'][0]['title']);
          sports=value.data['articles'];
          print(sports[0]['title']);

          emit(NewsGetSportsSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }else
        {
          emit(NewsGetSportsSuccessState());
        }
  }

  List<dynamic> science=[];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length==0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'ffe7c5991c8d410a8546f4a0dc142f72',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        science=value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else
      {
        emit(NewsGetScienceSuccessState());
      }

  }


  List<dynamic> search=[];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

    search=[];

      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'ffe7c5991c8d410a8546f4a0dc142f72',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        search=value.data['articles'];
        print(search[0]['title']);

        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });


  }


  bool isDark =false;
  ThemeMode appMode=ThemeMode.dark;

  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    }else
    isDark=! isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
    {
     emit(AppChangeModeState());
    });
    emit(AppChangeModeState());
  }
}