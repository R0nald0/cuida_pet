import 'package:asuka/asuka.dart';

class Message {

  Message._();
 
 static alert(String message){
  AsukaSnackbar.alert(message).show();
 }

 static info(String info){
  AsukaSnackbar.info(info).show();
 }

}