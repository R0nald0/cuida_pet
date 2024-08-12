import 'dart:io';

import 'package:cuidapet/app/models/confirmation_login_model.dart';
import 'package:cuidapet/app/models/social_network_model.dart';
import 'package:cuidapet/app/models/user_model.dart';
import 'package:cuidapet/app/repository/user_repository/user_repository.dart';
import 'package:cuidapet/core/exceptions/failure.dart';
import 'package:cuidapet/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:cuidapet/core/rest_client/rest_client.dart';
import 'package:cuidapet/core/rest_client/rest_client_exception.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserRepositoryImpl implements UserRepository {
  final AppLogger _log;
  final RestClient _restClient;

  UserRepositoryImpl(
      {required AppLogger logger, required RestClient restClient})
      : _log = logger,
        _restClient = restClient,
        super();

  @override
  Future<void> register(String email, String password) async {
    try {
      await _restClient.unauth().post('/auth/register',
          data: {'email': email, 'password': password});
    } on RestClientException catch (e, s) {
      if (e.statuCode == 400 &&
          e.response.data['message'].contains('Usúario já cadastrado')) {
        _log.error(e.error, e, s);
        throw UserExistsException();
      }

      _log.error('Erro ao cadastrar usuario');
      throw Failure(message: 'Erro ao  cadastrar usuário,verifque email e senha');
    }on FormatException catch(e,s){
         _log.error('Erro ao criar usuario no firebase', e, s);
      throw Failure(message: 'Erro ao criar Usuaurio');
    } 
  }

  @override
  Future<String> login(String email, String password) async {
    try {
      final resul = await _restClient.unauth().post('/auth/', data: {
        'login': email,
        'password': password,
        'social_login': false,
        'supplier_user': false
      });

      return resul.data['access_token'];
    } on RestClientException catch (e, s) {
      if (e.statuCode == 403) {
        throw Failure(
            message: 'Usuario inconsistent entre em contato com o supporte!! ');
      }
      _log.error("erro ao realizar  o login", e, s);
      throw Failure(
          message: 'Erro ao realizar login,tente novamente mais tarde');
    }
  }

  @override
  Future<ConfirmationLoginModel> confirmationLogin() async {
    try {
      final deviceToken = await FirebaseMessaging.instance.getToken();

      final resul = await _restClient.auth().patch('/auth/confirm', data: {
        'ios_token': Platform.isIOS ? deviceToken : null,
        'android_token': Platform.isAndroid ? deviceToken : null
      });

      return ConfirmationLoginModel.fromMap(resul.data);
    } on RestClientException catch (e, s) {
      _log.error("Erro ao confirmar o  login", e, s);
      throw Failure(message: 'Erro ao confimar ologin');
    }
  }

  @override
  Future<UserModel> getUserLogged() async {
    try {
      final result = await _restClient.auth().get('/user/');
      return UserModel.fromMap(result.data);
    } on Exception catch (e, s) {
      _log.error('erro ao buscar dados do usuário', e, s);
      throw Failure(message: 'Erro ao buscasr dados do usuário logado');
    }
  }

  @override
  Future<String> loginSocial(SocialNetworkModel model) async {
    try {
      final result = await _restClient.unauth().post('/auth/', data: {
        'login': model.email,
        'social_login': true,
        'avatar': model.avatar,
        'social_type': model.type,
        'social_key': model.id,
        'supplier_user': false
      });

      return result.data['access_token'];
    } on RestClientException catch (e, s) {
      if (e.statuCode == 403) {
        throw Failure(
            message: 'Usuario inconsistent entre em contato com o supporte!! ');
      }
      _log.error("erro ao realizar  o login", e, s);
      throw Failure(
          message: 'Erro ao realizar login,tente novamente mais tarde');
    }
  }
}
