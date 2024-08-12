import 'package:cuidapet/app/entitys/address_entity.dart';
import 'package:cuidapet/app/models/supplier_category_model.dart';
import 'package:cuidapet/app/models/supplier_near_by_me_model.dart';
import 'package:cuidapet/app/service/address_servicec/adress_service.dart';
import 'package:cuidapet/app/service/supplier/supplier_category_service.dart';
import 'package:cuidapet/core/life_cycle/controller_lifecylce.dart';
import 'package:cuidapet/core/router_cuida_pet.dart';
import 'package:cuidapet/core/ui/widgets/Loader.dart';
import 'package:cuidapet/core/ui/widgets/message.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

enum SupplierPageType { list, grid }

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifecylce {
  final AddressService _addressService;
  final SupplierCategoryService _supplierCategoryService;
  late ReactionDisposer reactionDisposerSupplierNear;

  @readonly
  AddressEntity? _addressEntity;

  @readonly
  var _listCategories = <SupplierCategoryModel>[];

  @readonly
  var _supplierPageType = SupplierPageType.list;

  @readonly
  var _supplierListNears = <SupplierNearByMeModel>[];
  var _supplierListNearsCache = <SupplierNearByMeModel>[];

  @readonly
  SupplierCategoryModel? _supplierFilerSelected;

  String _searchText = '';

  HomeControllerBase(
      {required AddressService addressService,
      required SupplierCategoryService categoryService})
      : _addressService = addressService,
        _supplierCategoryService = categoryService;

  @override
  void onInit([Map<String, dynamic>? params]) {
    super.onInit(params);

    reactionDisposerSupplierNear = reaction((_) => _addressEntity, (address) {
      findSuppliersNearMe();
    });
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    try {
      Loader.show();
      _getAddresses();
      _getCategories();
    } finally {
      Loader.hide();
    }
  }

  @action
  Future<void> _getAddresses() async {
    _addressEntity ??= await _addressService.getAddressSelected();
    if (_addressEntity == null) {
      await goToAddressPage();
    }
  }

  @action
  Future<void> goToAddressPage() async {
    final address =
        await Modular.to.pushNamed<AddressEntity>(RouterCuidaPet.ADDRESS_ROUTE);
    if (address != null) {
      _addressEntity = address;
    }
  }

  @action
  Future<void> _getCategories() async {
    try {
      final categories = await _supplierCategoryService.getAllCategories();
      _listCategories = [...categories];
    } catch (e) {
      Message.alert("erro ao buscar categorias");
      throw Exception();
    }
  }

  void changeTabSuppplier(SupplierPageType type) {
    _supplierPageType = type;
  }

  @action
  Future<void> findSuppliersNearMe() async {
    if (_addressEntity != null) {
      final listSuppliers =
          await _supplierCategoryService.findNearByMe(_addressEntity!);
      _supplierListNears = [...listSuppliers];
      _supplierListNearsCache = [...listSuppliers];
      filterSupplier();
    } else {
      Message.info('Nenhum estabelecimento próximo ao seu endereço');
    }
  }

  @action
  void filterSupplierCategory(SupplierCategoryModel categoryModel) {
    if (_supplierFilerSelected == categoryModel) {
      _supplierFilerSelected = null;
    } else {
      _supplierFilerSelected = categoryModel;
    }
    filterSupplier();
  }

  void filterByName(String name) {
    _searchText = name;
    filterSupplier();
  }

  @action
  void filterSupplier() {
    var suppliers = [..._supplierListNearsCache];
    if (_supplierFilerSelected != null) {
      suppliers = suppliers
          .where((supllier) => supllier.category == _supplierFilerSelected?.id)
          .toList();
    }

    if (_searchText.isNotEmpty) {
      suppliers = suppliers
          .where((element) =>
              element.name.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
    }

    _supplierListNears = [...suppliers];
  }

  @override
  void dispose() {
    reactionDisposerSupplierNear();
    super.dispose();
  }
}
