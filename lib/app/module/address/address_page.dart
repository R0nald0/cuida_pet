
import 'package:cuidapet/app/models/place_model.dart';
import 'package:cuidapet/app/module/address/addres_search/address_search_controller.dart';
import 'package:cuidapet/app/module/address/address_controller.dart';
import 'package:cuidapet/core/life_cycle/page_lificycle_state.dart';
import 'package:cuidapet/core/mixins/location_mixin.dart';
import 'package:cuidapet/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';


    
part 'widgets/addres_item.dart';
part 'addres_search/widget/address_search_widget.dart';

class AddressPage extends StatefulWidget {

  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends PageLificycleState<AddressController,AddressPage> with LocationMixin{
  final AddressController _addressController = Modular.get<AddressController>();
  final reactionDisposers = <ReactionDisposer>[];
 @override
  void initState() {
    super.initState();
  
    final reactioonsDisposerServiceUnavalable  = 
       reaction<bool>((_) => controller.locationSeriviceUnavalible, 
         (locationSeriviceUnavalible) { 
            if (locationSeriviceUnavalible) {
                showDialogServiceUnavailable();
            }
         });
    final rectionDisposerLocations = 
       reaction<LocationPermission?>((_) => controller.locationPermission, (locationPermission) { 
         if(locationPermission != null && locationPermission == LocationPermission.denied ){
              showDialogLocationDanied (tryAgain: () => controller.myLocation());
         }else if(locationPermission != null && locationPermission == LocationPermission.deniedForever){
            showDialogLocationDaniedForever();
         }
       }) ;
    
    reactionDisposers.addAll([reactioonsDisposerServiceUnavalable,rectionDisposerLocations]);  
  }

  @override
  void dispose() {
    for (var reaction in reactionDisposers) {
        reaction();
    }
    super.dispose();
  }

  void showDialogServiceUnavailable(){
     showDialog(
      context: context, 
      builder: (contextDialog) {
         return AlertDialog(
          title: const Text("Precisamos da sua Localizção"),
          content: const Text('Para melhor uso do app,precisamos que você ative o GPS'),
          actions: [
             TextButton(onPressed: (){
               Navigator.of(contextDialog).pop();
             }, child: const Text('Cancelar')),
             TextButton(onPressed: (){
                 Navigator.of(contextDialog).pop();
                 Geolocator.openLocationSettings();
             }, child: const Text('Abrir Configurações'))
          ],
         );
       }
      );
  }
  


  @override
  Widget build(BuildContext context) {
    print( "CONTROLLEEEEEEEEEEE  ${controller.placeModel.toString()}");
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        final hasAddress  = await controller.addressWasSelected();
          if (hasAddress) {
            Modular.to.pop();
          }else{
            return;
          }
      },
      child: Scaffold(
        appBar: AppBar(
         iconTheme: IconThemeData(color: context.primaryColor),
         backgroundColor: Colors.white,
         elevation: 0,
        ),
        backgroundColor: Colors.white,
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
            children: [
             const  SizedBox(height: 20,),
              Text("Adicione ou escolha um endereço",
               style: context.textThem.headlineLarge?.copyWith(
                 color: Colors.black,
                 fontWeight: FontWeight.bold
               ),
              ),
              const SizedBox(
               height: 10,
            ),
            Observer(
              builder: (_) {
               return  _AddressSearchWidget(
                  key: UniqueKey(),
                  addressSelectedCallback: (place){
                  controller.goToAddressDetailPage(place);
             },
              placeModel: controller.placeModel,
             );
            })
             ,
             /*  Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(30),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    )
                  ),
                ),
              ), */
            const SizedBox(height: 20,),
               ListTile(
                onTap: () => controller.myLocation(),
              leading: const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red,
                child: Icon(Icons.near_me,
                color: Colors.white,
                ),
              ),
               title: const Text("Localização Atual",
               style: TextStyle(
                fontSize: 18,
                color: Colors.black
               ),),
               trailing: const Icon(Icons.arrow_forward_ios),
             ),
             const SizedBox(
                height: 20,
             ),
              
             
              Observer(
                builder: (_) {
                  return Column(
                  children: 
                    _addressController.address
                    .map((e) => AddressItem(
                      address: e.address ?? '',
                      addtional: e.addtional ?? '',
                      onTap: (){
                      controller.selectedAddress(e) ;
                    },
                  
                    )).toList()
                  
                  );
                }
              )
             
            ],
          
            ),
          ),
        ),
      ),
    );
  }
}