import 'package:objectbox/objectbox.dart';
import 'package:ArielSchool/app/data/modal.dart';

class ProduitQuantiteStore {
  final Store _store;

  ProduitQuantiteStore(this._store);

  Future<int> ajouterProduitQuantite(ProduitQuantite produitQuantite) async {
    final box = _store.box<ProduitQuantite>();
    return box.put(produitQuantite);
  }

  Future<bool> modifierProduitQuantite(ProduitQuantite produitQuantite) async {
    final box = _store.box<ProduitQuantite>();
    return box.put(produitQuantite) > 0;
  }

  Future<bool> supprimerProduitQuantite(int id) async {
    final box = _store.box<ProduitQuantite>();
    return box.remove(id);
  }

  Future<ProduitQuantite?> getProduitQuantiteById(int id) async {
    final box = _store.box<ProduitQuantite>();
    return box.get(id);
  }

  Future<List<ProduitQuantite>> getAllProduitQuantites() async {
    final box = _store.box<ProduitQuantite>();
    return box.getAll();
  }
}
