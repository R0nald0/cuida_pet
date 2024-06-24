import 'package:cuidapet/app/app_module.dart';
import 'package:cuidapet/app/app_widget.dart';
import 'package:cuidapet/core/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main()  async{
   await AppConfig().configureApp();


  runApp(ModularApp(
      module:AppModule(), 
      child: const AppWidget()
      ));
}
