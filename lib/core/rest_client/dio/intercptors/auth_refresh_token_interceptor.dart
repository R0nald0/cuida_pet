import 'dart:async';

import 'package:cuidapet/app/module/core/auth/auth_store.dart';
import 'package:cuidapet/core/constants.dart';
import 'package:cuidapet/core/exceptions/expire_token_exception.dart';
import 'package:cuidapet/core/local_storage/loacl_storage.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:cuidapet/core/rest_client/rest_client.dart';
import 'package:cuidapet/core/rest_client/rest_client_exception.dart';
import 'package:dio/dio.dart';

class AuthRefreshTokenInterceptor extends Interceptor {
  final AuthStore _authStore;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final RestClient _restClient;
  final AppLogger _logger;

  AuthRefreshTokenInterceptor({
    required AuthStore authStore,
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required RestClient restClient,
    required AppLogger logger,
  })  : _authStore = authStore,
        _localSecureStorage = localSecureStorage,
        _localStorage = localStorage,
        _logger = logger,
        _restClient = restClient,
        super();

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    try {
      final respStatusCode = err.response?.statusCode;
      final responsePath = err.requestOptions.path;

      if (respStatusCode == 403 || respStatusCode == 401) {
        if (responsePath != '/auth/refresh') {
          final authRequired = err.requestOptions
                  .extra[Constants.REST_CLINT_AUTH_REQUIRED_KEY] ??
              false;

          if (authRequired) {
            _logger.append('######## Refresh Token ############');
            await _refreshToken();
            _retyrRequest(err, handler);
            _logger.append('######## Refresh Token successo ############');
          } else {
            throw err;
          }
        } else {
          throw err;
        }
      } else {
        throw err;
      }
    } on ExpireTokenException catch (e, s) {
      _logger.error( 'Erro refresh Token',e, s);
      _authStore.logout();
      handler.next(err);
    } on DioException catch (e,s) {
      _logger.error( 'Erro ao atualizar refresh token',e, s);
      _authStore.logout();
      handler.next(e);
    } catch (e, s) {
      _logger.error("erro restClient auth", e, s);
      handler.next(err);
    } finally {
      _logger.closeApend();
    }
  }

  Future<void> _refreshToken() async {
    try {
      final refreshToken = await _localSecureStorage
          .read(Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY);

      if (refreshToken == null) {
        throw ExpireTokenException();
      }

      final resultRefreshToken = await _restClient
          .auth()
          .put('/auth/refresh', data: {'refresh_token': refreshToken});

      await _localStorage.write(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY,
          resultRefreshToken.data['access_token']);
      await _localSecureStorage.write(Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY,
          resultRefreshToken.data['access_token']);
    } on RestClientException catch (e, s) {
      _logger.error('erro ao tentar fazer refrese token', e, s);
      throw ExpireTokenException();
    }
  }

  Future<void> _retyrRequest(
      DioException err, ErrorInterceptorHandler handler) async {
    _logger.append('##### Retry Request ########');
    final requestOptions = err.requestOptions;

    final result = await _restClient.request(requestOptions.path,
        method: requestOptions.method,
        data: requestOptions.data,
        headers: requestOptions.headers,
        queryParameters: requestOptions.queryParameters);

    handler.resolve(Response(
        requestOptions: requestOptions,
        data: result.data,
        statusCode: result.statuCode,
        statusMessage: result.statuMessage));
  }
}
