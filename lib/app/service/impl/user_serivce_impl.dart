
import 'package:cuidapet/app/models/social_login_type.dart';
import 'package:cuidapet/app/models/social_network_model.dart';
import 'package:cuidapet/app/repository/social/social_repository.dart';
import 'package:cuidapet/app/repository/user_repository/user_repository.dart';
import 'package:cuidapet/app/service/user_service/user_service.dart';
import 'package:cuidapet/core/constants.dart';
import 'package:cuidapet/core/exceptions/failure.dart';
import 'package:cuidapet/core/local_storage/loacl_storage.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSerivceImpl implements UserService {
  final UserRepository _userRepository;
  final AppLogger _logger;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final SocialRepository _socialRepository;

  UserSerivceImpl({
    required UserRepository repository, 
    required AppLogger log,
    required LocalStorage storage,
    required LocalSecureStorage secureStorage,
    required SocialRepository socialRepository}
    )
      : _userRepository = repository,
        _logger = log,
        _localStorage =storage,
        _localSecureStorage =secureStorage,
        _socialRepository= socialRepository,
        super();

  @override
  Future<void> register(String email, String password) async {
    try {
     final auth = FirebaseAuth.instance;
    /*  final  db = FirebaseFirestore.instance;

    // final userMethods = await auth.fetchSignInMethodsForEmail(email);

    // verificar se tem conta cadastra 
      final users = db.collection('user').doc(email);
      final query = await users.get();
      
      final userFire = UserModel.fromFirestore(query); */


     /*  if (userMethods.isNotEmpty) {
        throw UserExistsException();
      } 
 */
      await _userRepository.register(email, password);
      final userRegisterCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userRegisterCredential.user?.sendEmailVerification();
    }
    on FirebaseException catch (e, s) {
      _logger.error('Erro ao criar usuario no firebase', e, s);
      throw Failure(message: 'Erro ao criar Usuaurio');
    }
    on Exception catch(e,s){
         _logger.error('Erro ao criar usuario', e, s);
      throw Failure(message: 'Erro ao criar Usuario');
    } 
  }

  @override
  Future<void> login(String email, String password) async {
    try {
     
      final auth = FirebaseAuth.instance;
      /* final loginMethods = await auth.fetchSignInMethodsForEmail(email);
       if (loginMethods.isEmpty) {
         throw UserExistsException();
      } 
      print(loginMethods.toString()); */
        
        final userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        final userVerified = userCredential.user?.emailVerified ?? false;

        if (!userVerified) {
          throw Failure(
              message: 'E-mail não confirmado,verifique sua caixa de spam');
        }
       final accessToken = await _userRepository.login(email, password);
       await _saveAccessToken(accessToken);
       await _confirmLogin();   
       await _getUserData(); 
      /* if (loginMethods.contains(password)) {
       
      } else {
        throw Failure(
            message:
                'Login não pode ser feiito por email e senha ,utilize outro metodo');
      } */
    } on FirebaseAuthException catch (e,s) {
       _logger.error('Usuáro ou senhe inválidos firebase error',e,s);
        throw Failure(message: 'Usuario ou senha inválidos');
    } on Exception catch (e,s){
           _logger.error('Usuáro ou senhe inválidos firebase error',e,s);
        throw Failure(message: 'Usuario ou senha inválidos');
    }
  }
  
  _saveAccessToken(String accessToken) => _localStorage.write<String>(
           Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY, accessToken);



  Future<void> _confirmLogin() async{
     final confirmeLogin = await _userRepository.confirmationLogin();
     await _saveAccessToken(confirmeLogin.accessToken);
     await _localSecureStorage.write(Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY, confirmeLogin.refreshToken);

  }       

  Future<void> _getUserData() async{
     final userData = await _userRepository.getUserLogged();
     await _localStorage.write<String>(Constants.LOCAL_STORAGE_USER_DATA_LOGGED, userData.toJson());
  }

  @override
  Future<void> socialLoginType(SocialLoginType loginType)  async{
     try {
  final SocialNetworkModel socialNetworkModel;
  final AuthCredential authCredential;
  final auth = FirebaseAuth.instance;
  
  switch(loginType){
     case SocialLoginType.facebook:
       socialNetworkModel = await _socialRepository.facebookLogin();
       authCredential = FacebookAuthProvider.credential(socialNetworkModel.accessToken);
       break;  
        
     case SocialLoginType.google:
     socialNetworkModel = await _socialRepository.googleLogin();
      authCredential = GoogleAuthProvider.credential(
       accessToken: socialNetworkModel.accessToken,
       idToken: socialNetworkModel.id
      );
     break;
  }
    //  final loginMethods = await auth.fetchSignInMethodsForEmail(socialNetworkModel.email);
  
      _getMethodToSocialLoginType(loginType);
      
    //  if(loginMethods.isNotEmpty && !loginMethods.contains(methodchek)){
    //   throw Failure(message: "Login não pode ser feito por $methodchek ,por favor tente outra forma");
    //  } 
  
     await auth.signInWithCredential(authCredential);
  
     final accesToken = await _userRepository.loginSocial(socialNetworkModel);
     await _saveAccessToken(accesToken);
     await _confirmLogin();
     await _getUserData();
} on FirebaseAuthException catch (e,s) {
  _logger.error('Erro ao logar com $loginType',e,s);
  throw Failure(message: 'Erro ao realizar login');
}
  }

 
  String _getMethodToSocialLoginType(SocialLoginType socialLoginType){
     switch (socialLoginType) {
       case SocialLoginType.facebook:
           return 'facebock.com';
        case SocialLoginType.google:
           return 'google.com';
     }
  }

}


