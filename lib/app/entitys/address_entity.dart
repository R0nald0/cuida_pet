
import 'dart:convert';

class AddressEntity {
  final int? id;
  final String? address;
  final double? lat;
  final double? long;
  final String? addtional;

  AddressEntity({this.id, this.address, this.lat, this.long, this.addtional});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'lat': lat.toString(),
      'long': long.toString(),
      'addtional': addtional,
    };
  }

  factory AddressEntity.fromMap(Map<String, dynamic> map) {
    return AddressEntity(
      id: map['id'],
      address: map['address'],
      lat: double.parse(map['lat'] ?? '0.0') ,
      long: double.parse(map['long'] ?? '0.0'),
      addtional: map['addtional'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressEntity.fromJson(String source) =>
      AddressEntity.fromMap(json.decode(source));

  AddressEntity copyWith({
    int? id,
    String? address,
    double? lat,
    double? long,
    String? addtional,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      addtional: addtional ?? this.addtional,
    );
  }
}
