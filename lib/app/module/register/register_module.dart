import 'package:cuidapet/app/module/register/register_controller.dart';
import 'package:cuidapet/app/module/register/register_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterModule  extends Module{
  @override
  void binds(Injector i) {
    i.addLazySingleton(() => RegisterController(
      logger: Modular.get(),
      service: Modular.get()
      ));
    super.binds(i);
   
  }

  @override
  void routes(RouteManager r) {
     r.child(Modular.initialRoute, child:  (_)=> const  RegisterPage());
  }
}