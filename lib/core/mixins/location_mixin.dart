
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

typedef TryAgain = void Function();
mixin LocationMixin<e extends StatefulWidget> on State<e>{
    void showDialogServiceUnavailable(){
     showDialog(
      context: context, 
      builder: (contextDialog) {
         return AlertDialog(
          title: const Text("Precisamos da sua Localizção"),
          content: const Text('Para melhor uso do app,precisamos que você ative o GPS'),
          actions: [
             TextButton(onPressed: (){
               Navigator.of(contextDialog).pop();
             }, child: const Text('Cancelar')),
             TextButton(onPressed: (){
                 Navigator.of(contextDialog).pop();
                 Geolocator.openLocationSettings();
             }, child: const Text('Abrir Configurações'))
          ],
         );
       }
      );
  }
  void showDialogLocationDanied({TryAgain? tryAgain}){
 showDialog(
      context: context, 
      builder: (contextDialog) {
         return AlertDialog(
          title: const Text("Precisamos da sua Localizção"),
          content: const Text('Para melhor uso do app,precisamos que você autorize a utilização'),
          actions: [
             TextButton(onPressed: (){
               Navigator.of(contextDialog).pop();
             }, child: const Text('Cancelar')),
             TextButton(onPressed: (){
                 Navigator.of(contextDialog).pop();
                 if (tryAgain != null) {
                    tryAgain();
                 }
             }, child: const Text('Tentar novamente'))
          ],
         );
       }
      );

  }
  void showDialogLocationDaniedForever(){
      showDialog(
      context: context, 
      builder: (contextDialog) {
         return AlertDialog(
          title: const Text("Precisamos da sua Localizção"),
          content: const Text('Para melhor uso do app,precisamos que você  altere em configuracão e autorize a utilização '),
          actions: [
             TextButton(onPressed: (){
               Navigator.of(contextDialog).pop();
             }, child: const Text('Cancelar')),
             TextButton(onPressed: (){
                 Navigator.of(contextDialog).pop();
                 Geolocator.openLocationSettings();
             }, child: const Text('Abrir Configurações'))
          ],
         );
       }
      );
  }  
}