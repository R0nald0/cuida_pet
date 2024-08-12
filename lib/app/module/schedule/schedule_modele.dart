
import 'package:cuidapet/app/module/schedule/schedule_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ScheduleModele  extends Module{
  @override
  void routes(RouteManager r) {
  
    super.routes(r);
    r.child(Modular.initialRoute, child:(_) => SchedulePage(schedule: r.args.data,));
  }

}