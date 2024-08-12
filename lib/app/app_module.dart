import 'package:cuidapet/app/module/schedule/schedule_modele.dart';
import 'package:cuidapet/app/module/supplier/supplier_module.dart';
import 'package:cuidapet/core/router_cuida_pet.dart';
import 'package:cuidapet/app/module/address/address_module.dart';
import 'package:cuidapet/app/module/auth/auth_module.dart';
import 'package:cuidapet/app/module/core/core_module.dart';
import 'package:cuidapet/app/module/home/hom_module.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
 
 
 @override
  List<Module> get imports => [
    CoreModule(),
  ];
  @override
  void routes(RouteManager r) {
    r.module(RouterCuidaPet.AUTH_ROUTE, module: AuthModule());
    r.module(RouterCuidaPet.HOME_ROUTE, module: HomModule());
    r.module(RouterCuidaPet.ADDRESS_ROUTE, module: AddressModule());
    r.module(RouterCuidaPet.SUPLLIER_MODULE_ROUTE, module:SupplierModule());
    r.module(RouterCuidaPet.SCHEDULE_MODULE_ROUTE, module:ScheduleModele());
  }
}