
import 'package:dio/dio.dart';

Exception? handleHttpError(Response response){
  switch (response.statusCode) {
    case 200:
    case 201:
      return null;
    // ver  los casos
    case 404:
      break;
    default:
  }
}