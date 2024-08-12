import 'package:cuidapet/app/entitys/address_entity.dart';
import 'package:cuidapet/app/models/supplier_category_model.dart';
import 'package:cuidapet/app/models/supplier_model.dart';
import 'package:cuidapet/app/models/supplier_near_by_me_model.dart';
import 'package:cuidapet/app/models/supplier_service_model.dart';
import 'package:cuidapet/app/repository/supplier_category_repository/supplier_category_repository.dart';
import 'package:cuidapet/core/exceptions/failure.dart';
import 'package:cuidapet/core/logger/app_logger.dart';
import 'package:cuidapet/core/rest_client/rest_client.dart';
import 'package:cuidapet/core/rest_client/rest_client_exception.dart';

class SupplierCategoryRepositoryImpl implements SupplierCategoryRepository {
  final RestClient _restClient;
  final AppLogger _logger;

  SupplierCategoryRepositoryImpl(
      {required RestClient client, required AppLogger logger})
      : _restClient = client,
        _logger = logger;

  @override
  Future<List<SupplierCategoryModel>> getCategories() async {
    try {
      final result = await _restClient.auth().get('/categories/');
      return result.data
          ?.map<SupplierCategoryModel>(
              (category) => SupplierCategoryModel.fromMap(category))
          .toList();
    } on RestClientException catch (e, s) {
      const message = "Erro ao buscar categorias";
      _logger.error(message, e, s);
      throw Failure(message: message);
    }
  }

  @override
  Future<List<SupplierNearByMeModel>> findNearByMe(
      AddressEntity addressEntity) async {
    try {
      final result = await _restClient.auth().get('/suppliers/',
          queryParameters: {
            'lat': -23.561582579667252,
            'lng': -46.65533915409285
          });

      return result.data
          ?.map<SupplierNearByMeModel>((e) => SupplierNearByMeModel.fromMap(e))
          .toList();
    } on RestClientException catch (e, s) {
      const message = 'Erro ao buscar Fonecedores perto da sua localização';
      _logger.error(message, e, s);
      throw Failure(message: message);
    }
  }

  @override
  Future<SupplierModel> findById(int id) async {
    try {
      final result = await _restClient.auth().get('/suppliers/$id');
      return SupplierModel.fromMap(result.data);
    } on RestClientException catch (e, s) {
      const messsage = "erroa ao busrcar supplier po id";
      _logger.error(messsage, e, s);
      throw Failure(message: messsage);
    }
  }

  @override
  Future<List<SupplierServiceModel>> findSupplierService(int idSupplier) async {
    try {
      final result =
          await _restClient.auth().get('/suppliers/$idSupplier/services');
      return result.data
              ?.map<SupplierServiceModel>((supplierJson) => SupplierServiceModel.fromMap(supplierJson)).toList() ??
          <SupplierServiceModel>[];
    } on RestClientException catch (e, s) {
      const message = 'Erro ao buscas Lista de serviços do fornecedor';
      _logger.error(message, e, s);
      throw Failure(message: message);
    }
  }
}
