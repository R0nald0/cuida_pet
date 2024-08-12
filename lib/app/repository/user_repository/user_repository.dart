
import 'package:cuidapet/app/models/confirmation_login_model.dart';
import 'package:cuidapet/app/models/social_network_model.dart';
import 'package:cuidapet/app/models/user_model.dart';

abstract class UserRepository {
   Future<void> register(String login,String password);
   Future<String> login(String email, String password);
      
   Future<ConfirmationLoginModel> confirmationLogin();   

   Future<UserModel> getUserLogged();
   Future<String> loginSocial(SocialNetworkModel model);
}