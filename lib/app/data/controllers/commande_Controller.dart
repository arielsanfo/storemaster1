import 'package:ArielSchool/app/data/controllers/inventaire_Controller.dart';
import 'package:ArielSchool/app/data/modal.dart';
import 'package:ArielSchool/main.dart';
import 'package:ArielSchool/objectbox.g.dart';

class CommandeStore {
  final Store _store;
  IventaireStore inventaireStore = IventaireStore(objectbox.store);

  CommandeStore(this._store);

  Future<int> ajouterCommande(Commande commande) async {
    final box = _store.box<Commande>();
    return box.put(commande);
  }

  Future<bool> modifierCommande(Commande commande) async {
    final box = _store.box<Commande>();
    return box.put(commande) > 0;
  }

  Future<bool> supprimerCommande(int id) async {
    final box = _store.box<Commande>();
    return box.remove(id);
  }

  Future<Commande?> getCommandeById(int id) async {
    final box = _store.box<Commande>();
    return box.get(id);
  }

  Future<List<Commande>> getAllCommandes() async {
    final box = _store.box<Commande>();
    return box.getAll();
  }

  Future<List<Commande>> rechercherCommandesParPlageDeDates(
      DateTime dateDebut, DateTime dateFin) async {
    final box = _store.box<Commande>();
    final commandes = box
        .query(Commande_.dateDeCommande
            .greaterOrEqual(dateDebut.millisecond)
            .and(Commande_.dateDeCommande.lessOrEqual(dateFin.millisecond)))
        .build()
        .find();
    return commandes;
  }

  Future<double> calculerMontantTotalCommande(int id) async {
    final box = _store.box<Commande>();
    final commande = box.get(id);
    if (commande != null) {
      double total = 0;
      for (var produitQuantite in commande.produitsEtDate) {
        final produit = produitQuantite.produit.target;
        if (produit != null) {
          total += (produit.prix_Vente ?? 0) * (produitQuantite.quantite ?? 0);
        }
      }
      return total;
    }
    return 0;
  }

// Dans le fichier commande_Controller.dart

  Future<void> verifierProduitsEtAugmenterQuantite(Commande commande) async {
    final inventaireStore = IventaireStore(_store);
    final produitsCommande =
        commande.produitsEtDate.map((pd) => pd.produit.target?.libele).toSet();
    final inventaires = inventaireStore.getAllIventaires();

    for (var inventaire in inventaires) {
      print("la bouble de l'inventaire tourne");
      for (var produitQuantite in inventaire.produitsEtQuantite) {
        print("la boucle des produit de l'inventaire tourne");
        if (produitsCommande.contains(produitQuantite.produit.target?.libele)) {
          print(
              "on a trouvé que ${produitQuantite.produit.target!.libele} se trouve dans l'inventaire");
          produitQuantite.quantite = (produitQuantite.quantite ?? 0) + 1;

          bool fait = await inventaireStore.modifierIventaire(inventaire);
          print(
              "l'inventaire modifié est le ${inventaire.id} la valeur de l'operation est $fait");
          print("L'inventaire a bien été modifié");
          print(
              "${inventaire.produitsEtQuantite[0].produit.target!.libele} ${inventaire.produitsEtQuantite[0].quantite}");
        }
      }
    }
  }

  void ajouterCommandeAInventaire(Commande commande, Iventaire inventaire) {
    for (var produitQuantiteCommande in commande.produitsEtDate) {
      var produitQuantiteInventaire = inventaire.produitsEtQuantite.firstWhere(
          (pq) => pq.id == produitQuantiteCommande.id,
          orElse: () => ProduitQuantite(quantite: 1000000000));

      if (produitQuantiteInventaire.quantite != 1000000000) {
        produitQuantiteInventaire.quantite =
            produitQuantiteInventaire.quantite! +
                produitQuantiteCommande.quantite!;
        produitQuantiteInventaire.produit.target =
            produitQuantiteCommande.produit.target;

        inventaireStore.modifierIventaire(inventaire);
        print("le produit a été modifié");
      } else {
        inventaire.produitsEtQuantite.add(produitQuantiteCommande);
        inventaireStore.modifierIventaire(inventaire);
        print("le produit a été ajouté");
      }
    }
  }

//   void ajouterCommandeAInventaire(Commande commande, Iventaire inventaire) {
//   for (var produitQuantiteCommande in commande.produitsEtDate) {
//     var produitQuantiteInventaire = inventaire.produitsEtQuantite
//         .firstWhere((pq) => pq.id == produitQuantiteCommande.id, orElse: () => null);

//     if (produitQuantiteInventaire != null) {
//       produitQuantiteInventaire.quantite! += produitQuantiteCommande.quantite!;
//     } else {
//       inventaire.produitsEtQuantite.add(produitQuantiteCommande);
//     }
//   }
// }
}
