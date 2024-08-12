import 'package:cuidapet/app/models/user_model.dart';
import 'package:cuidapet/app/service/address_servicec/adress_service.dart';
import 'package:cuidapet/core/constants.dart';
import 'package:cuidapet/core/local_storage/loacl_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';
class AuthStore = AuthStoreBase with _$AuthStore;
abstract class AuthStoreBase with Store{

  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final AddressService _addressService;

  AuthStoreBase({required LocalStorage storage,required LocalSecureStorage localSecureStorage ,required AddressService addressService})
  :_localStorage =storage, 
   _localSecureStorage = localSecureStorage,
   _addressService = addressService
  ;


  @readonly
  UserModel? _userModel;

  @action
  Future<void> loadUserLogged() async{
      
    final userLogged  =  await _localStorage.read<String>(Constants.LOCAL_STORAGE_USER_DATA_LOGGED);
     
      if (userLogged != null) {
          _userModel = UserModel.fromJson(userLogged);
      }else{
        _userModel = UserModel.empty();
      }


      FirebaseAuth.instance.authStateChanges()
      .listen((user) async {
            if (user == null) {
             await logout();
            }
       });
  
  }

  @action
  Future<void> logout() async{
      _localStorage.clear();
      _localSecureStorage.clear();
      _addressService.deleteAll();
      _userModel = UserModel.empty();
            
  }
}