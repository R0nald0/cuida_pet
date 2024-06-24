import 'package:cuidapet/app/service/user_service.dart';
import 'package:cuidapet/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:cuidapet/core/ui/widgets/Loader.dart';
import 'package:cuidapet/core/ui/widgets/message.dart';
import 'package:mobx/mobx.dart';
part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {

   final UserService _userService;
   final AppLogger _appLogger;

  RegisterControllerBase({required UserService service, required AppLogger logger})
     :_userService = service,
     _appLogger = logger,
     super(); 


  Future<void> register({required String login ,required String password}) async{
    try {
      Loader.show();
      await _userService.register(login, password);
      Loader.hide();
      Message.info("Enviamos um email de confirmaçãop ara seu email,por favor, verifique sua caixa de email");
      
      _appLogger.info("teste applogger ${_userService.hashCode}");
    }on UserExistsException{
      Loader.hide();
      Message.alert('Email já utilizado por favor escolha outro');
    } catch (e,s) {
      _appLogger.error('erro ao registrar o usuario',e,s);
      Loader.hide();
      Message.alert('erro ao registrar o usuario');
  }
  
  }   
}
