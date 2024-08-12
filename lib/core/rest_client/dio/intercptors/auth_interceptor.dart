
import 'package:cuidapet/app/module/core/auth/auth_store.dart';
import 'package:cuidapet/core/constants.dart';
import 'package:cuidapet/core/local_storage/loacl_storage.dart';
import 'package:dio/dio.dart';


class AuthInterceptor  extends Interceptor{

  final LocalStorage _localStorage;
  final AuthStore _authStore;
  

  AuthInterceptor({
     required LocalStorage storage,
     required AuthStore authStore,
     })
  :
   _localStorage =storage,
    _authStore =authStore ;


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final authRequired = options.extra[Constants.REST_CLINT_AUTH_REQUIRED_KEY] ?? false;

    if(authRequired){
      final accessTokem = await _localStorage.read<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY);
      if (accessTokem == null) {
        _authStore.logout();   
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
   
  }




}