import 'package:ArielSchool/app/data/modal.dart';
import 'package:ArielSchool/objectbox.g.dart';

class ProduitStore {
  final Store _store;

  ProduitStore(this._store);

  List<Produit> getAllProduitOrder() {
    final box = _store.box<Produit>();
    List<Produit> produits = box.getAll();
    produits.sort(
        (a, b) => a.libele!.toLowerCase().compareTo(b.libele!.toLowerCase()));
    return produits;
  }

  List<Produit> getAllProduit() {
    final box = _store.box<Produit>();
    return box.getAll();
  }

  Produit? getProduitById(int id) {
    final box = _store.box<Produit>();
    return box.get(id);
  }

  // Ajout, modification, suppression
  Future<int> ajouterProduit(Produit produit) async {
    final box = _store.box<Produit>();
    return box.put(produit);
  }

  Future<bool> modifierProduit(Produit produit) async {
    final box = _store.box<Produit>();
    return box.put(produit) > 0;
  }

  Future<bool> supprimerProduit(int id) async {
    final box = _store.box<Produit>();
    return box.remove(id);
  }

  Future<List<Produit>> rechercherProduitsParNom(String nom) async {
    final box = _store.box<Produit>();
    final produits = box
        .query(Produit_.libele.contains(nom, caseSensitive: false))
        .build()
        .find();
    return produits;
  }
}
