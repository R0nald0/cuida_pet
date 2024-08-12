import 'package:cuidapet/app/entitys/address_entity.dart';
import 'package:cuidapet/app/models/place_model.dart';
import 'package:cuidapet/app/service/address_servicec/adress_service.dart';
import 'package:cuidapet/core/life_cycle/controller_lifecylce.dart';
import 'package:cuidapet/core/router_cuida_pet.dart';
import 'package:cuidapet/core/ui/widgets/Loader.dart';
import 'package:cuidapet/core/ui/widgets/message.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
part 'address_controller.g.dart';

class AddressController = AddressControllerBase with _$AddressController;

abstract class AddressControllerBase with Store, ControllerLifecylce {
  final AddressService _addressService;

  AddressControllerBase({required AddressService serviceAddress})
      : _addressService = serviceAddress;

  @readonly
  var _address = <AddressEntity>[];
  
  @readonly
  var _locationSeriviceUnavalible = false;

  @readonly
  LocationPermission? _locationPermission;

  @readonly 
 
   PlaceModel?  _placeModel;

  @override
  void onReady() {
    getAddresses();
    super.onReady();
  }

  @action
  Future<void> getAddresses() async {
    Loader.show();
    _address = await _addressService.getAddressEntitys();
    Loader.hide();
  }

  @action
  Future<void> myLocation() async {
    _locationPermission = null;
    _locationSeriviceUnavalible =false;

    final serviceEnable = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnable) {
      _locationSeriviceUnavalible = true;
      return;
    }

    final locationPermission = await Geolocator.checkPermission();

    switch (locationPermission) {
      case LocationPermission.denied:
        final permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          _locationPermission = permission;
          return;
        } 
        break;
      case LocationPermission.deniedForever:
        _locationPermission = locationPermission;
        return;

      case LocationPermission.whileInUse:
      case LocationPermission.always:
      case LocationPermission.unableToDetermine:
        break;
    }

    Loader.show();

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final placeMark =
        await placemarkFromCoordinates(position.latitude, position.latitude);
    final place = placeMark.first;

    final address = "${place.thoroughfare},${place.subThoroughfare}";
    
    final placeModel = PlaceModel(
      address: address , 
      lat: position.latitude, 
      long: position.longitude
      );
      Loader.hide();
      goToAddressDetailPage(placeModel);
  }


  Future<void> goToAddressDetailPage(PlaceModel placeModel) async {
    final address =await Modular.to.pushNamed(RouterCuidaPet.ADDRESS_DETAIL_ROUTE,arguments: placeModel);
  
  if (address is PlaceModel) {
      _placeModel = address; 
    }
    else if(address is AddressEntity){
        selectedAddress(address);
    }
  

}
  
  
Future<void> selectedAddress(AddressEntity address) async {
    await _addressService.selectAddress(address);
    Modular.to.pop(address);
}

Future<bool> addressWasSelected()async{
   final address = await _addressService.getAddressSelected();
  if (address != null) {
     return true;
  } else {
    Message.alert('Por favors selecione ou cadastre um endereço');
    return false;
  }
}
 


}
