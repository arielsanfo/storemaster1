import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:ArielSchool/objectbox.g.dart';

class ObjectBox {
  // base de données de l'application
  late final Store store;

  ObjectBox._create(this.store) {
    //code d'initialisation de la base de données si necessaire
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();

    final store = await openStore(directory: p.join(docsDir.path, "mystore"));
    return ObjectBox._create(store);
  }
}
