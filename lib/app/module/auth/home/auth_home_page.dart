
import 'package:cuidapet/app/models/user_model.dart';
import 'package:cuidapet/app/module/core/auth/auth_store.dart';
import 'package:cuidapet/core/constants.dart';
import 'package:cuidapet/core/ui/extensions/size_screenn_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';


class AuthHomePage extends StatefulWidget {
  final AuthStore _authStore;

   AuthHomePage({Key? key,required AuthStore authStore}):
   _authStore = authStore,
   super(key: key);

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
 
 @override
  void initState() {
     super.initState();
    
    reaction<UserModel?>((_) => widget._authStore.userModel, (userLogged) { 
       
       if (userLogged != null  && userLogged.email.isNotEmpty) {
          Modular.to.navigate('/home/');
          print(userLogged.email);
       } else {
          print( 'user null');
          Modular.to.navigate('/auth/login/');
       }
       
    });
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
        widget._authStore.loadUserLogged();
     });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Constants.logo,
          width: 162.w.toDouble(),
          height: 130.h.toDouble(),
          fit: BoxFit.contain,
          ),
      ),
    );
  }
}