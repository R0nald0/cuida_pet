import 'package:cuidapet/core/database/migration/migration.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../constants.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
          CREATE TABLE ${Constants.tableName}(
            id integer primary key autoincrement,
            address text not null,
            lat text,
            long text,
            addtional text
            )
         ''');
  }

  @override
  void update(Batch batch) {
    // TODO: implement update
  }
}
