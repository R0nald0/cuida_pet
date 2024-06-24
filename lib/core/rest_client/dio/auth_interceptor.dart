
import 'package:cuidapet/core/constants.dart';
import 'package:cuidapet/core/local_storage/loacl_storage.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthInterceptor  extends Interceptor{
  final AppLogger _logger;
  final LocalStorage _localStorage;

  AuthInterceptor({required AppLogger logger , required LocalStorage storage})
  :
   _localStorage =storage,
   _logger =logger;

 
 @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final authRequired = options.extra[Constants.REST_CLINT_AUTH_REQUIRED_KEY] ?? false;

    if(authRequired){
      final accessTokem = await _localStorage.read<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY);
      if (accessTokem == null) {
        return handler.reject(
          DioException(
             requestOptions:options,
             error: 'Expire Token',
             type: DioExceptionType.cancel
             ));
      }
          options.headers['Authorization'] = accessTokem;
    }else{
          options.headers.remove('Authorization');
    }
  
    handler.next(options);
    super.onRequest(options, handler);


  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }


}