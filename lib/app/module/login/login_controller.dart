
import 'package:cuidapet/app/service/user_service.dart';
import 'package:cuidapet/core/exceptions/failure.dart';
import 'package:cuidapet/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:cuidapet/core/ui/widgets/Loader.dart';
import 'package:cuidapet/core/ui/widgets/message.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
final UserService _userService;
final AppLogger _logger;

LoginControllerBase({required UserService serivce, required AppLogger  log})
 : _userService = serivce ,
  _logger = log,
  super();


Future<void> login(String login ,String password) async{
    try {
    Loader.show(); 
    await  _userService.login(login, password);
    Loader.hide();
  } on Failure catch (e,s) {
    final errorMessage =e.message ?? 'erro ao realizar o login';
    _logger.error(errorMessage,e,s);
    Loader.hide();
    Message.alert(errorMessage);
  }
  on UserExistsException {
     const  erroMessage = 'Usuario não cadastrado';
       _logger.error(erroMessage);
       Loader.hide();
       Message.alert(erroMessage);
  }
 } 
}