
import 'package:cuidapet/app/module/address/address_controller.dart';
import 'package:cuidapet/app/module/address/address_detail/address_detail_module.dart';
import 'package:cuidapet/app/module/address/address_page.dart';
import 'package:cuidapet/app/module/address/addres_search/address_search_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressModule extends Module{
  @override
  void binds(Injector i) {
    i.addLazySingleton(
      ()=>AddressController(
        serviceAddress: Modular.get())
        );
    i.addLazySingleton(
      ()=>AddressSearchController(
        serviceAdress: Modular.get())
        );
    super.binds(i);
  }

 @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_)=> const AddressPage());
    r.module('/detail/', module: AddressDetailModule());
    super.routes(r);
  }

}