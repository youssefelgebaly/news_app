import 'package:dio/dio.dart';

class DioHelper
{
  static late Dio dio;

  static init()
  {
    dio=Dio(
      BaseOptions(
        baseUrl:'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
  required String url,
    required Map<String, dynamic>  query,
})async
  {
    return await dio.get(url, queryParameters: query,);
  }
}

//Your API key is: ae3089230bef419a8638cd090d834b53