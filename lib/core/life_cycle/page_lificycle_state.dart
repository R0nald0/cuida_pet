 import 'package:cuidapet/core/life_cycle/controller_lifecylce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class PageLificycleState<C extends ControllerLifecylce ,P extends StatefulWidget>  
    extends State<P> {

   final controller = Modular.get<C>();

   Map<String,dynamic>? get param => null; 
  
  @override
  void initState() {  
    super.initState();
    controller.onInit(param);
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.onReady());
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}