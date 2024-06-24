import 'package:cuidapet/app/module/auth/home/auth_home_page.dart';
import 'package:cuidapet/app/module/login/login_module.dart';
import 'package:cuidapet/app/module/register/register_module.dart';
import 'package:cuidapet/app/repository/impl/user_repository_impl.dart';
import 'package:cuidapet/app/repository/user_repository.dart';
import 'package:cuidapet/app/service/impl/user_serivce_impl.dart';
import 'package:cuidapet/app/service/user_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module{
  @override
  void binds(Injector i) {
    i.addLazySingleton<UserRepository>(()=>UserRepositoryImpl(
      logger:Modular.get(),
      restClient: Modular.get() 
      ));
    
    i.addLazySingleton<UserService>(() => UserSerivceImpl(
      log: Modular.get(),
      repository: Modular.get(),
      storage: Modular.get()
    ));
  
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
     r.child(Modular.initialRoute, child: (_)=>  AuthHomePage(authStore:Modular.get(),));
     r.module('/login/', module:LoginModule());
     r.module('/register/', module:RegisterModule());
  }
}