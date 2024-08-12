import 'package:cuidapet/app/entitys/address_entity.dart';
import 'package:cuidapet/app/models/supplier_category_model.dart';
import 'package:cuidapet/app/models/supplier_model.dart';
import 'package:cuidapet/app/models/supplier_near_by_me_model.dart';
import 'package:cuidapet/app/models/supplier_service_model.dart';
import 'package:cuidapet/app/repository/supplier_category_repository/supplier_category_repository.dart';
import 'package:cuidapet/app/service/supplier/supplier_category_service.dart';

class SuplierCategoryServiceImpl implements SupplierCategoryService {
  final SupplierCategoryRepository _categoryRepository;
  SuplierCategoryServiceImpl({required SupplierCategoryRepository repository})
      : _categoryRepository = repository;

  @override
  Future<List<SupplierCategoryModel>> getAllCategories() =>
      _categoryRepository.getCategories();

  @override
  Future<List<SupplierNearByMeModel>> findNearByMe(
          AddressEntity addressEntity) =>
      _categoryRepository.findNearByMe(addressEntity);

  @override
  Future<SupplierModel> findByid(int id)=> _categoryRepository.findById(id);

  @override
  Future<List<SupplierServiceModel>> findSupplierService(int idSupplier)=>_categoryRepository.findSupplierService(idSupplier);
}
