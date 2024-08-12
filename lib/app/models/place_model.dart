class PlaceModel {
   final String address;
   final double lat;
   final double long;
  PlaceModel({
    required this.address,
    required this.lat,
    required this.long,
  });

  @override
  String toString() => 'PlaceModel(address: $address, lat: $lat, long: $long)';
}
