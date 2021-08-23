
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(article,context)=>InkWell(
  onTap: (){

    navigateTo(context,WebViewScreen(article['url']),);
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(15.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120.0,
  
          height: 120.0,
  
          decoration: BoxDecoration(
  
              borderRadius: BorderRadius.circular(10.0,),
  
              image:DecorationImage(
  
                image: NetworkImage('${article['urlToImage']}'),
  
                fit: BoxFit.cover,
  
              )
  
  
  
  
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        Expanded(
  
          child: Container(
  
            height: 120,
  
            child: Column(
  
              mainAxisSize: MainAxisSize.min,
  
              crossAxisAlignment:CrossAxisAlignment.start,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Padding(
  
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
  
                    child: Text(
  
                      '${article['title']}',
  
                      style: Theme.of(context).textTheme.bodyText1,
  
                      maxLines: 3,
  
                      overflow: TextOverflow.ellipsis,
  
                    ),
  
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
  
        ),
  
      ],
  
    ),
  
  ),
);
void navigateTo(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=>widget)
);