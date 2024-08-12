
import 'package:cuidapet/core/router_cuida_pet.dart';
import 'package:cuidapet/app/models/social_login_type.dart';
import 'package:cuidapet/app/service/user_service/user_service.dart';
import 'package:cuidapet/core/exceptions/failure.dart';
import 'package:cuidapet/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:cuidapet/core/ui/widgets/Loader.dart';
import 'package:cuidapet/core/ui/widgets/message.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
final UserService _userService;
final AppLogger _logger;


LoginControllerBase({
    required UserService serivce, 
    required AppLogger  log
    })
 : _userService = serivce ,
  _logger = log,
  super();


Future<void> login(String login ,String password) async{
    try {
    Loader.show(); 
    await  _userService.login(login, password);
    Loader.hide();
    Modular.to.navigate(RouterCuidaPet.AUTH_ROUTE);
  } on Failure catch (e,s) {
    final errorMessage =e.message;
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

 Future<void> socialLogin(SocialLoginType socialLoginType) async {
    try{
      Loader.show();
       await _userService.socialLoginType(socialLoginType);
      Loader.hide();
      Modular.to.navigate(RouterCuidaPet.AUTH_ROUTE);
    } on Failure catch(e,s){
     Loader.hide();
     _logger.error('Erro ao realizar login',e,s);
     
     Message.alert('Erro ao realizar Login');
    }
 }
}