import 'package:cuidapet/app/repository/user_repository.dart';
import 'package:cuidapet/core/exceptions/failure.dart';
import 'package:cuidapet/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:cuidapet/core/rest_client/rest_client.dart';
import 'package:cuidapet/core/rest_client/rest_client_exception.dart';

class UserRepositoryImpl implements UserRepository{
  final AppLogger _log;
  final RestClient _restClient;
  
  
  UserRepositoryImpl({required AppLogger logger ,required RestClient restClient})
  : _log = logger, 
   _restClient = restClient
  ,super();

  @override
  Future<void> register(String email, String password) async {
      try {
       await  _restClient.unauth().post('http://10.0.2.2:8080/auth/register',data: {
          'email':  email,
          'password':password
        });
      } on RestClientException catch (e,s) {
         if (e.statuCode == 400 &&  e.response.data['message'].contains('Usúario já cadastrado')) {
           _log.error(e.error, e,s);
           throw UserExistsException();
         }

         _log.error('Erro ao cadastrar usuario');
         throw Failure(message: 'Erro ao  cadastrar usuário');  
      }
  }
  
  @override
  Future<String> login(String email, String password) async {
      
      try {
        final resul = await _restClient.unauth().post(
          '/auth/',
          data: {
            'login':email,
            'password':password,
            'social_login':false,
            'supplier_user':false
          }
        );
        
       return resul.data['access_token'] ;

       } on RestClientException catch (e,s) {
         if (e.statuCode == 403) {
            throw Failure(message: 'Usuario inconsistent entre em contato com o supporte!! ');
         }
         _log.error( "erro ao realizar  o login", e,s);
          throw Failure(message: 'Erro ao realizar login,tente novamente mais tarde');
      }

  }

}
