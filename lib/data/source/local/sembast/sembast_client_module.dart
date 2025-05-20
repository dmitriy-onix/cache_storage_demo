import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

abstract class SembastClientModule {
  Future<Database> makeSembastInstance() async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);

    final dbPath = p.join(appDir.path, 'sembast_cache.db');
    final db = await databaseFactoryIo.openDatabase(dbPath);
    return db;
  }
}
