import 'package:cuidapet/app/models/place_model.dart';

import '../../entitys/address_entity.dart';

abstract class AddressService {
  Future<List<PlaceModel>> findAdress(String address);
  Future<List<AddressEntity>> getAddressEntitys();
  Future<AddressEntity> saveAddress(PlaceModel placeModel , String addtional);
  Future<void> deleteAll();

  Future<void> selectAddress(AddressEntity  addressEntity );
  Future<AddressEntity?> getAddressSelected();
}
