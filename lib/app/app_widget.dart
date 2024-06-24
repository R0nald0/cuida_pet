import 'package:cuidapet/core/ui/ui_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:asuka/asuka.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AppWidget extends StatelessWidget {

  const AppWidget({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/auth/');
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