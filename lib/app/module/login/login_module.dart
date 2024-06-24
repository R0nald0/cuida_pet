import 'package:cuidapet/app/module/login/login_controller.dart';
import 'package:cuidapet/app/module/login/login_page.dart';
import 'package:cuidapet/app/service/user_service.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module{

  @override
  void binds(Injector i) {
     i.addLazySingleton(()=>LoginController(
      log: Modular.get<AppLogger>(),
      serivce: Modular.get<UserService>()
     ));
    super.binds(i);
  }

 @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child:(_) => const LoginPage());
  }
}