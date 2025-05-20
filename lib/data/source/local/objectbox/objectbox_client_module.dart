import 'package:cache_storage_demo/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

abstract class ObjectBoxClientModule {
  Future<Store> makeObjectBoxInstance() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: p.join(docsDir.path, 'objectbox_cache'),
    );

    return store;
  }
}
