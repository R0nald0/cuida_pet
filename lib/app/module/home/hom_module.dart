import 'package:cuidapet/app/module/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomModule  extends Module{

  @override
  void routes(RouteManager r) {
    r.child('/',child: (context) => const HomePage());
  }

}