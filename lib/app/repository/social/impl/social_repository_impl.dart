import 'package:cuidapet/app/models/social_network_model.dart';
import 'package:cuidapet/app/repository/social/social_repository.dart';
import 'package:cuidapet/core/exceptions/failure.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialRepositoryImpl implements SocialRepository {
  @override
  Future<SocialNetworkModel> facebookLogin() async {
      final facebookAuth = FacebookAuth.instance;
      final result = await facebookAuth.login();

      switch(result.status){
         case LoginStatus.success :
            final userData = await facebookAuth.getUserData();
             return SocialNetworkModel(
              accessToken: result.accessToken?.tokenString ?? '' ,
              avatar: userData['picture']['data']['url'],
              email: userData['email'],
              id: userData['id'],
              name: userData['name'],
              type: 'Facebook' 
              );   
         case LoginStatus.cancelled :
         throw Failure(message: 'Login cancelado');
         case LoginStatus.failed:
         case LoginStatus.operationInProgress:
         throw Failure(message: result.message ?? 'erro ao logar no facebook');
      }
  }

  @override
  Future<SocialNetworkModel> googleLogin() async {
    final googleSigin = GoogleSignIn();

    if(await googleSigin.isSignedIn()){
      googleSigin.disconnect();
    }

    final gooogleUser = await googleSigin.signIn();
    final googleAuth = await gooogleUser?.authentication;
  
    if (googleAuth != null && gooogleUser != null) {
       return SocialNetworkModel(
        id: googleAuth.idToken ?? '', 
        name: gooogleUser.displayName ??'', 
        email: gooogleUser.email, 
        type: 'GOOGLE', 
        accessToken: googleAuth.accessToken ?? '', 
        avatar: gooogleUser.photoUrl
        );
    }else{
      throw Failure(message: "Erro ao logar com o google");
    }
  }

}