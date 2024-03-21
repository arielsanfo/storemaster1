import 'package:ArielSchool/app/data/controllers/produit_Controller.dart';
import 'package:ArielSchool/app/data/modal.dart';
import 'package:ArielSchool/main.dart';
import 'package:ArielSchool/objectbox.g.dart';

class IventaireStore {
  final Store _store;
  ProduitStore produitController = ProduitStore(objectbox.store);
  IventaireStore(this._store);

  Future<int> ajouterIventaire(Iventaire inventaire) async {
    final box = _store.box<Iventaire>();
    return box.put(inventaire);
  }

  Future<bool> modifierIventaire(Iventaire inventaire) async {
    final box = _store.box<Iventaire>();
    return box.put(inventaire) > 0;
  }

  Future<bool> supprimerIventaire(int id) async {
    final box = _store.box<Iventaire>();
    return box.remove(id);
  }

  // Dans le fichier inventaire_Controller.dart

  Iventaire? getIventaireById(int id) {
    final inventaire = _store.box<Iventaire>().get(id);
    if (inventaire != null) {
      fusionnerProduitQuantiteDoubles(inventaire);
    }
    return inventaire;
  }

  List<Iventaire> getAllIventaires() {
    final inventaires = _store.box<Iventaire>().getAll();
    for (var inventaire in inventaires) {
      fusionnerProduitQuantiteDoubles(inventaire);
    }
    return inventaires;
  }

  double calculerMontantTotalInventaire(Iventaire inventaire) {
    double total = 0;
    for (var produitQuantite in inventaire.produitsEtQuantite) {
      final produit = produitQuantite.produit.target;
      if (produit != null) {
        total += (produit.prix_Vente ?? 0) * (produitQuantite.quantite ?? 0);
      }
    }
    return total;
  }

  Future<List<Iventaire>> rechercherInventairesParPlageDeDates(
      DateTime dateDebut, DateTime dateFin) async {
    final box = _store.box<Iventaire>();
    final inventaires = box
        .query(Iventaire_.dateDeDecompte
            .greaterOrEqual(dateDebut.millisecond)
            .and(Iventaire_.dateDeDecompte.lessOrEqual(dateFin.millisecond)))
        .build()
        .find();
    return inventaires;
  }

  // Dans le fichier inventaire_Controller.dart

// Dans le fichier inventaire_Controller.dart

  void fusionnerProduitQuantiteDoubles(Iventaire inventaire) {
    final produitsQuantiteMap = <int, int>{};
    final produitsMap = <int, Produit>{};

    // Regrouper les quantités de produits par leur ID
    for (var produitQuantite in inventaire.produitsEtQuantite) {
      final produitId = produitQuantite.produit.target?.id;
      if (produitId != null) {
        produitsQuantiteMap.update(
            produitId, (value) => value + (produitQuantite.quantite ?? 0),
            ifAbsent: () => produitQuantite.quantite ?? 0);
        produitsMap[produitId] = produitQuantite.produit.target!;
      }
    }

    // Créer de nouveaux objets ProduitQuantite à partir des données regroupées
    final newProduitsQuantiteList = produitsQuantiteMap.entries
        .map((entry) => ProduitQuantite()
          ..produit.target = produitsMap[entry.key]
          ..quantite = entry.value)
        .toList();

    // Remplacer les anciens objets ProduitQuantite par les nouveaux
    inventaire.produitsEtQuantite.clear();
    inventaire.produitsEtQuantite.addAll(newProduitsQuantiteList);
  }

  bool verifierProduitDansInventaire(String nomProduit) {
    // Récupérer tous les inventaires
    final inventaires = getAllIventaires();

    // Parcourir chaque inventaire
    for (var inventaire in inventaires) {
      // Vérifier si le nom du produit se trouve dans cet inventaire
      for (var produitQuantite in inventaire.produitsEtQuantite) {
        if (produitQuantite.produit.target?.libele == nomProduit) {
          return true;
        }
      }
    }

    return false;
  }
}
