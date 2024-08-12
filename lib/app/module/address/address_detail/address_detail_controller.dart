import 'package:cuidapet/app/entitys/address_entity.dart';
import 'package:cuidapet/app/models/place_model.dart';
import 'package:cuidapet/app/service/address_servicec/adress_service.dart';
import 'package:cuidapet/core/ui/widgets/Loader.dart';
import 'package:mobx/mobx.dart';
part 'address_detail_controller.g.dart';

class AddressDetailController = AddressDetailControllerBase with _$AddressDetailController;

abstract class AddressDetailControllerBase with Store {
  final AddressService _addressService;
  AddressDetailControllerBase({required AddressService service})
  : _addressService = service;

 
 @readonly
 AddressEntity? _addressEntity;
  
  Future<void> saveAddress(PlaceModel placeModel,String additional) async{
      Loader.show();
      final resultAddresEntity  = await _addressService.saveAddress(placeModel, additional);
      Loader.hide();
      _addressEntity = resultAddresEntity;
  }
 
}