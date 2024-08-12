
import 'package:cuidapet/core/database/migration/migration_v1.dart';

import 'migration/migration.dart';

class SqlliteMigrationsFactory {
  
   List<Migration> getCreateMigrations()=>[
    MigrationV1()
   ];

   List<Migration> getUpdateMigrations(int version)=>[];
}