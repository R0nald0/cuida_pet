import 'package:cuidapet/app/module/auth/auth_module.dart';
import 'package:cuidapet/app/module/core/core_module.dart';
import 'package:cuidapet/app/module/home/hom_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
   @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }
 
 @override
  List<Module> get imports => [
    CoreModule(),
  ];
  @override
  void routes(RouteManager r) {
    r.module('/auth/', module: AuthModule());
    r.module('/home', module: HomModule());
  }
}