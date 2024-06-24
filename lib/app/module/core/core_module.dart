import 'package:cuidapet/app/module/core/auth/auth_store.dart';

import 'package:cuidapet/core/local_storage/loacl_storage.dart';
import 'package:cuidapet/core/local_storage/local_secure_storage_impl.dart';
import 'package:cuidapet/core/local_storage/shared_preferences_local_storage_impl.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:cuidapet/core/logger/app_logger_impl.dart';

import 'package:cuidapet/core/rest_client/dio/dio_rest_client.dart';
import 'package:cuidapet/core/rest_client/rest_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule  extends Module{
   @override
  void binds(Injector i) {
    
  }
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<AuthStore>(AuthStore.new);
    i.addLazySingleton<LocalStorage>(SharedPreferencesLocalStorageImpl.new);
    i.addLazySingleton<LocalSecureStorage>(LocalSecureStorageImpl.new);
    i.addLazySingleton<AppLogger>(AppLoggerImpl.new);
    i.addLazySingleton<RestClient>(
      () => DioRestClient(
        logger: Modular.get(), 
        storage: Modular.get()
        ));
    
  }
   
}