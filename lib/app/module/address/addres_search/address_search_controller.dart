import 'package:cuidapet/app/models/place_model.dart';
import 'package:cuidapet/app/service/address_servicec/adress_service.dart';
import 'package:mobx/mobx.dart';
part 'address_search_controller.g.dart';

class AddressSearchController = AddressSearchControllerBase with _$AddressSearchController;

abstract class AddressSearchControllerBase with Store {
  final AddressService _addressService;

  AddressSearchControllerBase({required AddressService serviceAdress})
  :_addressService = serviceAdress;

  Future<List<PlaceModel>> findAdress(String address) => _addressService.findAdress(address);
 }