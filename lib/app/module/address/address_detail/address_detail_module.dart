
import 'package:cuidapet/app/module/address/address_detail/address_detail_controller.dart';
import 'package:cuidapet/app/module/address/address_detail/address_detatil_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressDetailModule  extends Module{
   @override
  void binds(Injector i) {
     i.addLazySingleton(
      ()=>AddressDetailController(
        service: Modular.get())
      );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    // TODO: implement routes
    super.routes(r);

    r.child('/', child:(context) =>AddressDetailPage(placeModel: r.args.data) );
  }
  
}