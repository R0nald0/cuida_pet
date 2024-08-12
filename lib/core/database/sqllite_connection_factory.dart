
import 'dart:async';
import 'package:cuidapet/core/database/sqllite_migrations_factory.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class SqlliteConnectionFactory {
   static const _version = 1;
   static const _databaseName = 'CUIDAPET_LOCAL_DB';
   static SqlliteConnectionFactory? _instance;
   Database? _db;      
   final _lock =Lock();

 SqlliteConnectionFactory._();

  factory SqlliteConnectionFactory(){
    _instance??= SqlliteConnectionFactory._();
    return _instance!;
  }

  Future<Database> openConnection() async{
    if (_db == null) {
       await _lock.synchronized(() async{
           if (_db ==null) {
             final dataBasePath = await getDatabasesPath();
             final pathDatabe = join(dataBasePath,_databaseName);
             _db = await openDatabase(
              pathDatabe,
              version: _version,
              onCreate: _onCreate,
              onConfigure: _onConfigure,
              onUpgrade: _onUpgrade,

              );
           }
       });
    }
    return _db!;
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
      final batch = db.batch();
    final migrations = SqlliteMigrationsFactory().getUpdateMigrations(oldVersion);

    for (var migration in migrations) {
       migration.update(batch);
    }
    batch.commit();

  }

  FutureOr<void> _onConfigure(Database db)  async{
          await db.execute('PRAGMA foreign_keys = ON');
  }

  FutureOr<void> _onCreate(Database db, int version)  async {
    final batch = db.batch();
    final migrations = SqlliteMigrationsFactory().getCreateMigrations();

    for (var migration in migrations) {
       migration.create(batch);
    }
    batch.commit();
  }

  void closeConnection() {
     _db?.close();
    _db = null;
  }
}