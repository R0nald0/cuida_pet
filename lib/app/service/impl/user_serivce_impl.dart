import 'package:cuidapet/app/repository/user_repository.dart';
import 'package:cuidapet/app/service/user_service.dart';
import 'package:cuidapet/core/constants.dart';
import 'package:cuidapet/core/exceptions/failure.dart';
import 'package:cuidapet/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet/core/local_storage/loacl_storage.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSerivceImpl implements UserService {
  final UserRepository _userRepository;
  final AppLogger _logger;
  final LocalStorage _localStorage;

  UserSerivceImpl({required UserRepository repository, required AppLogger log,required LocalStorage storage})
      : _userRepository = repository,
        _logger = log,
        _localStorage =storage,
        super();

  @override
  Future<void> register(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;

      final userMethods = await auth.fetchSignInMethodsForEmail(email);

      if (userMethods.isEmpty) {
        throw UserExistsException();
      }

      await _userRepository.register(email, password);
      final userRegisterCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userRegisterCredential.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _logger.error('Erro ao criar usuario no firebase', e, s);
      throw Failure(message: 'Erro ao criar Usuaurio');
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final loginMethods = await auth.fetchSignInMethodsForEmail(email);

      if (loginMethods.isEmpty) {
        throw UserExistsException();
      }

      if (loginMethods.contains(password)) {
        final userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        final userVerified = userCredential.user?.emailVerified ?? false;

        if (!userVerified) {
          throw Failure(
              message: 'E-mail não confirmado,verifique sua caixa de spam');
        }
       final accessToken = await _userRepository.login(email, password);
       await _saveAccessToken(accessToken);
       final key = await _localStorage.read<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY);
 
      } else {
        throw Failure(
            message:
                'Login não pode ser feiito por email e senha ,utilize outro metodo');
      }
    } on FirebaseAuthException catch (e,s) {
       _logger.error('Usuáro ou senhe inválidos firebase error');
        throw Failure(message: 'Usuario ou senha inválidos');
    }
  }
  
  _saveAccessToken(String accessToken) => _localStorage.write<String>(
           Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY, accessToken);
}
