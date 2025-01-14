// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  late final _$_userModelAtom =
      Atom(name: 'AuthStoreBase._userModel', context: context);

  UserModel? get userModel {
    _$_userModelAtom.reportRead();
    return super._userModel;
  }

  @override
  UserModel? get _userModel => userModel;

  @override
  set _userModel(UserModel? value) {
    _$_userModelAtom.reportWrite(value, super._userModel, () {
      super._userModel = value;
    });
  }

  late final _$loadUserLoggedAsyncAction =
      AsyncAction('AuthStoreBase.loadUserLogged', context: context);

  @override
  Future<void> loadUserLogged() {
    return _$loadUserLoggedAsyncAction.run(() => super.loadUserLogged());
  }

  late final _$logoutAsyncAction =
      AsyncAction('AuthStoreBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
