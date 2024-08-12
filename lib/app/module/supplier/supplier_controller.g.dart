// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SupplierController on SupplierControllerBase, Store {
  late final _$_supplierModelAtom =
      Atom(name: 'SupplierControllerBase._supplierModel', context: context);

  SupplierModel? get supplierModel {
    _$_supplierModelAtom.reportRead();
    return super._supplierModel;
  }

  @override
  SupplierModel? get _supplierModel => supplierModel;

  @override
  set _supplierModel(SupplierModel? value) {
    _$_supplierModelAtom.reportWrite(value, super._supplierModel, () {
      super._supplierModel = value;
    });
  }

  late final _$_suppllierServicesAtom =
      Atom(name: 'SupplierControllerBase._suppllierServices', context: context);

  List<SupplierServiceModel> get suppllierServices {
    _$_suppllierServicesAtom.reportRead();
    return super._suppllierServices;
  }

  @override
  List<SupplierServiceModel> get _suppllierServices => suppllierServices;

  @override
  set _suppllierServices(List<SupplierServiceModel> value) {
    _$_suppllierServicesAtom.reportWrite(value, super._suppllierServices, () {
      super._suppllierServices = value;
    });
  }

  late final _$_supplierServicesSelcetedAtom = Atom(
      name: 'SupplierControllerBase._supplierServicesSelceted',
      context: context);

  ObservableList<SupplierServiceModel> get supplierServicesSelceted {
    _$_supplierServicesSelcetedAtom.reportRead();
    return super._supplierServicesSelceted;
  }

  @override
  ObservableList<SupplierServiceModel> get _supplierServicesSelceted =>
      supplierServicesSelceted;

  @override
  set _supplierServicesSelceted(ObservableList<SupplierServiceModel> value) {
    _$_supplierServicesSelcetedAtom
        .reportWrite(value, super._supplierServicesSelceted, () {
      super._supplierServicesSelceted = value;
    });
  }

  late final _$findSupplierByIdAsyncAction =
      AsyncAction('SupplierControllerBase.findSupplierById', context: context);

  @override
  Future<void> findSupplierById() {
    return _$findSupplierByIdAsyncAction.run(() => super.findSupplierById());
  }

  late final _$findSupplierServiceAsyncAction = AsyncAction(
      'SupplierControllerBase.findSupplierService',
      context: context);

  @override
  Future<void> findSupplierService() {
    return _$findSupplierServiceAsyncAction
        .run(() => super.findSupplierService());
  }

  late final _$SupplierControllerBaseActionController =
      ActionController(name: 'SupplierControllerBase', context: context);

  @override
  void addOrRemoveService(SupplierServiceModel modelSerivice) {
    final _$actionInfo = _$SupplierControllerBaseActionController.startAction(
        name: 'SupplierControllerBase.addOrRemoveService');
    try {
      return super.addOrRemoveService(modelSerivice);
    } finally {
      _$SupplierControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
