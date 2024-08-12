import 'package:cuidapet/app/entitys/address_entity.dart';
import 'package:cuidapet/app/models/place_model.dart';
import 'package:cuidapet/app/repository/address/address_repository.dart';
import 'package:cuidapet/core/constants.dart';
import 'package:cuidapet/core/database/sqllite_connection_factory.dart';
import 'package:cuidapet/core/exceptions/failure.dart';
import 'package:cuidapet/core/helpers/enviroments.dart';
import 'package:google_places/google_places.dart';

class AddressRepositoryImpl implements AddressRepository {
  final SqlliteConnectionFactory sqlliteConnectionFacotory;
  AddressRepositoryImpl({required SqlliteConnectionFactory sqliteCont})
      : sqlliteConnectionFacotory = sqliteCont;

  @override
  Future<List<PlaceModel>> findAddressByGoogle(String address) async {
    final googleApiKey = Enviroments.params('google_api_key');
    

    if (googleApiKey == null) {
      throw Failure(message: 'erro ao buscar google api key');
    }

    final googlePlace = GooglePlaces(googleApiKey);
    final addresResult = await googlePlace.search.getTextSearch(address);
    final candidates = addresResult?.results;

    if (candidates != null) {
      return candidates.map((searchResult) {
        final location = searchResult.geometry?.location;
        final address = searchResult.formattedAddress;
        return PlaceModel(
            address: address ?? '',
            lat: location?.lat ?? 0,
            long: location?.lng ?? 0);
      }).toList();
    }

    return <PlaceModel>[];
  }

  @override
  Future<void> deleteAll() async {
    final sqlConnec = await sqlliteConnectionFacotory.openConnection();
    sqlConnec.delete(Constants.tableName);
  }

  @override
  Future<List<AddressEntity>> getAddressEntitys() async {
    final sqlConnec = await sqlliteConnectionFacotory.openConnection();
    final result = await sqlConnec.rawQuery('SELECT *FROM ${Constants.tableName}');

    return result.map((e) => AddressEntity.fromMap(e)).toList();
  }

  @override
  Future<int> saveAddress(AddressEntity addressEntity) async {
    final sqlConnec = await sqlliteConnectionFacotory.openConnection();
   return sqlConnec.rawInsert('INSERT INTO ${Constants.tableName} VALUES(?,?,?,?,?)', [
      null,
      addressEntity.address,
      addressEntity.lat,
      addressEntity.long,
      addressEntity.addtional
    ]);
  }
}
