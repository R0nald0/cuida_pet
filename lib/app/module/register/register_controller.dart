import 'package:cuidapet/app/module/core/auth/auth_store.dart';
import 'package:cuidapet/app/service/user_service/user_service.dart';
import 'package:cuidapet/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:cuidapet/core/ui/widgets/Loader.dart';
import 'package:cuidapet/core/ui/widgets/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {

   final UserService _userService;
   final AppLogger _appLogger;
   final AuthStore _authStore;

  RegisterControllerBase({
     required UserService service, 
     required AppLogger logger,
     required AuthStore auth,
     })
     :_userService = service,
     _appLogger = logger,
     _authStore = auth,
     super(); 


  Future<void> register({required String login ,required String password}) async{
    try {
      Loader.show();
      await _userService.register(login, password);
      Loader.hide();
      _authStore.logout();
      Message.info("Enviamos um email de confirmação para seu email,por favor, verifique sua caixa de email");
      _appLogger.info("teste applogger ${_userService.hashCode}");
    }on FirebaseException catch (e,s){
      Loader.hide();
      _appLogger.error('${e.message}',e,s);
      Message.alert('${e.message}');
    }
    on UserExistsException{
      Loader.hide();
      Message.alert('Email já utilizado por favor escolha outro');
    }
     on Exception catch (e,s) {
      _appLogger.error('erro ao registrar o usuario',e,s);
      Loader.hide();
      Message.alert('erro ao registrar o usuario');
  }
  
  }   
}
