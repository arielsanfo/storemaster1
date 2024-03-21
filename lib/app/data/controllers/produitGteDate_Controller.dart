import 'package:objectbox/objectbox.dart';
import 'package:ArielSchool/app/data/modal.dart';

class ProduitQuantiteDateStore {
  final Store _store;

  ProduitQuantiteDateStore(this._store);

  Future<int> ajouterProduitQuantiteDate(
      ProduitQuantiteDate produitQuantiteDate) async {
    final box = _store.box<ProduitQuantiteDate>();
    return box.put(produitQuantiteDate);
  }

  Future<bool> modifierProduitQuantiteDate(
      ProduitQuantiteDate produitQuantiteDate) async {
    final box = _store.box<ProduitQuantiteDate>();
    return box.put(produitQuantiteDate) > 0;
  }

  Future<bool> supprimerProduitQuantiteDate(int id) async {
    final box = _store.box<ProduitQuantiteDate>();
    return box.remove(id);
  }

  Future<ProduitQuantiteDate?> getProduitQuantiteDateById(int id) async {
    final box = _store.box<ProduitQuantiteDate>();
    return box.get(id);
  }

  Future<List<ProduitQuantiteDate>> getAllProduitQuantiteDates() async {
    final box = _store.box<ProduitQuantiteDate>();
    return box.getAll();
  }
}
