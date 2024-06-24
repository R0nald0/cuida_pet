import 'package:cuidapet/core/helpers/enviroments.dart';
import 'package:cuidapet/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AppConfig {
  Future<void> configureApp() async {
      WidgetsFlutterBinding.ensureInitialized();
     await _firebaseCoreConfig();
     await _loadEnvs();
  }

}

Future<void> _loadEnvs()=>Enviroments.loadEnvs(); 
Future<void> _firebaseCoreConfig()  async{
  await   Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}