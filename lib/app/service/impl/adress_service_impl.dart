import 'package:cuidapet/app/entitys/address_entity.dart';
import 'package:cuidapet/app/models/place_model.dart';
import 'package:cuidapet/app/repository/address/address_repository.dart';
import 'package:cuidapet/app/service/address_servicec/adress_service.dart';
import 'package:cuidapet/core/constants.dart';
import 'package:cuidapet/core/local_storage/loacl_storage.dart';

class AdressServiceImpl implements AddressService {
  final LocalStorage _localStorage;

  final AddressRepository _addressRepository;

  AdressServiceImpl(
      {required AddressRepository repository, required LocalStorage storage})
      : _addressRepository = repository,
        _localStorage = storage;

  @override
  Future<List<PlaceModel>> findAdress(String address) =>
      _addressRepository.findAddressByGoogle(address);

  @override
  Future<void> deleteAll() => _addressRepository.deleteAll();

  @override
  Future<List<AddressEntity>> getAddressEntitys() =>
      _addressRepository.getAddressEntitys();

  @override
  Future<AddressEntity> saveAddress(
      PlaceModel placeModel, String addtional) async {
    final addressEntity = AddressEntity(
        address: placeModel.address,
        addtional: addtional,
        lat: placeModel.lat,
        long: placeModel.lat);
    final addresid = await _addressRepository.saveAddress(addressEntity);

    return addressEntity.copyWith(id: addresid);
  }

  @override
  Future<AddressEntity?> getAddressSelected() async {
    final addressSeleceted = await _localStorage
        .read<String>(Constants.LOCAL_STORAGE_DEFAULT_ADDRESS_DATA_KEY);
    if (addressSeleceted != null) {
      return AddressEntity.fromJson(addressSeleceted);
    }
    return null;
  }

  @override
  Future<void> selectAddress(AddressEntity addressEntity) async {
    await _localStorage.write<String>(
        Constants.LOCAL_STORAGE_DEFAULT_ADDRESS_DATA_KEY,
        addressEntity.toJson());
  }
}
