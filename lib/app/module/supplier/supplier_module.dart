import 'package:cuidapet/app/module/supplier/supplier_controller.dart';
import 'package:cuidapet/app/module/supplier/supplier_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SupplierModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(
        () => SupplierController(
          serviceSupplier: Modular.get(),
          appLoger: Modular.get()
          ));
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child('/', child: (_) => SupplierPage(supplierId: r.args.data,));
  }
}
