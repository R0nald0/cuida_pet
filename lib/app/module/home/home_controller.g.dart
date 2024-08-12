// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  late final _$_addressEntityAtom =
      Atom(name: 'HomeControllerBase._addressEntity', context: context);

  AddressEntity? get addressEntity {
    _$_addressEntityAtom.reportRead();
    return super._addressEntity;
  }

  @override
  AddressEntity? get _addressEntity => addressEntity;

  @override
  set _addressEntity(AddressEntity? value) {
    _$_addressEntityAtom.reportWrite(value, super._addressEntity, () {
      super._addressEntity = value;
    });
  }

  late final _$_listCategoriesAtom =
      Atom(name: 'HomeControllerBase._listCategories', context: context);

  List<SupplierCategoryModel> get listCategories {
    _$_listCategoriesAtom.reportRead();
    return super._listCategories;
  }

  @override
  List<SupplierCategoryModel> get _listCategories => listCategories;

  @override
  set _listCategories(List<SupplierCategoryModel> value) {
    _$_listCategoriesAtom.reportWrite(value, super._listCategories, () {
      super._listCategories = value;
    });
  }

  late final _$_supplierPageTypeAtom =
      Atom(name: 'HomeControllerBase._supplierPageType', context: context);

  SupplierPageType get supplierPageType {
    _$_supplierPageTypeAtom.reportRead();
    return super._supplierPageType;
  }

  @override
  SupplierPageType get _supplierPageType => supplierPageType;

  @override
  set _supplierPageType(SupplierPageType value) {
    _$_supplierPageTypeAtom.reportWrite(value, super._supplierPageType, () {
      super._supplierPageType = value;
    });
  }

  late final _$_supplierListNearsAtom =
      Atom(name: 'HomeControllerBase._supplierListNears', context: context);

  List<SupplierNearByMeModel> get supplierListNears {
    _$_supplierListNearsAtom.reportRead();
    return super._supplierListNears;
  }

  @override
  List<SupplierNearByMeModel> get _supplierListNears => supplierListNears;

  @override
  set _supplierListNears(List<SupplierNearByMeModel> value) {
    _$_supplierListNearsAtom.reportWrite(value, super._supplierListNears, () {
      super._supplierListNears = value;
    });
  }

  late final _$_supplierFilerSelectedAtom =
      Atom(name: 'HomeControllerBase._supplierFilerSelected', context: context);

  SupplierCategoryModel? get supplierFilerSelected {
    _$_supplierFilerSelectedAtom.reportRead();
    return super._supplierFilerSelected;
  }

  @override
  SupplierCategoryModel? get _supplierFilerSelected => supplierFilerSelected;

  @override
  set _supplierFilerSelected(SupplierCategoryModel? value) {
    _$_supplierFilerSelectedAtom
        .reportWrite(value, super._supplierFilerSelected, () {
      super._supplierFilerSelected = value;
    });
  }

  late final _$_getAddressesAsyncAction =
      AsyncAction('HomeControllerBase._getAddresses', context: context);

  @override
  Future<void> _getAddresses() {
    return _$_getAddressesAsyncAction.run(() => super._getAddresses());
  }

  late final _$goToAddressPageAsyncAction =
      AsyncAction('HomeControllerBase.goToAddressPage', context: context);

  @override
  Future<void> goToAddressPage() {
    return _$goToAddressPageAsyncAction.run(() => super.goToAddressPage());
  }

  late final _$_getCategoriesAsyncAction =
      AsyncAction('HomeControllerBase._getCategories', context: context);

  @override
  Future<void> _getCategories() {
    return _$_getCategoriesAsyncAction.run(() => super._getCategories());
  }

  late final _$findSuppliersNearMeAsyncAction =
      AsyncAction('HomeControllerBase.findSuppliersNearMe', context: context);

  @override
  Future<void> findSuppliersNearMe() {
    return _$findSuppliersNearMeAsyncAction
        .run(() => super.findSuppliersNearMe());
  }

  late final _$HomeControllerBaseActionController =
      ActionController(name: 'HomeControllerBase', context: context);

  @override
  void filterSupplierCategory(SupplierCategoryModel categoryModel) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.filterSupplierCategory');
    try {
      return super.filterSupplierCategory(categoryModel);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterSupplier() {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.filterSupplier');
    try {
      return super.filterSupplier();
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
