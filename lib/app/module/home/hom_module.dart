
import 'package:cuidapet/app/module/home/home_controller.dart';
import 'package:cuidapet/app/module/home/home_page.dart';
import 'package:cuidapet/app/module/supplier/supplier_module.dart';
import 'package:cuidapet/app/repository/supplier_category_repository/impl/supplier_category_repository_Impl.dart';
import 'package:cuidapet/app/repository/supplier_category_repository/supplier_category_repository.dart';
import 'package:cuidapet/app/service/supplier/impl/suplier_category_service_impl.dart';
import 'package:cuidapet/app/service/supplier/supplier_category_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomModule  extends Module{


    @override
  void exportedBinds(Injector i) {
    super.exportedBinds(i);
    
    
  }

    @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton(()=>
      HomeController(
         addressService: Modular.get(),
         categoryService: Modular.get()
        )
    );
    }

  @override
  void routes(RouteManager r) {
    r.child('/',child: (context) => const HomePage());
  }

}