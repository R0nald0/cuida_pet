part of '../../address_page.dart';
    

   typedef AddressSelectedCallback = void Function(PlaceModel); 
class _AddressSearchWidget extends StatefulWidget {
  final AddressSelectedCallback  addressSelectedCallback;
  final PlaceModel?  placeModel;

  const _AddressSearchWidget({
     super.key,
     required this.addressSelectedCallback ,
     required this.placeModel
     });

  @override
  _AddressSearchWidgetState createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<_AddressSearchWidget> {
  final controller = Modular.get<AddressSearchController>();
  var  placeLocation = '';

  @override
  void initState() {
    super.initState();
     if (widget.placeModel != null) {
        placeLocation = widget.placeModel?.address ?? '';
     }
  }

  @override
  Widget build(BuildContext context) {
      
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      child: TypeAheadField<PlaceModel>(
      builder: (_, controller, focusNode) {
         controller.text = placeLocation;
          var border = OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(style: BorderStyle.none)
                  );
                  
          return TextField(
                focusNode: focusNode,
                controller: controller,
                onChanged: (String value){
                     placeLocation = value;
                },
                decoration: InputDecoration(
                  prefix: const Icon(Icons.location_on),
                  hintText: 'Insira um endereço',
                  border: border,
                  errorBorder: border,
                  focusedBorder: border
                ),
              );
      },
        itemBuilder: (context,placeModel){
          return ItemTile(address: placeModel.address);
        }, 
        onSelected: _onSelected, 
        suggestionsCallback: _suggestionsCallback
        ),
    );
  }

  void _onSelected( PlaceModel place){
    placeLocation = place.address;
   widget.addressSelectedCallback(place);
  }

  Future<List<PlaceModel>> _suggestionsCallback(String search) async{
      if(search.isNotEmpty){
         return await controller.findAdress(search);
      }
      return <PlaceModel>[];
    }
}

 
class ItemTile extends StatelessWidget {

   final String address;
   final VoidCallback? onTap; 
  const ItemTile({super.key,required this.address , this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const Icon(Icons.location_on),
      title: Text(address),
    );
  }
}