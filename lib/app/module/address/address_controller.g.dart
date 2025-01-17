// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressController on AddressControllerBase, Store {
  late final _$_addressAtom =
      Atom(name: 'AddressControllerBase._address', context: context);

  List<AddressEntity> get address {
    _$_addressAtom.reportRead();
    return super._address;
  }

  @override
  List<AddressEntity> get _address => address;

  @override
  set _address(List<AddressEntity> value) {
    _$_addressAtom.reportWrite(value, super._address, () {
      super._address = value;
    });
  }

  late final _$_locationSeriviceUnavalibleAtom = Atom(
      name: 'AddressControllerBase._locationSeriviceUnavalible',
      context: context);

  bool get locationSeriviceUnavalible {
    _$_locationSeriviceUnavalibleAtom.reportRead();
    return super._locationSeriviceUnavalible;
  }

  @override
  bool get _locationSeriviceUnavalible => locationSeriviceUnavalible;

  @override
  set _locationSeriviceUnavalible(bool value) {
    _$_locationSeriviceUnavalibleAtom
        .reportWrite(value, super._locationSeriviceUnavalible, () {
      super._locationSeriviceUnavalible = value;
    });
  }

  late final _$_locationPermissionAtom =
      Atom(name: 'AddressControllerBase._locationPermission', context: context);

  LocationPermission? get locationPermission {
    _$_locationPermissionAtom.reportRead();
    return super._locationPermission;
  }

  @override
  LocationPermission? get _locationPermission => locationPermission;

  @override
  set _locationPermission(LocationPermission? value) {
    _$_locationPermissionAtom.reportWrite(value, super._locationPermission, () {
      super._locationPermission = value;
    });
  }

  late final _$_placeModelAtom =
      Atom(name: 'AddressControllerBase._placeModel', context: context);

  PlaceModel? get placeModel {
    _$_placeModelAtom.reportRead();
    return super._placeModel;
  }

  @override
  PlaceModel? get _placeModel => placeModel;

  @override
  set _placeModel(PlaceModel? value) {
    _$_placeModelAtom.reportWrite(value, super._placeModel, () {
      super._placeModel = value;
    });
  }

  late final _$getAddressesAsyncAction =
      AsyncAction('AddressControllerBase.getAddresses', context: context);

  @override
  Future<void> getAddresses() {
    return _$getAddressesAsyncAction.run(() => super.getAddresses());
  }

  late final _$myLocationAsyncAction =
      AsyncAction('AddressControllerBase.myLocation', context: context);

  @override
  Future<void> myLocation() {
    return _$myLocationAsyncAction.run(() => super.myLocation());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
