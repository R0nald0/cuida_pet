import 'package:cuidapet/app/module/core/auth/auth_store.dart';
import 'package:cuidapet/app/repository/address/address_repository.dart';
import 'package:cuidapet/app/repository/address/impl/AddressRepositoryImpl.dart';
import 'package:cuidapet/app/repository/supplier_category_repository/impl/supplier_category_repository_Impl.dart';
import 'package:cuidapet/app/repository/supplier_category_repository/supplier_category_repository.dart';

import 'package:cuidapet/app/service/address_servicec/adress_service.dart';
import 'package:cuidapet/app/service/impl/adress_service_impl.dart';
import 'package:cuidapet/app/service/supplier/impl/suplier_category_service_impl.dart';
import 'package:cuidapet/app/service/supplier/supplier_category_service.dart';

import 'package:cuidapet/core/database/sqllite_connection_factory.dart';
import 'package:cuidapet/core/local_storage/loacl_storage.dart';
import 'package:cuidapet/core/local_storage/local_secure_storage_impl.dart';
import 'package:cuidapet/core/local_storage/shared_preferences_local_storage_impl.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:cuidapet/core/logger/app_logger_impl.dart';
import 'package:cuidapet/core/rest_client/dio/dio_rest_client.dart';
import 'package:cuidapet/core/rest_client/rest_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void binds(Injector i) {}
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton(SqlliteConnectionFactory.new);
    i.addLazySingleton<AuthStore>(() => AuthStore(
        storage: Modular.get(),
        localSecureStorage: Modular.get(),
        addressService: Modular.get()));
    i.addLazySingleton<LocalStorage>(SharedPreferencesLocalStorageImpl.new);
    i.addLazySingleton<LocalSecureStorage>(LocalSecureStorageImpl.new);
    i.addLazySingleton<AppLogger>(AppLoggerImpl.new);
    i.addLazySingleton<RestClient>(() => DioRestClient(
        secureStorage: Modular.get(),
        logger: Modular.get(),
        storage: Modular.get(),
        authStore: Modular.get()));
    i.addLazySingleton<AddressRepository>(
        () => AddressRepositoryImpl(sqliteCont: Modular.get()));
    i.addLazySingleton<AddressService>(() =>
        AdressServiceImpl(repository: Modular.get(), storage: Modular.get()));
        
      i.addLazySingleton<SupplierCategoryRepository>(
       ()=>  SupplierCategoryRepositoryImpl(
        client: Modular.get(), 
        logger: Modular.get()
        ),);    
     i.addLazySingleton<SupplierCategoryService>(
       ()=>  SuplierCategoryServiceImpl(
        repository: Modular.get()
        ),);  
  }
  
}
