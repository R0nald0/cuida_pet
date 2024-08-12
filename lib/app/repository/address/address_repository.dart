
import 'package:cuidapet/app/entitys/address_entity.dart';
import 'package:cuidapet/app/models/place_model.dart';

abstract class AddressRepository {
  Future<List<PlaceModel>> findAddressByGoogle(String address);
  Future<List<AddressEntity>> getAddressEntitys();
  Future<int> saveAddress(AddressEntity addressEntity);
  Future<void> deleteAll();
}