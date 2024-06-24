
import 'package:cuidapet/core/constants.dart';
import 'package:cuidapet/core/helpers/enviroments.dart';
import 'package:cuidapet/core/local_storage/loacl_storage.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:cuidapet/core/rest_client/dio/auth_interceptor.dart';
import 'package:cuidapet/core/rest_client/rest_client.dart';
import 'package:cuidapet/core/rest_client/rest_client_exception.dart';
import 'package:cuidapet/core/rest_client/rest_client_response.dart';
import 'package:dio/dio.dart';

class DioRestClient extends RestClient {
   late final Dio _dio;

   final  _defaultBaseOptoption = BaseOptions(
    baseUrl: Enviroments.params(Constants.ENVIREMONT_BASE_URL) ?? '',
    connectTimeout: Duration(
      milliseconds: int.parse(Enviroments.params(Constants.REST_CLIENT_CONNECT_TIMEOUT) ?? '0' )
      ),
    receiveTimeout: Duration(
      milliseconds: int.parse(Enviroments.params(Constants.REST_CLIENT_RECEIVE_TIMEOUT) ?? '0' )
      )
   );
 

  DioRestClient({
     required AppLogger logger,
     required LocalStorage storage,
    BaseOptions ? baseOptions}
  ){
     _dio = Dio(baseOptions ??  _defaultBaseOptoption);
     _dio.interceptors.addAll([
        LogInterceptor(requestBody: true,responseBody: true),
        AuthInterceptor(logger: logger, storage: storage)
     ]);
  }

  @override
  RestClient auth() {
    _defaultBaseOptoption.extra[Constants.REST_CLINT_AUTH_REQUIRED_KEY] = true;
    return this;
  }
   
    @override
  RestClient unauth() {
    _defaultBaseOptoption.extra[Constants.REST_CLINT_AUTH_REQUIRED_KEY] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> delete<T>(String path, {data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    try {
  final response  = await _dio.delete(
       path,
       data: data,
       queryParameters: queryParameters,
       options: Options(headers: headers)
    );
  
    return _dioResponseConverter(response);
} on DioException catch (e) {
    _throwRestClientExecption(e);
}
  }

  @override
  Future<RestClientResponse<T>> get<T>(
       String path, 
       {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
     try {
      final response = await _dio.get(
          path,
          queryParameters: queryParameters,
          options: Options(headers: headers)
      );
      
      return _dioResponseConverter(response);
     }  on DioException catch (e) {
        _throwRestClientExecption(e);
     }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(
      String path, {data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async
  {
      try {
        final response =await _dio.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers)
          );
        
        return _dioResponseConverter(response);
      } on DioException catch (e) {
         _throwRestClientExecption(e);
      }
    
  }

  @override
  Future<RestClientResponse<T>> post<T>(String path, {data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
      try {
        final response =await _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers)
          );
        
        return _dioResponseConverter(response);
      } on DioException catch (e) {
         _throwRestClientExecption(e);
      }
  }

  @override
  Future<RestClientResponse<T>> put<T>(String path, {data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers})  async{
    try {
        final response =await _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers)
          );
        
        return _dioResponseConverter(response);
      } on DioException catch (e) {
         _throwRestClientExecption(e);
      }
  }

  @override
  Future<RestClientResponse<T>> request<T>(String path, {required String method, data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
   try {
        final response =await _dio.request(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers ,method: method)
          );
        
        return _dioResponseConverter(response);
      } on DioException catch (e) {
         _throwRestClientExecption(e);
      }
  }

 Future<RestClientResponse<T>> _dioResponseConverter<T>(Response<dynamic> response) async {
    return   RestClientResponse<T>(
        data: response.data,
        statuCode: response.statusCode,
        statuMessage: response.statusMessage
      );
 }

 Never _throwRestClientExecption(DioException dioException){
   final response = dioException.response;

   throw RestClientException(
    error: dioException,
    message: dioException.message,
    statuCode: response?.statusCode,
    response: RestClientResponse(
      data: response?.data,
      statuCode: response?.statusCode,
      statuMessage: dioException.message
    )
    );
 }
  
}