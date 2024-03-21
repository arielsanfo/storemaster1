import 'package:ArielSchool/app/data/modal.dart';
import 'package:ArielSchool/objectbox.g.dart';

class DetteStore {
  final Store _store;

  DetteStore(this._store);

  Future<int> ajouterDette(Dette dette) async {
    final box = _store.box<Dette>();
    return box.put(dette);
  }

  Future<bool> modifierDette(Dette dette) async {
    final box = _store.box<Dette>();
    return box.put(dette) > 0;
  }

  Future<bool> supprimerDette(int id) async {
    final box = _store.box<Dette>();
    return box.remove(id);
  }

  Future<Dette?> getDetteById(int id) async {
    final box = _store.box<Dette>();
    return box.get(id);
  }

  List<Dette> getAllDettes() {
    final box = _store.box<Dette>();
    return box.getAll();
  }

  Future<List<Dette>> rechercherDettesParNomClient(String nom) async {
    final box = _store.box<Dette>();
    final dettes = box.getAll();
    return dettes
        .where((dette) =>
            dette.client.target?.nom?.toLowerCase() == nom.toLowerCase())
        .toList();
  }

  double calculerMontantTotalDette(Dette dette) {
    // ignore: unnecessary_null_comparison
    if (dette != null) {
      double total = 0;
      for (var produitQuantiteDate in dette.produitsEtQteEtDate) {
        final produit = produitQuantiteDate.produit.target;
        if (produit != null) {
          total +=
              (produit.prix_Vente ?? 0) * (produitQuantiteDate.quantite ?? 0);
        }
      }
      return total;
    }
    return 0;
  }
}
