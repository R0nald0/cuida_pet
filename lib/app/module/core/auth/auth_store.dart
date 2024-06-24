import 'package:cuidapet/app/models/user_model.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';
class AuthStore = _AuthStoreBase with _$AuthStore;
abstract class _AuthStoreBase with Store{

  @readonly
  UserModel? _userModel;

  @action
  Future<void> loadUserLogged() async{
    _userModel =  UserModel.empty();
      
      // await Future.delayed(const Duration(seconds: 3));
      // _userModel = UserModel.fromMap({'email' : 'email.com'});
  }

}