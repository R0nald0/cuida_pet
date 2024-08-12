
import 'package:cuidapet/core/database/sqllite_connection_factory.dart';
import 'package:flutter/material.dart';

class SqlliteAdmConnection with WidgetsBindingObserver{
   @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
      final connection = SqlliteConnectionFactory();
     switch (state) {
       case AppLifecycleState.resumed:
        break;
       case AppLifecycleState.inactive:
       case AppLifecycleState.hidden:
       case AppLifecycleState.paused:
       case AppLifecycleState.detached:
         connection.closeConnection();
         break;
      
       
     }
    super.didChangeAppLifecycleState(state);
  }
}