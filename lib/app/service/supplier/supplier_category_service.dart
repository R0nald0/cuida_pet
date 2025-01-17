import 'package:cuidapet/app/entitys/address_entity.dart';
import 'package:cuidapet/app/models/supplier_category_model.dart';
import 'package:cuidapet/app/models/supplier_model.dart';
import 'package:cuidapet/app/models/supplier_near_by_me_model.dart';
import 'package:cuidapet/app/models/supplier_service_model.dart';

abstract class SupplierCategoryService {
  
  Future<List<SupplierCategoryModel>> getAllCategories();
  Future<List<SupplierNearByMeModel>> findNearByMe(AddressEntity addressEntity);
  Future<SupplierModel> findByid(int id);
  Future <List<SupplierServiceModel>> findSupplierService(int idSupplier);
}