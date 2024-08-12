import 'package:cuidapet/app/models/place_model.dart';
import 'package:cuidapet/app/module/address/address_detail/address_detail_controller.dart';
import 'package:cuidapet/core/ui/extensions/size_screenn_extension.dart';
import 'package:cuidapet/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet/core/ui/widgets/cuidapet_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

class AddressDetailPage extends StatefulWidget {
  final PlaceModel placeModel;
  const AddressDetailPage({super.key, required this.placeModel});

  @override
  _AddressDetailPageState createState() => _AddressDetailPageState();
}

class _AddressDetailPageState extends State<AddressDetailPage> {
  final _additionalEC = TextEditingController();
  final controllerAddressDetail = Modular.get<AddressDetailController>();
  late final ReactionDisposer addressReactionDisposer;
  final place = Modular.args.data as PlaceModel;

  
 @override
  void initState() {
     addressReactionDisposer = reaction((_) => controllerAddressDetail.addressEntity, (addressEntity) { 
             if (addressEntity != null) {
                 Navigator.pop(context,addressEntity);
             }    
     });
    super.initState();
  }

@override
  void dispose() {
    _additionalEC.dispose();
     addressReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                'Confirme Seu Endereço',
                style: context.textThem.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 450.h.toDouble(),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(place.lat, place.long),
                  zoom: 16
                ),
                markers: {
                  Marker(
                      markerId: const MarkerId('Address'),
                      position: LatLng(
                        place.lat,
                        place.long,
                      ),
                      infoWindow: InfoWindow(title: place.address))
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                readOnly: true,
                initialValue: place.address,
                decoration:  InputDecoration(
                    label: const Text("Endereço"), 
                    suffix: IconButton(
                      onPressed: (){
                        Navigator.of(context).pop(place);
                      }, 
                      icon:const Icon(Icons.edit)
                      ),
                    ),
              ),
            ),
            const SizedBox(height: 10,),
             Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: _additionalEC,
                decoration: const InputDecoration(
                    label: Text("Complemento")),
              ),
            ),
          
            const SizedBox(height: 20, ),
            CuidapetDefaultButton(
              height: 45.h.toDouble(),
              width: 120.h.toDouble(),
                onPressed: () {
                   FocusScopeNode().unfocus();
                   controllerAddressDetail.saveAddress(place, _additionalEC.text);
                },
                label: 'Salvar',
              ),
                const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
