import 'package:cuidapet/core/database/sqllite_adm_connection.dart';
import 'package:cuidapet/core/router_cuida_pet.dart';
import 'package:cuidapet/core/ui/ui_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:asuka/asuka.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AppWidget extends StatefulWidget {

  const AppWidget({ super.key });

  @override
  State<AppWidget> createState() => _AppWidgetState();
}


class _AppWidgetState extends State<AppWidget> {

  final sqlliteAdmConnection = SqlliteAdmConnection();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(sqlliteAdmConnection);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqlliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(RouterCuidaPet.AUTH_ROUTE);
    Modular.setObservers([
      Asuka.asukaHeroController
    ]);
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MaterialApp.router(
        builder: Asuka.builder,
        title: UiConfig.title,
        theme: UiConfig.theme,
        routerConfig: Modular.routerConfig,
    
      ),
    );
  }
}